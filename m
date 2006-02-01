Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Feb 2006 19:02:31 +0000 (GMT)
Received: from allen.werkleitz.de ([80.190.251.108]:64966 "EHLO
	allen.werkleitz.de") by ftp.linux-mips.org with ESMTP
	id S3458570AbWBATCF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Feb 2006 19:02:05 +0000
Received: from p54be9954.dip0.t-ipconnect.de ([84.190.153.84] helo=void.local)
	by allen.werkleitz.de with esmtpsa (TLS-1.0:DHE_RSA_3DES_EDE_CBC_SHA1:24)
	(Exim 4.60)
	(envelope-from <js@linuxtv.org>)
	id 1F4NJm-0007Tt-EY; Wed, 01 Feb 2006 20:07:08 +0100
Received: from js by void.local with local (Exim 3.35 #1 (Debian))
	id 1F4NJl-0005eR-00; Wed, 01 Feb 2006 20:07:01 +0100
Date:	Wed, 1 Feb 2006 20:07:01 +0100
From:	Johannes Stezenbach <js@linuxtv.org>
To:	Thiemo Seufer <ths@networkno.de>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Message-ID: <20060201190701.GA20411@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Thiemo Seufer <ths@networkno.de>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
References: <20060131171508.GB6341@linuxtv.org> <Pine.LNX.4.64N.0601311724340.31371@blysk.ds.pg.gda.pl> <20060131181414.GA8288@linuxtv.org> <20060131184253.GA23753@networkno.de> <20060131192314.GB8826@linuxtv.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060131192314.GB8826@linuxtv.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: 84.190.153.84
Subject: Re: gdb vs. gdbserver with -mips3 / 32bitmode userspace
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Return-Path: <js@linuxtv.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10288
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: js@linuxtv.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 31, 2006, Johannes Stezenbach wrote:
> On Tue, Jan 31, 2006, Thiemo Seufer wrote:
> > On Tue, Jan 31, 2006 at 07:14:14PM +0100, Johannes Stezenbach wrote:
> > [snip]
> > > Yes, that's why I said I'm confused about mips_isa_regsize() vs.
> > > mips_abi_regsize().
> > > 
> > > mips_abi_regsize() correctly says the register size is 32bit for o32,
> > > but mips_register_type() calls mips_isa_regsize(), not
> > > mips_abi_regsize(). That's why I chose to "fix" mips_isa_regsize().
> > > 
> > > Or should mips_register_type() simply call mips_abi_regsize()?
> > 
> > Without having had a look at the code I think that's the right fix.
> 
> OK, I'll test if that works for me, and post results here

OK, after some testing, the patch below seems to work.

Johannes


--- gdb-6.3/gdb/mips-tdep.c.orig	2004-10-15 09:25:03.000000000 +0200
+++ gdb-6.3/gdb/mips-tdep.c	2006-01-31 20:27:54.000000000 +0100
@@ -716,16 +716,16 @@ mips_register_type (struct gdbarch *gdba
       && (regnum % NUM_REGS) < mips_regnum (current_gdbarch)->fp0 + 32)
     {
       /* The floating-point registers raw, or cooked, always match
-         mips_isa_regsize(), and also map 1:1, byte for byte.  */
+         mips_abi_regsize(), and also map 1:1, byte for byte.  */
       switch (gdbarch_byte_order (gdbarch))
 	{
 	case BFD_ENDIAN_BIG:
-	  if (mips_isa_regsize (gdbarch) == 4)
+	  if (mips_abi_regsize (gdbarch) == 4)
 	    return builtin_type_ieee_single_big;
 	  else
 	    return builtin_type_ieee_double_big;
 	case BFD_ENDIAN_LITTLE:
-	  if (mips_isa_regsize (gdbarch) == 4)
+	  if (mips_abi_regsize (gdbarch) == 4)
 	    return builtin_type_ieee_single_little;
 	  else
 	    return builtin_type_ieee_double_little;
@@ -738,7 +738,7 @@ mips_register_type (struct gdbarch *gdba
     {
       /* The raw or ISA registers.  These are all sized according to
 	 the ISA regsize.  */
-      if (mips_isa_regsize (gdbarch) == 4)
+      if (mips_abi_regsize (gdbarch) == 4)
 	return builtin_type_int32;
       else
 	return builtin_type_int64;
