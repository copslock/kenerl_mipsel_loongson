Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7GAbnr22768
	for linux-mips-outgoing; Thu, 16 Aug 2001 03:37:49 -0700
Received: from dea.waldorf-gmbh.de (u-43-20.karlsruhe.ipdial.viaginterkom.de [62.180.20.43])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7GAbej22761
	for <linux-mips@oss.sgi.com>; Thu, 16 Aug 2001 03:37:40 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f7G9I3b17674;
	Thu, 16 Aug 2001 11:18:03 +0200
Date: Thu, 16 Aug 2001 11:18:03 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: wgowcher@yahoo.com, linux-mips@oss.sgi.com
Subject: Re: Benchmark performance
Message-ID: <20010816111803.A17469@bacchus.dhis.org>
References: <20010809215522.A1958@lucon.org> <20010813173446.61234.qmail@web11901.mail.yahoo.com> <20010816125652N.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010816125652N.nemoto@toshiba-tops.co.jp>; from nemoto@toshiba-tops.co.jp on Thu, Aug 16, 2001 at 12:56:52PM +0900
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Aug 16, 2001 at 12:56:52PM +0900, Atsushi Nemoto wrote:

> >>>>> On Mon, 13 Aug 2001 10:34:46 -0700 (PDT), Wayne Gowcher <wgowcher@yahoo.com> said:
> wgowcher> a 23 % reduction in the Floating Point Index benchmark
> 
> Current CVS kernel uses FPU emulator unconditionally.  If one floating
> point intruction causes a 'Unimplemented' exception (denormalized
> result, etc.) following floating point instructions are also handle by
> FPU emulator (not only the instruction which raise the exception).
> 
> I do not know this is really desired behavior, but here is a patch to
> change this.  If Unimplemented exception had been occured during the
> benchmark, aplying this patch may result better performance.

This is a know problem with the emulator.  It may be used to keep the
emulator in kernel for a long time or even maliciously to keep the
CPU in the kernel for an unbounded time.

Here's my suggested fix:

Index: arch/mips/math-emu/cp1emu.c
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/math-emu/cp1emu.c,v
retrieving revision 1.7
diff -u -r1.7 cp1emu.c
--- arch/mips/math-emu/cp1emu.c	2001/08/02 21:55:26	1.7
+++ arch/mips/math-emu/cp1emu.c	2001/08/16 09:06:55
@@ -1672,6 +1672,9 @@
 
 	oldepc = xcp->cp0_epc;
 	do {
+		if (current->need_resched)
+			break;
+
 		prevepc = xcp->cp0_epc;
 		insn = mips_get_word(xcp, REG_TO_VA(xcp->cp0_epc), &err);
 		if (err) {

  Ralf
