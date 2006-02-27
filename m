Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Feb 2006 01:21:59 +0000 (GMT)
Received: from nproxy.gmail.com ([64.233.182.203]:29512 "EHLO nproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133544AbWB0BVs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 27 Feb 2006 01:21:48 +0000
Received: by nproxy.gmail.com with SMTP id c2so478905nfe
        for <linux-mips@linux-mips.org>; Sun, 26 Feb 2006 17:29:23 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GrMjgKUah3bWzV6+RApUOSEB5Y/3J2sTS6B/WpGG+dRzBowV/MoVfZ8Fj1HAO7NPtbDJOFPrrOgrdfSdzeHKOJ507MLhzhniMzfvd632flBFwcanvnZyiuI772nxaYHFuiLuGOdWeE+Lk/923/R2TfXkah6yljmqd4MPpqmAufc=
Received: by 10.49.60.11 with SMTP id n11mr3637600nfk;
        Sun, 26 Feb 2006 17:29:23 -0800 (PST)
Received: by 10.48.249.14 with HTTP; Sun, 26 Feb 2006 17:29:23 -0800 (PST)
Message-ID: <50c9a2250602261729q543eb515hff7af85153ac779@mail.gmail.com>
Date:	Mon, 27 Feb 2006 09:29:23 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: bogus packet in ei_receive of 8390.c
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20060226.230541.75185772.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <50c9a2250602251831n27d11b5ar7a309c9716a8683a@mail.gmail.com>
	 <20060226.230541.75185772.anemo@mba.ocn.ne.jp>
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10650
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

On 2/26/06, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> >>>>> On Sun, 26 Feb 2006 10:31:44 +0800, zhuzhenhua <zzh.hust@gmail.com> said:
>
> zzh> i use a rtl8019as ethernet card for my board, and now the driver
> zzh> can boot up with nfs root, it also can run helloworld via nfs,
> zzh> but if i run a big application,or something like vi, it will get
> zzh> messages like that "eth0: bogus packet: status=0x0 nxpg=0x65
> zzh> size=102" and i find it is in ei_receive of 8390.c caused by
> zzh> uncorrect status of receive in the 8390_hdr, does someone meet
> zzh> this situation?  what may cause this? hardware or uncorrect
> zzh> driver?
>
> Though I do now know what is wrong, here is some general considerations:
>
> RTL8019AS has 8bit mode and 16bit mode.  Does your driver select right
> mode (ei_status.word16) ?

i have set ei_status.word16 = 0

>
> And if your RTL8019AS is running in 8bit mode, PSTOP (Page Stop)
> register should not exceed to 0x60 (please refer detasheet available
> from www.realtek.com.tw).  Check your driver's PSTOP value.

now, i change the PSTOP to 0x60, it still get the messages

>
> Also, it would be worth checking your ISA-like bus is correctly
> configured.  Bus-width, clock, wait-cycles, setup/hold time, etc.

our board is a FPGA board for embedded system, there is no ISA, and
use memory map IO, is there anything need to configure?

>
> ---
> Atsushi Nemoto
>

now i printk the ISR and RSR value when bogus packet accepted, are
these two registers  correct? messages as follow

NE_EN0_RSR = 81
NE_EN0_ISR = 1
eth0: bogus packet: status=0xef nxpg=0x5e size=1518
NE_EN0_RSR = 1
NE_EN0_ISR = 1
eth0: bogus packet: status=0xae nxpg=0x50 size=1518
NE_EN0_RSR = 1
NE_EN0_ISR = 1
eth0: bogus packet: status=0xb7 nxpg=0x5c size=1518
NE_EN0_RSR = 1
NE_EN0_ISR = 1
eth0: bogus packet: status=0xae nxpg=0x4e size=1518
NE_EN0_RSR = 1
NE_EN0_ISR = 1
eth0: bogus packet: status=0xcb nxpg=0x5a size=1518
NE_EN0_RSR = 1
NE_EN0_ISR = 1


Best regards

zhuzhenhua
