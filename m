Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7G4UWw11620
	for linux-mips-outgoing; Wed, 15 Aug 2001 21:30:32 -0700
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7G4UTj11617
	for <linux-mips@oss.sgi.com>; Wed, 15 Aug 2001 21:30:29 -0700
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 16 Aug 2001 04:30:29 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms2.toshiba-tops.co.jp (Postfix) with ESMTP
	id 3D2F554C10; Thu, 16 Aug 2001 13:30:28 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id NAA69714; Thu, 16 Aug 2001 13:30:28 +0900 (JST)
To: carstenl@mips.com
Cc: linux-mips@oss.sgi.com
Subject: Re: FP emulator patch
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <3B7A70B8.ED92FE4@mips.com>
References: <3B7A70B8.ED92FE4@mips.com>
X-Mailer: Mew version 1.94.2 on Emacs 20.7 / Mule 4.1 (AOI)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Thu_Aug_16_13:34:48_2001_982)--"
Content-Transfer-Encoding: 7bit
Message-Id: <20010816133501S.nemoto@toshiba-tops.co.jp>
Date: Thu, 16 Aug 2001 13:35:01 +0900
X-Dispatcher: imput version 20000228(IM140)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

----Next_Part(Thu_Aug_16_13:34:48_2001_982)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

>>>>> On Wed, 15 Aug 2001 14:53:12 +0200, Carsten Langgaard <carstenl@mips.com> said:
carstenl> There has been some reports regarding FP emulator failures,
carstenl> which the attached patch should solve.  The patch include a
carstenl> fix for emulation of instructions in a COP1 delay-slot, a
carstenl> fix for FP context switching and some additional stuff ,
carstenl> which was needed to pass our torture test.

There is another bug in FPU emulator.  An instruction in delay slot of
bc1tl/bc1fl executed(or emulated) even if the branch not taken.  Here
is a patch to fix this.

Since current kernel calls FPU emulator on FP exception and FPU
emulator handles continuous FP instructions in one call, this bug
affects CPUs with FPU (not only CPUs without FPU).

---
Atsushi Nemoto


----Next_Part(Thu_Aug_16_13:34:48_2001_982)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cp1emu.c.patch"

diff -ur linux.sgi/arch/mips/math-emu/cp1emu.c linux/arch/mips/math-emu/cp1emu.c
--- linux.sgi/arch/mips/math-emu/cp1emu.c	Sun Aug  5 23:39:27 2001
+++ linux/arch/mips/math-emu/cp1emu.c	Thu Aug 16 12:21:07 2001
@@ -686,7 +686,7 @@
 					 * branch likely nullifies dslot if not
 					 * taken
 					 */
-					xcp->cp0_epc += 4;
+					contpc += 4;
 					/* else continue & execute dslot as normal insn */
 			}
 			break;

----Next_Part(Thu_Aug_16_13:34:48_2001_982)----
