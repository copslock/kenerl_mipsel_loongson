Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Dec 2003 19:13:39 +0000 (GMT)
Received: from [IPv6:::ffff:216.72.155.13] ([IPv6:::ffff:216.72.155.13]:4532
	"EHLO supercable.net.ve") by linux-mips.org with ESMTP
	id <S8225347AbTLOTNi>; Mon, 15 Dec 2003 19:13:38 +0000
Received: from 6-allhosts (unverified [200.47.143.122]) 
	by supercable.net.ve (TRUE) with ESMTP id 1986018 
	for multiple; Mon, 15 Dec 2003 15:02:39 GMT -4
Subject: Re: philips nino 300 - 4mb ram
From: "Ricardo Mendoza M." <ricmm@kanux.com>
Reply-To: ricmm@kanux.com
To: none <deltha@analog.ro>
Cc: linux-mips@linux-mips.org
In-Reply-To: <2329036882.20031214213631@analog.ro>
References: <2329036882.20031214213631@analog.ro>
Content-Type: text/plain
Message-Id: <1071515610.28043.7.camel@ricmm.no-ip.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 15 Dec 2003 15:13:31 -0400
Content-Transfer-Encoding: 7bit
X-Server: High Performance Mail Server - http://surgemail.com
Return-Path: <ricmm@kanux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3778
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ricmm@kanux.com
Precedence: bulk
X-list: linux-mips

Hey,

I have a Philips NINO 300 with 8mb of RAM, and some time ago that kernel
worked for me, even the framebuffer. I have had those scrambled problems
some time ago and they were cause by a bad compiler, try recompiling
your own kernel.

About the serial console, be sure you have no flow control, neither
hardware nor software flow control set to on.

	- Ricardo


On Sun, 2003-12-14 at 15:36, none wrote:
>    I tried to boot the precompiled kernel :
>    ftp://ftp.realitydiluted.com/Nino/kernel/precompiled/vmlinux-2.4.17.gz
>    using pbsdboot but
>    all I can see is the display scrambled,
>    and not a bootup sequence, nothing at hyperterminal set as 115200 8-N-1
>    How to get it working? (booting)
