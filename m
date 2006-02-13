Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Feb 2006 09:09:55 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:43273 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S8133461AbWBMJJp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 13 Feb 2006 09:09:45 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 23449F5C57;
	Mon, 13 Feb 2006 10:15:56 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 26401-07; Mon, 13 Feb 2006 10:15:55 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id D009EF5C54;
	Mon, 13 Feb 2006 10:15:55 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id k1D9FiXP011689;
	Mon, 13 Feb 2006 10:15:44 +0100
Date:	Mon, 13 Feb 2006 09:15:49 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>,
	Ralf Baechle <ralf@linux-mips.org>
cc:	"Peter 'p2' De Schrijver" <p2@mind.be>, linux-mips@linux-mips.org
Subject: Re: DECstation R3000 boot error
In-Reply-To: <Pine.LNX.4.64N.0602061021110.32080@blysk.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.64N.0602130911260.17051@blysk.ds.pg.gda.pl>
References: <20060123225040.GA23576@deprecation.cyrius.com>
 <Pine.LNX.4.64N.0601241059140.11021@blysk.ds.pg.gda.pl>
 <20060124122700.GA8527@deprecation.cyrius.com>
 <Pine.LNX.4.64N.0601241227290.11021@blysk.ds.pg.gda.pl> <20060124232117.GA4165@codecarver>
 <Pine.LNX.4.64N.0601251103020.7675@blysk.ds.pg.gda.pl>
 <20060203150232.GA25701@deprecation.cyrius.com>
 <Pine.LNX.4.64N.0602061021110.32080@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.87.1/1284/Sun Feb 12 17:00:59 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 6 Feb 2006, Maciej W. Rozycki wrote:

>  Not yet, sorry.  I have updated my tree and most of my local patches, but 
> I have a few to go yet.  My time is limited these days, but I'll try hard 
> to get at the problems you reported by the coming weekend at the very 
> latest.

 The following change fixes the problem for me -- it looks like an 
omission from some recent changes elsewhere.  Ralf, please apply.

  Maciej

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>

patch-mips-2.6.15-20060124-mips-cpu-isa-0
diff -up --recursive --new-file linux-mips-2.6.15-20060124.macro/include/asm-mips/cpu.h linux-mips-2.6.15-20060124/include/asm-mips/cpu.h
--- linux-mips-2.6.15-20060124.macro/include/asm-mips/cpu.h	2005-12-10 05:58:16.000000000 +0000
+++ linux-mips-2.6.15-20060124/include/asm-mips/cpu.h	2006-02-12 02:34:24.000000000 +0000
@@ -204,9 +204,9 @@
  */
 #define MIPS_CPU_ISA_I		0x00000001
 #define MIPS_CPU_ISA_II		0x00000002
-#define MIPS_CPU_ISA_III	0x00000003
-#define MIPS_CPU_ISA_IV		0x00000004
-#define MIPS_CPU_ISA_V		0x00000005
+#define MIPS_CPU_ISA_III	0x00000004
+#define MIPS_CPU_ISA_IV		0x00000008
+#define MIPS_CPU_ISA_V		0x00000010
 #define MIPS_CPU_ISA_M32R1	0x00000020
 #define MIPS_CPU_ISA_M32R2	0x00000040
 #define MIPS_CPU_ISA_M64R1	0x00000080
