Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6ODOLm08900
	for linux-mips-outgoing; Tue, 24 Jul 2001 06:24:21 -0700
Received: from highland.isltd.insignia.com (highland.isltd.insignia.com [195.217.222.20])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6ODOJO08896
	for <linux-mips@oss.sgi.com>; Tue, 24 Jul 2001 06:24:19 -0700
Received: from wolf.isltd.insignia.com (wolf.isltd.insignia.com [172.16.1.3])
	by highland.isltd.insignia.com (8.11.3/8.11.3/check_local4.2) with ESMTP id f6ODOH437365;
	Tue, 24 Jul 2001 14:24:17 +0100 (BST)
Received: from snow (snow.isltd.insignia.com [172.16.17.209])
	by wolf.isltd.insignia.com (8.9.3/8.9.3) with SMTP id OAA18577;
	Tue, 24 Jul 2001 14:24:16 +0100 (BST)
Message-ID: <00b201c11443$f02eae40$d11110ac@snow.isltd.insignia.com>
From: "Andrew Thornton" <andrew.thornton@insignia.com>
To: "James Simmons" <jsimmons@transvirtual.com>
Cc: "Linux-MIPS" <linux-mips@oss.sgi.com>
Subject: Re: ATI Victoria on Malta
Date: Tue, 24 Jul 2001 14:24:16 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.5
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>Turn on debugging in atyfb.c and post the results.
>
>/*
> * Debug flags.
> */
>#undef DEBUG

OK. I'm afraid I haven't got that much time to spare on this, which is why I
asked if anyone else had managed this!

What I've got is linux-2.4.3.mips-src-01.00.tar.gz (from ftp.mips.com)
patched to make the FPU emulator work reliably (taken from the mail list),
aty.h and atyfb.c from linux-2.4.6.tar.gz (from ftp.kernel.org) with DEBUG
defined. The kernel is configured for a little endian Malta board, virtual
terminal, framebuffer, ATI Mach64, PS2 keyboard (I had to change the MIPS
config.in for this), GDB debugging.

The relevant console output is:

atyfb: 3D RAGE (XL) [0x4752 rev 0x65] 512K SGRAM, 14.31818 MHz XTAL, 230 MHz
PLL
, 120 Mhz MCLK
BUS_CNTL DAC_CNTL MEM_CNTL EXT_MEM_CNTL CRTC_GEN_CNTL DSP_CONFIG DSP_ON_OFF
80000001 06010000 00085838 00000081     04000000      00000000   00000000
PLL ac ac 24 df f6 04 00 fd 8e 9e 65 05 00 00 00 00

It hangs here.

Adding printk()'s, it seems that one of the places it hangs is in
wait_for_fifo() reading FIFO_STAT.

Andrew Thornton
