Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Jul 2009 02:25:26 +0200 (CEST)
Received: from [222.92.8.141] ([222.92.8.141]:43249 "EHLO lemote.com"
	rhost-flags-FAIL-FAIL-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493066AbZGAAZT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Jul 2009 02:25:19 +0200
Received: from localhost (localhost [127.0.0.1])
	by lemote.com (Postfix) with ESMTP id 7FDE73435B;
	Wed,  1 Jul 2009 08:13:14 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from lemote.com ([127.0.0.1])
	by localhost (www.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3qzwqOTFo7IA; Wed,  1 Jul 2009 08:12:59 +0800 (CST)
Received: from [172.16.2.17] (unknown [222.92.8.142])
	by lemote.com (Postfix) with ESMTP id DE30C34A07;
	Wed,  1 Jul 2009 08:12:59 +0800 (CST)
Message-ID: <4A4AAB93.6040306@lemote.com>
Date:	Wed, 01 Jul 2009 08:19:31 +0800
From:	yanhua <yanh@lemote.com>
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
MIME-Version: 1.0
To:	wuzhangjin@gmail.com
CC:	LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org,
	Pavel Machek <pavel@ucw.cz>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [BUG] MIPS: Hibernation in the latest linux-mips:master branch
 not work
References: <1246372868.19049.17.camel@falcon>
In-Reply-To: <1246372868.19049.17.camel@falcon>
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 8bit
Return-Path: <yanh@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23552
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yanh@lemote.com
Precedence: bulk
X-list: linux-mips

Wu Zhangjin Ð´µÀ:
> Hi,
>
> I just updated my git repository to the master branch of the latest
> linux-mips git repository, and tested the STD/Hibernation support on
> fuloong2e and yeeloong2f, it failed:
>
> when using the no_console_suspend kernel command line to debug, it
> stopped on:
>
> PM: Shringking memory... done (1000 pages freed)
> PM: Freed 160000 kbytes in 1.68 seconds (95.23 MB/s)
> PM: Creating hibernation image:
> PM: Need to copy 5053 pages
> PM: Hibernation image created (4195 pages copied)
>
> and then, the number indicator light of keyboard works well, but can not
> type anything. 
>
>   
Are there any other information about it? such as: it just freezes
there, or IDE irq lost messages after some time?

Is it duplicable every time?
> anybody have tested it on another platform? does it work?
>
> Regards,
> Wu Zhangjin
>
>
>
>   
