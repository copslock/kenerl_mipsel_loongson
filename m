Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Apr 2009 05:20:43 +0100 (BST)
Received: from webmail.ict.ac.cn ([159.226.39.7]:12989 "EHLO ict.ac.cn")
	by ftp.linux-mips.org with ESMTP id S20021763AbZDAEUi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Apr 2009 05:20:38 +0100
Received: (qmail 8274 invoked by uid 507); 1 Apr 2009 12:33:27 +0800
Received: from unknown (HELO localhost.localdomain) (fxzhang@10.2.0.23)
  by ict.ac.cn with SMTP; 1 Apr 2009 12:33:27 +0800
Message-ID: <49D2EB62.601@ict.ac.cn>
Date:	Wed, 01 Apr 2009 12:19:46 +0800
From:	fxzhang <fxzhang@ict.ac.cn>
User-Agent: Mozilla-Thunderbird 2.0.0.9 (X11/20080110)
MIME-Version: 1.0
To:	zhangfx@lemote.com, gnewsense-dev@nongnu.org,
	linux-mips@linux-mips.org, loongson@bjlx.org.cn,
	"yanh@lemote.com >> 'yanhua'" <yanh@lemote.com>
Subject: Re: yeloong or yeeloong
References: <15359.159.226.43.42.1238459390.squirrel@mail.lemote.com> <20090331175252.GB4918@adriano.hkcable.com.hk>
In-Reply-To: <20090331175252.GB4918@adriano.hkcable.com.hk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22225
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips

It should be Yeeloong, any yeloong will be a mistake.

I will require our guys to take actions to correct it. As for your 
patch, Yanhua is working on merging it into newest linux/mips tree and 
push it upstream, he is some what slow due to too much work.

Thank you for your support and work on Loongson.

Best Regards
Zhang Le 写道:
> Sorry for cross posting, but I just want to bring this issue to a wider
> audience.
>
> Maybe I am not the one who should be worried about this. But since more and
> more people will get these machines, we should settle it down as early as
> possible.
>
> This is a bikeshedding problem[1], so _everyone_ is welcome to comment.
>
> First of all, this problem is first discovered by Liu Shiwei, the manager of
> Beijing Loongson Club. If you search 'yeloong', this post will appear in the
> first page:
> http://www.lemote.com/bbs/redirect.php?tid=21768&goto=lastpost
>
> Then, I have proposed a naming convention change to lemote. That was a patch
> which I didn't post it to a public mailing list. But you can get it here:
> http://repo.or.cz/w/linux-2.6/linux-loongson.git?a=shortlog;h=refs/heads/lemote-naming-convention
> In that patch, I sugguest keep fuloong, but call the notebook yeeloong instead
> of yeloong.
>
> The following are the rationales behind my suggestions:
>
>   1. Fulong -> Fuloong.
>
>     This one is good. For those who has a box, please cat your /proc/cpuinfo.
>     It should still be fulong. And I believe the fulong should be a typo.
>
>   2. Yeeloong -> Yeloong. 
>
>     I think this one is controversial. The e in Yeloong, to me, sounds like e
>     in yes, not ee in eel. So that the sound is changed, this action is by
>     itself bad. And Yeloong may make people connect it with the word yell,
>     which is not quite good a word. Moreover, the original sound is more like 
>     its Chinese brand name.
>
> And, recently I have just noticed that at the long long last lemote is going
> to push Loongson 2F patches to upstream, which is good. However, I found the
> notebook's name is still yeloong:
> http://dev.lemote.com/git?p=linux_loongson.git;a=shortlog;h=refs/heads/to-mips
>
> So, I hope lemote could seriously take my suggestion in consideration. And if my
> suggestion were rejected, please give your reason behind the rejection.
>
> Thanks for everyone's time!
>
> Zhang, Le
> http://zhangle.is-a-geek.org
>
> [1] http://en.wikipedia.org/wiki/Color_of_the_bikeshed
>
>   
