Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 May 2006 19:25:44 +0200 (CEST)
Received: from bender.bawue.de ([193.7.176.20]:61097 "HELO bender.bawue.de")
	by ftp.linux-mips.org with SMTP id S8133574AbWEORZc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 15 May 2006 19:25:32 +0200
Received: from lagash (unknown [194.74.144.146])
	by bender.bawue.de (Postfix) with ESMTP
	id 6285044521; Mon, 15 May 2006 19:25:31 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1FfgoT-0002wG-TE; Mon, 15 May 2006 18:24:57 +0100
Date:	Mon, 15 May 2006 18:24:57 +0100
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] DSP and MDMX share the same config flag bit
Message-ID: <20060515172457.GC9026@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11434
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Clarify comment.


Signed-off-by:  Thiemo Seufer <ths@networkno.de>


diff -urpN linux-orig/include/asm-mips/mipsregs.h linux-work/include/asm-mips/mipsregs.h
--- linux-orig/include/asm-mips/mipsregs.h	2006-04-24 12:02:35.000000000 +0100
+++ linux-work/include/asm-mips/mipsregs.h	2006-05-15 03:06:37.000000000 +0100
@@ -291,7 +291,7 @@
 #define ST0_DL			(_ULCAST_(1) << 24)
 
 /*
- * Enable the MIPS DSP ASE
+ * Enable the MIPS MDMX and DSP ASEs
  */
 #define ST0_MX			0x01000000
 
