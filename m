Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jan 2008 15:28:52 +0000 (GMT)
Received: from fig.raritan.com ([12.144.63.197]:44597 "EHLO fig.raritan.com")
	by ftp.linux-mips.org with ESMTP id S20024559AbYAPP2n (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 Jan 2008 15:28:43 +0000
Received: from [192.168.32.222] ([192.168.32.222]) by fig.raritan.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 16 Jan 2008 10:28:37 -0500
Message-ID: <478E22A4.4070604@raritan.com>
Date:	Wed, 16 Jan 2008 10:28:36 -0500
From:	Gregor Waltz <gregor.waltz@raritan.com>
User-Agent: Thunderbird 1.5.0.10 (X11/20070403)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Toshiba JMR 3927 working setup?
References: <477E7DAE.2080005@raritan.com> <20080106.000725.75184768.anemo@mba.ocn.ne.jp> <4787AC3D.2020604@raritan.com> <20080112.211749.25909440.anemo@mba.ocn.ne.jp> <478CD639.3040307@raritan.com> <20080115161457.GB31107@networkno.de> <478D121C.4020701@raritan.com> <20080115231421.GB9767@networkno.de>
In-Reply-To: <20080115231421.GB9767@networkno.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Jan 2008 15:28:37.0506 (UTC) FILETIME=[76E1B620:01C85854]
Return-Path: <Gregor.Waltz@raritan.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18078
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregor.waltz@raritan.com
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:
> Enabling CONFIG_BOOT_RAW, as Atsushi already suggested, would have
> added a jump to kernel_entry in this place.
>   
Yes, I tried that, but it made no difference at the time and Atsushi 
also said that it was broken in git as of 01/05/2008 (I have 2.6.23.9).
The kernel config operations (oldconfig, menuconfig, et al) obliterate 
CONFIG_BOOT_RAW from the .config.

I double checked today and found that even the vmlinux make target 
removes that option from .config.
Is there another way to set that option?

I saw the option used only in arch/mips/kernel/head.S, so I commented 
out the __INIT. Now, I see kernel_entry at the start of the kernel and 
the kernel does not cause an exception, however, it reboots instead 
saying "Rebooting..."

Thanks
