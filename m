Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jun 2003 02:01:45 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:4623
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225239AbTFDBBl>; Wed, 4 Jun 2003 02:01:41 +0100
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 4 Jun 2003 01:01:39 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id h5411Ojf026565;
	Wed, 4 Jun 2003 10:01:24 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Wed, 04 Jun 2003 10:02:04 +0900 (JST)
Message-Id: <20030604.100204.74756139.nemoto@toshiba-tops.co.jp>
To: macro@ds2.pg.gda.pl
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: mips64 LOAD_KPTE2 fix
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.GSO.3.96.1030603141712.29576C-100000@delta.ds2.pg.gda.pl>
References: <20030602.202345.08315331.nemoto@toshiba-tops.co.jp>
	<Pine.GSO.3.96.1030603141712.29576C-100000@delta.ds2.pg.gda.pl>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2509
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 3 Jun 2003 14:58:44 +0200 (MET DST), "Maciej W. Rozycki" <macro@ds2.pg.gda.pl> said:
macro>  I don't think a separate overflow check is needed, even I see
macro> how the code can fail for large offsets into XKSEG.  How about
macro> this patch?  Does it work for you?  It would not incur
macro> unnecessary overhead.

macro> diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030505.macro/arch/mips64/mm/tlbex-r4k.S linux-mips-2.4.21-pre4-20030505/arch/mips64/mm/tlbex-r4k.S
macro> --- linux-mips-2.4.21-pre4-20030505.macro/arch/mips64/mm/tlbex-r4k.S	2003-04-27 02:56:39.000000000 +0000
macro> +++ linux-mips-2.4.21-pre4-20030505/arch/mips64/mm/tlbex-r4k.S	2003-06-03 12:54:41.000000000 +0000
macro> @@ -73,8 +73,9 @@
macro>  	 * Determine that fault address is within vmalloc range.
macro>  	 */
macro>  	dla	\tmp, ekptbl
macro> -	sltu	\tmp, \ptr, \tmp
macro> +	slt	\tmp, \ptr, \tmp
macro>  	beqz	\tmp, \not_vmalloc		# not vmalloc
macro> +	 nop
macro>  	.endm


Thank you for pointing out this.  I did not think very much.  But you
mean "slt \tmp, \tmp, \ptr", don't you?

diff -u linux-mips-cvs/arch/mips64/mm/tlbex-r4k.S linux.new/arch/mips64/mm/tlbex-r4k.S
--- linux-mips-cvs/arch/mips64/mm/tlbex-r4k.S	Mon Apr 28 09:44:54 2003
+++ linux.new/arch/mips64/mm/tlbex-r4k.S	Wed Jun  4 09:45:48 2003
@@ -73,8 +73,9 @@
 	 * Determine that fault address is within vmalloc range.
 	 */
 	dla	\tmp, ekptbl
-	sltu	\tmp, \ptr, \tmp
+	slt	\tmp, \tmp, \ptr
 	beqz	\tmp, \not_vmalloc		# not vmalloc
+	 nop
 	.endm
 
 
---
Atsushi Nemoto
