
Pod::Spec.new do |s|

  s.name         = "GJWenger"
  s.version      = "0.0.1"
  s.summary      = "这是工具类库，名字来源于世界上最著名的瑞士军刀品牌wenger，表明了工具类库的强大功能"
  s.license      = "erliangzi"
  s.platform     = :ios, "7.0"
  s.source_files  = "GJWenger/**/*.{h,m,c}", "GJWenger/Foundation/**/*.{h,m,c}", "GJWenger/UIKit/**/*.{h,m,c}", "GJWenger/Others/**/*.{h,m,c}", "GJWenger/BasicClass/**/*.{h,m,c}"
  s.resources = "GJWenger/Resources/**/*.{png,jpg,ttf}", "GJWenger/UIKit/**/*.xib"

end
