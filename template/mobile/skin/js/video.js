
$('.course-wrap').on('click', '.course-tab div', function(event) {
  if ($(this).hasClass('active')) {return;}
  $(this).addClass('active').siblings().removeClass('active');
  $('.course-tab-div[data-index="'+$(this).attr('data-index')+'"]').show().siblings('.course-tab-div').hide();
}).on('click', '.course-check-btn', function(event) {
  var code = $('#coursecode').val();
  
  UseCourseCode(code);
});
$('.course-list').on('click', 'li', function(event) {
  // if ($(this).hasClass('active')) {return};
  // if ($(this).hasClass('updating')) {alertTip('课程正在更新中，敬请期待');return};
  $(this).addClass('active').siblings().removeClass('active');
  var id=$(this).attr('data-id');
  var isbuy=$('.video-period-price').attr('data-buy');
  var islimit=$(this).attr('data-limit');
  var limitRecord=islimit*60;
  var hash=$(this).attr('data-index');
  if(isbuy){
    if(islimit){
      $('.jw-video-expense').hide();
      videojs('my-video',{},function(){
         getVideoUrl(id);
        myPlayer.on('timeupdate',function(){
          if(myPlayer.currentTime()>limitRecord){
            myPlayer.exitFullscreen();
            $('.jw-video-expense').show();
            this.pause();
          }
        })
      })
      
    }else{
      $('.jw-video-expense').show();
      myPlayer.pause();
    }
  }else{
    $('.jw-video-expense').hide();
    if(hash==0){
      history.replaceState(null,'',location.pathname+location.search);
    }else{
      window.location.hash=hash;
    }
    videojs('my-video',{},function(){
       getVideoUrl(id);
    })
  }
 
});
