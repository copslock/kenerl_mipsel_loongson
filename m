Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Dec 2004 05:03:00 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:23583
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8224872AbULMFCv>; Mon, 13 Dec 2004 05:02:51 +0000
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 13 Dec 2004 05:02:49 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 3D87C239E2C; Mon, 13 Dec 2004 13:34:10 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id iBD4Y9dD096152;
	Mon, 13 Dec 2004 13:34:09 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Mon, 13 Dec 2004 13:34:09 +0900 (JST)
Message-Id: <20041213.133409.11964920.nemoto@toshiba-tops.co.jp>
To: ralf@linux-mips.org
Cc: nunoe@co-nss.co.jp, linux-mips@linux-mips.org
Subject: Re: HIGHMEM
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20041207095837.GA13264@linux-mips.org>
References: <001101c4dbf9$1da02270$3ca06096@NUNOE>
	<20041207095837.GA13264@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6656
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 7 Dec 2004 10:58:37 +0100, Ralf Baechle <ralf@linux-mips.org> said:
ralf> Issue #3 - As I recall the TX4937's H3 core is suffering from
ralf> cache aliases.  Handling those efficiently for highmem is not
ralf> easily possible and so we don't even try.  More recent kernels
ralf> will refuse to enable highmem on such cache configurations but
ralf> something like 2.4.18 which by now is an almost 3 year old
ralf> antique doesn't know about that and will happily crash.

ralf> I recommend you should go for a 64-bit kernel instead.  And
ralf> 64-bit support is certainly better in 2.6 than in 2.4.
ralf> Especially the area of 32-bit binary compatibility has been
ralf> improved significantly.

And this is a small step to a 64-bit kernel for TX49XX.  Could you
apply?

--- linux-mips/arch/mips/mm/Makefile	2004-12-13 09:39:09.000000000 +0900
+++ linux/arch/mips/mm/Makefile	2004-12-13 09:52:54.000000000 +0900
@@ -49,6 +49,7 @@
 endif
 ifdef CONFIG_MIPS64
 obj-$(CONFIG_CPU_R4300)		+= tlbex64.o
+obj-$(CONFIG_CPU_TX49XX)	+= tlbex64.o
 obj-$(CONFIG_CPU_R4X00)		+= tlbex64.o
 obj-$(CONFIG_CPU_R5000)		+= tlbex64.o
 obj-$(CONFIG_CPU_NEVADA)	+= tlbex64.o
