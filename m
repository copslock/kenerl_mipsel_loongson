Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Dec 2007 12:05:15 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:56762 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20024304AbXLJMFG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 10 Dec 2007 12:05:06 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id E34113ECD; Mon, 10 Dec 2007 04:05:04 -0800 (PST)
Message-ID: <475D2B86.603@ru.mvista.com>
Date:	Mon, 10 Dec 2007 15:05:26 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	zhuzhenhua <zzh.hust@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: is there a standard high res timer patch for mips?
References: <50c9a2250712091718l75455353v1b86851a011eb4fe@mail.gmail.com>
In-Reply-To: <50c9a2250712091718l75455353v1b86851a011eb4fe@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17753
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

zhuzhenhua wrote:

>            i want to add the high res timer support for my kernel(version
> 2.6.14),and i found there are some patches:
>  high-res-timers at sourceforge.net/projects/high-res-timers/high-res-timers
> Jun Sun's patch at
> http://linux.junsun.net/patches/oss.sgi.com/experimental/<http://linux.junsun.net/patches/oss.sgi.com/experimental/040419.a-cpu-timer.patch>
> Thomas Gleixner's patch at http://www.tglx.de/projects/hrtimers/
>      is there a standard high res timer patch for mips now?
>      thanks for any hints

    Yes, Tohmas' patch is now included into the kernel.

> Best Regards
> 
> zzh

WBR, Sergei
