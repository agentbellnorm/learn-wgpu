use wgpu_tutorial::run;
use pollster;

fn main() {
    pollster::block_on(run());
}
