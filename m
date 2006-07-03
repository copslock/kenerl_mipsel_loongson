Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Jul 2006 13:30:25 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:49795 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S8133621AbWGCMaP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 3 Jul 2006 13:30:15 +0100
Received: from lagash (mipsfw.mips-uk.com [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id A8C1F46220; Mon,  3 Jul 2006 14:30:10 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1FxNYv-00035Y-Nb; Mon, 03 Jul 2006 13:30:01 +0100
Date:	Mon, 3 Jul 2006 13:30:01 +0100
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] Save 2k text size in cpu-probe
Message-ID: <20060703123001.GA6625@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

The appended patch drops the inline for decode_configs, this saves about
2k of text size. It also uses MIPS_CONF_AR instead of magic constants.


Thiemo


Signed-off-by: Thiemo Seufer <ths@networkno.de>

--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -467,7 +467,7 @@ static inline unsigned int decode_config
 	isa = (config0 & MIPS_CONF_AT) >> 13;
 	switch (isa) {
 	case 0:
-		switch ((config0 >> 10) & 7) {
+		switch ((config0 & MIPS_CONF_AR) >> 10) {
 		case 0:
 			c->isa_level = MIPS_CPU_ISA_M32R1;
 			break;
@@ -479,7 +479,7 @@ static inline unsigned int decode_config
 		}
 		break;
 	case 2:
-		switch ((config0 >> 10) & 7) {
+		switch ((config0 & MIPS_CONF_AR) >> 10) {
 		case 0:
 			c->isa_level = MIPS_CPU_ISA_M64R1;
 			break;
@@ -556,7 +556,7 @@ static inline unsigned int decode_config
 	return config3 & MIPS_CONF_M;
 }
 
-static inline void decode_configs(struct cpuinfo_mips *c)
+__init static void decode_configs(struct cpuinfo_mips *c)
 {
 	/* MIPS32 or MIPS64 compliant CPU.  */
 	c->options = MIPS_CPU_4KEX | MIPS_CPU_4K_CACHE | MIPS_CPU_COUNTER |
