import AetherLibavcodec

// FFmpegBuild 3.14.0 ships a header whose video codec numbers are one higher than the library
// compiled beside it (the header says HEVC is 173, the library calls it 172). Every comparison
// against the header's number then fails, and HEVC, AV1 and VP9 were all taken for "a codec the
// native route does not carry", so they played on the software host. The names below shadow the
// header's constants inside this module with the numbers the library itself answers to.
private func library(_ name: String, header: UInt32) -> AVCodecID {
    avcodec_descriptor_get_by_name(name)?.pointee.id ?? AVCodecID(rawValue: header)
}

let AV_CODEC_ID_HEVC = library("hevc", header: 173)
let AV_CODEC_ID_AV1 = library("av1", header: 225)
let AV_CODEC_ID_VP9 = library("vp9", header: 167)
