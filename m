Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Apr 2009 02:46:56 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:6086 "EHLO lemote.com")
	by ftp.linux-mips.org with ESMTP id S20021796AbZDABqv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 1 Apr 2009 02:46:51 +0100
Received: from localhost (localhost [127.0.0.1])
	by lemote.com (Postfix) with ESMTP id F1E5D340B6;
	Wed,  1 Apr 2009 09:44:11 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from lemote.com ([127.0.0.1])
	by localhost (www.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fqRgAFm3kBxa; Wed,  1 Apr 2009 09:44:06 +0800 (CST)
Received: from [127.0.0.1] (unknown [222.92.8.142])
	by lemote.com (Postfix) with ESMTP id 3B97B3409D;
	Wed,  1 Apr 2009 09:44:06 +0800 (CST)
Message-ID: <49D2C77E.4090105@lemote.com>
Date:	Wed, 01 Apr 2009 09:46:38 +0800
From:	yanhua <yanh@lemote.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	zhangfx@lemote.com, gnewsense-dev@nongnu.org,
	linux-mips@linux-mips.org, loongson@bjlx.org.cn, yanh@lemote.com
Subject: Re: yeloong or yeeloong
References: <15359.159.226.43.42.1238459390.squirrel@mail.lemote.com> <20090331175252.GB4918@adriano.hkcable.com.hk>
In-Reply-To: <20090331175252.GB4918@adriano.hkcable.com.hk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <yanh@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22224
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yanh@lemote.com
Precedence: bulk
X-list: linux-mips

There are really yeloong and yeeloong fix using. That is a mistake. Now 
I have all of them changed to yeeloong for consistency. The latest is 
already in our git repos.

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


-- 
晏华
