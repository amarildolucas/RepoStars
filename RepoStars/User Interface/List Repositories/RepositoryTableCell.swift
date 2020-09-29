//
//  RepositoryTableCell.swift
//  RepoStars
//
//  Created by Amarildo Lucas on 24/09/20.
//

import SnapKit
import UIKit

// MARK: - RepositoryTableCell
class RepositoryTableCell: UITableViewCell {
	lazy var avatarImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.accessibilityLabel = "Avatar Image"
		imageView.image = UIImage(systemName: "person.circle.fill")
		imageView.contentMode = .scaleAspectFit
		imageView.clipsToBounds = true

		return imageView
	}()

	lazy var ownerNameLabel: UILabel = {
		let label = UILabel()
		label.accessibilityLabel = "Owner Name"
		label.font = UIFont.preferredFont(forTextStyle: .subheadline)
		label.textColor = .secondaryLabel
		label.numberOfLines = 1

		return label
	}()

	lazy var nameLabel: UILabel = {
		let label = UILabel()
		label.accessibilityLabel = "Repository Name"
		label.font = UIFont.preferredFont(forTextStyle: .headline)
		label.textColor = .label
		label.numberOfLines = 1

		return label
	}()

	lazy var starsLabel: UILabel = {
		let label = UILabel()
		label.accessibilityLabel = "Stars"
		label.font = UIFont.preferredFont(forTextStyle: .body)
		label.textColor = .secondaryLabel
		label.numberOfLines = 1

		return label
	}()

	var repository: Repository!

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		layoutViews()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)

		layoutViews()
	}

	override func prepareForReuse() {
		ownerNameLabel.text = nil
		nameLabel.text = nil
		starsLabel.text = nil
		imageView?.image = nil

		super.prepareForReuse()
	}

	func configure(with repository: Repository) {
		ownerNameLabel.text = repository.owner.login
		nameLabel.text = repository.name
		starsLabel.text = "⭐️ \(repository.stargazersCount)"

		let url = URL(string: repository.owner.avatarUrl)

		DispatchQueue.global().async {
			if let url = url, let data = try? Data(contentsOf: url) {
				DispatchQueue.main.async {
					self.avatarImageView.image = UIImage(data: data)
				}
			}
		}
	}
}

// MARK: - Lifecycle
extension RepositoryTableCell {
	private func layoutViews() {
		selectionStyle = .none
		backgroundColor = .secondarySystemBackground

		addSubview(avatarImageView)
		avatarImageView.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(16.0)
			make.width.height.equalTo(44.0)
			make.centerY.equalToSuperview().offset(-8.0)
		}

		avatarImageView.layer.cornerRadius = 22.0

		addSubview(ownerNameLabel)
		ownerNameLabel.snp.makeConstraints { make in
			make.leading.equalTo(avatarImageView.snp.trailing).offset(16.0)
			make.top.equalToSuperview().offset(24.0)
			make.trailing.equalToSuperview().offset(-16.0)
		}

		addSubview(nameLabel)
		nameLabel.snp.makeConstraints { make in
			make.leading.equalTo(avatarImageView.snp.trailing).offset(16.0)
			make.top.equalTo(ownerNameLabel.snp.bottom).offset(8.0)
			make.trailing.equalToSuperview().offset(-16.0)
		}

		addSubview(starsLabel)
		starsLabel.snp.makeConstraints { make in
			make.leading.equalTo(avatarImageView.snp.trailing).offset(16.0)
			make.top.equalTo(nameLabel.snp.bottom).offset(16.0)
			make.trailing.equalToSuperview().offset(-16.0)
		}
	}
}
