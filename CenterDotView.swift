import UIKit

public final class CenterDotView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    private func configure() {
        backgroundColor = .clear
        isUserInteractionEnabled = false
        isOpaque = false
    }

    public override func draw(_ rect: CGRect) {
        UIColor.black.setFill()
        UIBezierPath(
            ovalIn: CGRect(
                x: (bounds.width - 3) / 2,
                y: (bounds.height - 3) / 2,
                width: 3,
                height: 3
            )
        ).fill()
    }
}