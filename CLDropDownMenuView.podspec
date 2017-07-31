Pod::Spec.new do |s|
  s.name         = "CLDropDownMenuView"
  s.version      = "1.0.0"
  s.summary      = "高可定制下拉菜单"
  s.homepage     = "https://github.com/qcl901028/CLDropDownMenuView"
  s.license = { :type => 'Apache License, Version 2.0', :text => <<-LICENSE
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
LICENSE
}
  s.platform     = :ios, '8.0'
  s.authors      = { "秦传龙" => "qcl901028@gmail.com"}
  s.source       = { :git => "https://github.com/qcl901028/CLDropDownMenuView.git", :tag => s.version}
  s.source_files  = 'DropDownMenuView/**/*.{h,m,xib}'
  s.resource    = 'DropDownMenuView/DropDownMenuView.bundle'
  s.requires_arc = true
end
