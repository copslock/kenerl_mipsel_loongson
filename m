Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f73A7Rj04932
	for linux-mips-outgoing; Fri, 3 Aug 2001 03:07:27 -0700
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f73A7OV04929
	for <linux-mips@oss.sgi.com>; Fri, 3 Aug 2001 03:07:24 -0700
Received: from rembrandt.csv.ica.uni-stuttgart.de (rembrandt.csv.ica.uni-stuttgart.de [129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de (8.9.3/8.9.3) with ESMTP id MAA133599
	for <linux-mips@oss.sgi.com>; Fri, 3 Aug 2001 12:07:23 +0200 (MDT)
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.22 #1 (Debian))
	id 15SbrW-0000nb-00
	for <linux-mips@oss.sgi.com>; Fri, 03 Aug 2001 12:07:22 +0200
Date: Fri, 3 Aug 2001 12:07:22 +0200
To: linux-mips@oss.sgi.com
Subject: Re: ksymoops changes for mips
Message-ID: <20010803120722.C26278@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17478.996819006@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.3.18i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Keith Owens wrote:
> Resend, no response.

I tried to send you something via PM, but your email address
gave errors.

   ----- Transcript of session follows -----
   451 <kaos@ocs.com.au>... reply: read error from mail.ocs.com.au.
   <kaos@ocs.com.au>... Deferred: Connection reset by mail.ocs.com.au.
   Warning: message still undelivered after 4 hours
   Will keep trying until message is 5 days old

[snip]
   > >I am updating ksymoops now and need some information.  Could somebody
   > >tell me what this produces on mips?
   > >
   > ># objdump -h ksymoops | head -8
   > ># objdump -h mips64-lsb-vmlinux | head -8
   > ># objdump -h mips64-msb-vmlinux | head -8
   > >
   > >where mips64-[lm]sb-vmlinux are kernels compiled for 64 bit with LSB
   > >and MSB.
   >
   > Sorry, that should have been objdump -x, not objdump -h, I need the
   > architecture type as well as the file format.
   
   What I have is not the "official" CVS kernel but a patched version,
   along with a patched toolchain. It already uses elf64-tradbigmips
   instead of elf64-bigmips and has a different start address as it
   is loaded in 64bit address space. I haven't cared about little
   endian yet (no such hardware).
   
   So it's just for reference for now, possibly it helps.
   
   
   Thiemo
   
   
   -----------------------------------------------------------------------
   
   mips64-msb-vmlinux:     file format elf64-tradbigmips
   mips64-msb-vmlinux
   architecture: mips:8000, flags 0x00000112:
   EXEC_P, HAS_SYMS, D_PAGED
   start address 0xa8000000201b4000
   
   Program Header:
