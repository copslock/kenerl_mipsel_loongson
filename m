Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Apr 2006 01:43:03 +0100 (BST)
Received: from webmail.ict.ac.cn ([159.226.39.7]:48600 "HELO ict.ac.cn")
	by ftp.linux-mips.org with SMTP id S8133618AbWDCAmz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 3 Apr 2006 01:42:55 +0100
Received: (qmail 23937 invoked by uid 507); 3 Apr 2006 00:05:29 -0000
Received: from unknown (HELO ?192.168.2.202?) (fxzhang@222.92.8.142)
  by ict.ac.cn with SMTP; 3 Apr 2006 00:05:29 -0000
Message-ID: <4430720F.2000708@ict.ac.cn>
Date:	Mon, 03 Apr 2006 08:53:35 +0800
From:	Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org
Subject: Re: stack backtrace
References: <442FE1CA.4030905@ict.ac.cn> <20060403.011711.74751665.anemo@mba.ocn.ne.jp>
In-Reply-To: <20060403.011711.74751665.anemo@mba.ocn.ne.jp>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11010
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips

> The get_frame_info() in process.c in kernel 2.6.16 no longer depends
> on a frame pointer.  It would fit your needs better.  I think you can
> use it with slight modifications.
good news
> 
> BTW, Is there any point using -fno-omit-frame-pointer on MIPS now?
> CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y is better for MIPS, isn't it?
> 
> ---
> Atsushi Nemoto
> 
> 
> 
