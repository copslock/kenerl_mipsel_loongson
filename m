Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6V4VbP29997
	for linux-mips-outgoing; Mon, 30 Jul 2001 21:31:37 -0700
Received: from yog-sothoth.sgi.com (eugate.sgi.com [192.48.160.10])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6V4VWV29990
	for <linux-mips@oss.sgi.com>; Mon, 30 Jul 2001 21:31:32 -0700
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130]) by yog-sothoth.sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam-europe) via SMTP id GAA358061
	for <linux-mips@oss.sgi.com>; Tue, 31 Jul 2001 06:31:09 +0200 (CEST)
	mail_from (kaos@ocs.com.au)
Received: from kao2.melbourne.sgi.com (kao2.melbourne.sgi.com [134.14.55.180]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id OAA23359; Tue, 31 Jul 2001 14:30:04 +1000
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>, linux-mips@oss.sgi.com
Subject: Re: ksymoops changes for mips 
In-reply-to: Your message of "Tue, 31 Jul 2001 13:57:45 +1000."
             <1227.996551865@kao2.melbourne.sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 31 Jul 2001 14:30:04 +1000
Message-ID: <1648.996553804@kao2.melbourne.sgi.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 31 Jul 2001 13:57:45 +1000, 
Keith Owens <kaos@ocs.com.au> wrote:
>I am updating ksymoops now and need some information.  Could somebody
>tell me what this produces on mips?
>
># objdump -h ksymoops | head -8
># objdump -h mips64-lsb-vmlinux | head -8
># objdump -h mips64-msb-vmlinux | head -8
>
>where mips64-[lm]sb-vmlinux are kernels compiled for 64 bit with LSB
>and MSB.

Sorry, that should have been objdump -x, not objdump -h, I need the
architecture type as well as the file format.
