Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Feb 2009 19:49:58 +0000 (GMT)
Received: from smtp1-g21.free.fr ([212.27.42.1]:63154 "EHLO smtp1-g21.free.fr")
	by ftp.linux-mips.org with ESMTP id S21103622AbZBMTt4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 13 Feb 2009 19:49:56 +0000
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 1DDCC9400AD;
	Fri, 13 Feb 2009 20:49:50 +0100 (CET)
Received: from [213.228.1.107] (sakura.staff.proxad.net [213.228.1.107])
	by smtp1-g21.free.fr (Postfix) with ESMTP id E03A19400A4;
	Fri, 13 Feb 2009 20:49:47 +0100 (CET)
Subject: RE: [PATCH] MIPS: Allocate exception vector on 64 KiB boundary
From:	Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To:	"David VomLehn (dvomlehn)" <dvomlehn@cisco.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	David Daney <ddaney@caviumnetworks.com>
In-Reply-To: <FF038EB85946AA46B18DFEE6E6F8A2899E2896@xmb-rtp-218.amer.cisco.com>
References: <FF038EB85946AA46B18DFEE6E6F8A28982392E@xmb-rtp-218.amer.cisco.com>
	 <1234532640.711.63.camel@sakura.staff.proxad.net>
	 <FF038EB85946AA46B18DFEE6E6F8A2899E2896@xmb-rtp-218.amer.cisco.com>
Content-Type: text/plain
Organization: Freebox
Date:	Fri, 13 Feb 2009 20:49:47 +0100
Message-Id: <1234554587.711.88.camel@sakura.staff.proxad.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.3.1 
Content-Transfer-Encoding: 7bit
Return-Path: <mbizon@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21934
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips


On Fri, 2009-02-13 at 13:41 -0500, David VomLehn (dvomlehn) wrote:

> Can you confirm that the patch fixes your problem?

Your patch does not apply anymore, this patch has been merged since:

@@ -1593,7 +1597,7 @@ void __cpuinit set_uncached_handler(unsigned long offset, void *addr,
 	unsigned long uncached_ebase = TO_UNCAC(ebase);
 #endif
 	if (cpu_has_mips_r2)
-		ebase += (read_c0_ebase() & 0x3ffff000);
+		uncached_ebase += (read_c0_ebase() & 0x3ffff000);
 
 	if (!addr)
 		panic(panic_null_cerr);


I just removed the whole test to fix my problem.

-- 
Maxime
