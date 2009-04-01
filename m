Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Apr 2009 10:38:02 +0100 (BST)
Received: from pyxis.i-cable.com ([203.83.115.105]:3236 "HELO
	pyxis.i-cable.com") by ftp.linux-mips.org with SMTP
	id S20031854AbZDAJht (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Apr 2009 10:37:49 +0100
Received: (qmail 12971 invoked by uid 104); 1 Apr 2009 09:30:54 -0000
Received: from 203.83.114.122 by pyxis (envelope-from <robert.zhangle@gmail.com>, uid 101) with qmail-scanner-2.01 
 (clamdscan: 0.93.3/7733.  
 Clear:RC:1(203.83.114.122):. 
 Processed in 0.186423 secs); 01 Apr 2009 09:30:54 -0000
Received: from ip114122.hkicable.com (HELO xenon.i-cable.com) (203.83.114.122)
  by 0 with SMTP; 1 Apr 2009 09:30:53 -0000
Received: from localhost (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by xenon.i-cable.com (8.13.5/8.13.5) with ESMTP id n319Ulb0002139;
	Wed, 1 Apr 2009 17:30:51 +0800 (CST)
Date:	Wed, 1 Apr 2009 17:30:35 +0800
From:	Zhang Le <r0bertz@gentoo.org>
To:	fxzhang <fxzhang@ict.ac.cn>
Cc:	zhangfx@lemote.com, gnewsense-dev@nongnu.org,
	linux-mips@linux-mips.org, loongson@bjlx.org.cn,
	"yanh@lemote.com >> 'yanhua'" <yanh@lemote.com>
Subject: Re: yeloong or yeeloong
Message-ID: <20090401093034.GA28319@adriano.hkcable.com.hk>
Mail-Followup-To: fxzhang <fxzhang@ict.ac.cn>, zhangfx@lemote.com,
	gnewsense-dev@nongnu.org, linux-mips@linux-mips.org,
	loongson@bjlx.org.cn,
	"yanh@lemote.com >> 'yanhua'" <yanh@lemote.com>
References: <15359.159.226.43.42.1238459390.squirrel@mail.lemote.com> <20090331175252.GB4918@adriano.hkcable.com.hk> <49D2EB62.601@ict.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49D2EB62.601@ict.ac.cn>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <robert.zhangle@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22226
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips

On 12:19 Wed 01 Apr     , fxzhang wrote:
> It should be Yeeloong, any yeloong will be a mistake.

Thanks for clearing this up.

Zhang, Le
http://zhangle.is-a-geek.org

>
> I will require our guys to take actions to correct it. As for your  
> patch, Yanhua is working on merging it into newest linux/mips tree and  
> push it upstream, he is some what slow due to too much work.
>
> Thank you for your support and work on Loongson.
>
> Best Regards
> Zhang Le 写道:
>> Sorry for cross posting, but I just want to bring this issue to a wider
>> audience.
>>
>> Maybe I am not the one who should be worried about this. But since more and
>> more people will get these machines, we should settle it down as early as
>> possible.
>>
>> This is a bikeshedding problem[1], so _everyone_ is welcome to comment.
>>
>> First of all, this problem is first discovered by Liu Shiwei, the manager of
>> Beijing Loongson Club. If you search 'yeloong', this post will appear in the
>> first page:
>> http://www.lemote.com/bbs/redirect.php?tid=21768&goto=lastpost
>>
>> Then, I have proposed a naming convention change to lemote. That was a patch
>> which I didn't post it to a public mailing list. But you can get it here:
>> http://repo.or.cz/w/linux-2.6/linux-loongson.git?a=shortlog;h=refs/heads/lemote-naming-convention
>> In that patch, I sugguest keep fuloong, but call the notebook yeeloong instead
>> of yeloong.
>>
>> The following are the rationales behind my suggestions:
>>
>>   1. Fulong -> Fuloong.
>>
>>     This one is good. For those who has a box, please cat your /proc/cpuinfo.
>>     It should still be fulong. And I believe the fulong should be a typo.
>>
>>   2. Yeeloong -> Yeloong. 
>>
>>     I think this one is controversial. The e in Yeloong, to me, sounds like e
>>     in yes, not ee in eel. So that the sound is changed, this action is by
>>     itself bad. And Yeloong may make people connect it with the word yell,
>>     which is not quite good a word. Moreover, the original sound is 
>> more like     its Chinese brand name.
>>
>> And, recently I have just noticed that at the long long last lemote is going
>> to push Loongson 2F patches to upstream, which is good. However, I found the
>> notebook's name is still yeloong:
>> http://dev.lemote.com/git?p=linux_loongson.git;a=shortlog;h=refs/heads/to-mips
>>
>> So, I hope lemote could seriously take my suggestion in consideration. And if my
>> suggestion were rejected, please give your reason behind the rejection.
>>
>> Thanks for everyone's time!
>>
>> Zhang, Le
>> http://zhangle.is-a-geek.org
>>
>> [1] http://en.wikipedia.org/wiki/Color_of_the_bikeshed
>>
>>   
>
>
>
