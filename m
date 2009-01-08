Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jan 2009 16:58:47 +0000 (GMT)
Received: from mail-bw0-f13.google.com ([209.85.218.13]:37338 "EHLO
	mail-bw0-f13.google.com") by ftp.linux-mips.org with ESMTP
	id S21365000AbZAHQ6o (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Jan 2009 16:58:44 +0000
Received: by bwz6 with SMTP id 6so24011501bwz.0
        for <linux-mips@linux-mips.org>; Thu, 08 Jan 2009 08:58:38 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=vNyNdLZKCaj+q9wKXAGe1eG1KXQzwwrWlJ8D1kLKrPc=;
        b=pk0Il809fh+6TOkSF5npBNrwyrHNqElwyjcFvdnQu91luoecVowDqQFNTCbQAGvdmu
         E2ON0rFs6U8RBK907jQ7q8THKiNI+3Zqalxlna9nxbvgRXKp2yic/x3vzAqpYSVvPLf1
         Zgek0DA5wUK1IvevfLDJvEWs/gMNDChk5P5P8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=tfWiC0+vDb5d6EHwmCNz3bqbBD15CceJ5ZKqV06+fQpy1kf9opiQWCjLAOCNDWkrEm
         W/Wtviw5qbDblKax5WzSSqiON9WXq25hPrIUj8fNW+VwsjO/j6sMMt0XXy1YaTnu1W4t
         bQ6RIP2G5ND2Da3OfMwIcA9lnao4acZjtoKaU=
Received: by 10.181.21.2 with SMTP id y2mr9385703bki.144.1231433918191;
        Thu, 08 Jan 2009 08:58:38 -0800 (PST)
Received: by 10.180.255.19 with HTTP; Thu, 8 Jan 2009 08:58:38 -0800 (PST)
Message-ID: <fce2a370901080858s345a33a6x3a2f821a7d9645b8@mail.gmail.com>
Date:	Thu, 8 Jan 2009 18:58:38 +0200
From:	"Ihar Hrachyshka" <ihar.hrachyshka@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: NXP STB225 board support
In-Reply-To: <fce2a370812230648s798ebbf6y1387a237ae640e39@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <fce2a370812230648s798ebbf6y1387a237ae640e39@mail.gmail.com>
Return-Path: <ihar.hrachyshka@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21690
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ihar.hrachyshka@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, Dec 23, 2008 at 4:48 PM, Ihar Hrachyshka
<ihar.hrachyshka@gmail.com> wrote:
> Hello!
> I try to start vanilla linux kernel on pnx-8335-stb225 board. What I did:
> 1. ARCH=mips make pnx-8335-stb225_defconfig
> 2. ARCH=mips make
> 3. Prepared U-Boot image with mkimage.
>
> After booting it up I get the following output on my UART:
>
> Linux version 2.6.28-rc9.netflix.PR12_RC2 (booxter@EPBYMINW0568) (gcc
> version 4.2.1) #3 PREEMPT Tue Dec 23 15:52:10 EET 2008
> CPU revision is: 00019068 (MIPS 4KEc)
> Determined physical RAM map:
>  memory: 10000000 @ 00000000 (usable)
> Zone PFN ranges:
>  Normal   0x00000000 -> 0x00010000
> Movable zone start PFN for each node
> early_node_map[1] active PFN ranges
>    0: 0x00000000 -> 0x00010000
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
> Kernel command line:
> mtdparts=gen_nand:128k(Boot0),1M(Boot1),512k(Env),4M(Kernel),16M(Filesystem)
> ip3902.mac_address=00:60:37:03:00:00 ip=10.6.2.53:10.6.27.3
> Unknown boot option `ip3902.mac_address=00:60:37:03:00:00': ignoring
> Primary instruction cache 16kB, VIPT, 2-way, linesize 16 bytes.
> Primary data cache 8kB, 4-way, VIPT, no aliases, linesize 16 bytes
> PID hash table entries: 1024 (order: 10, 4096 bytes)
> CPU clock is 320 MHz
> Console: colour dummy device 80x25
> console [ttyS0] enabled
>
> After this last message there is no any activity. It seems that kernel
> hanged. What can I do to see what's going on (maybe stack trace)? Any
> suggestions?
> Has anyone started the board successfully with vanilla kernel?
>
> Thanks in advance,
> Ihar Hrachyshka
>

Bisecting my Linus vanilla git, I found that the problem appeared
after the following patch was applied:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=566f74f6b2f8b85d5b8d6caaf97e5672cecd3e3e

After reverting the patch, Linus vanilla git kernel again boots ok on
the board. Please, take a look.
