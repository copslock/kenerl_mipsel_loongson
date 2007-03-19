Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2007 00:05:38 +0000 (GMT)
Received: from phoenix.bawue.net ([193.7.176.60]:63419 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20022911AbXCSAFe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 19 Mar 2007 00:05:34 +0000
Received: from lagash (88-106-169-123.dynamic.dsl.as9105.com [88.106.169.123])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id EA493B8075;
	Mon, 19 Mar 2007 01:04:56 +0100 (CET)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1HT5N4-0005iD-NU; Mon, 19 Mar 2007 00:05:06 +0000
Date:	Mon, 19 Mar 2007 00:05:06 +0000
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] More liberal check for mips-board console
Message-ID: <20070319000506.GA7744@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14533
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Hello All,

the appended patch allows to override the MALTA/ATLAS/etc. default
console setting with non-serial console devices.


Thiemo


Signed-Off-By: Thiemo Seufer <ths@networkno.de>

diff --git a/arch/mips/mips-boards/generic/init.c b/arch/mips/mips-boards/generic/init.c
index 1acdf09..88e9c2a 100644
--- a/arch/mips/mips-boards/generic/init.c
+++ b/arch/mips/mips-boards/generic/init.c
@@ -145,7 +145,7 @@ static void __init console_config(void)
 	char parity = '\0', bits = '\0', flow = '\0';
 	char *s;
 
-	if ((strstr(prom_getcmdline(), "console=ttyS")) == NULL) {
+	if ((strstr(prom_getcmdline(), "console=")) == NULL) {
 		s = prom_getenv("modetty0");
 		if (s) {
 			while (*s >= '0' && *s <= '9')
