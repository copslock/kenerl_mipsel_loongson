Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2003 13:15:05 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:22736 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225294AbTFEMPD>; Thu, 5 Jun 2003 13:15:03 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA07062;
	Thu, 5 Jun 2003 14:15:53 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Thu, 5 Jun 2003 14:15:52 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: Re: mips64 LOAD_KPTE2 fix
In-Reply-To: <20030605.095802.59461340.nemoto@toshiba-tops.co.jp>
Message-ID: <Pine.GSO.3.96.1030605130933.5828E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2541
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 5 Jun 2003, Atsushi Nemoto wrote:

> >>>>> On Wed, 4 Jun 2003 16:09:10 +0200 (MET DST), "Maciej W. Rozycki" <macro@ds2.pg.gda.pl> said:
> >> Thank you for pointing out this.  I did not think very much.  But
> >> you mean "slt \tmp, \tmp, \ptr", don't you?
> 
> macro>  Not at all.  Why would I want to reverse the comparison?
> 
> Sorry, I garbled.  Please ignore my last patch.  Your patch works
> fine.  Thank you again.

 Ralf, OK to apply then?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.21-pre4-20030505-load_kpte2-0
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030505.macro/arch/mips64/mm/tlbex-r4k.S linux-mips-2.4.21-pre4-20030505/arch/mips64/mm/tlbex-r4k.S
--- linux-mips-2.4.21-pre4-20030505.macro/arch/mips64/mm/tlbex-r4k.S	2003-04-27 02:56:39.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030505/arch/mips64/mm/tlbex-r4k.S	2003-06-03 12:54:41.000000000 +0000
@@ -73,8 +73,9 @@
 	 * Determine that fault address is within vmalloc range.
 	 */
 	dla	\tmp, ekptbl
-	sltu	\tmp, \ptr, \tmp
+	slt	\tmp, \ptr, \tmp
 	beqz	\tmp, \not_vmalloc		# not vmalloc
+	 nop
 	.endm
 
 
