Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Nov 2007 18:59:26 +0000 (GMT)
Received: from smtp-out3.tiscali.nl ([195.241.79.178]:30087 "EHLO
	smtp-out3.tiscali.nl") by ftp.linux-mips.org with ESMTP
	id S20030471AbXKBS7R (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Nov 2007 18:59:17 +0000
Received: from [82.171.216.234] (helo=[192.168.1.2])
	by smtp-out3.tiscali.nl with esmtp (Tiscali http://www.tiscali.nl)
	id 1Io1jg-0000gx-0R
	for <linux-mips@linux-mips.org>; Fri, 02 Nov 2007 19:59:17 +0100
Message-ID: <472B7379.4030003@tiscali.nl>
Date:	Fri, 02 Nov 2007 19:59:05 +0100
From:	Roel Kluin <12o3l@tiscali.nl>
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [PATCH] Use strchr instead of strstr in mips/fw/arc/cmdline.c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <12o3l@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17378
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: 12o3l@tiscali.nl
Precedence: bulk
X-list: linux-mips

Use strchr instead of strstr when searching for a single character

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/arch/mips/fw/arc/cmdline.c b/arch/mips/fw/arc/cmdline.c
index fd604ef..4ca4eef 100644
--- a/arch/mips/fw/arc/cmdline.c
+++ b/arch/mips/fw/arc/cmdline.c
@@ -52,7 +52,7 @@ static char * __init move_firmware_args(char* cp)
 				strcat(cp, used_arc[i][1]);
 				cp += strlen(used_arc[i][1]);
 				/* ... and now the argument */
-				s = strstr(prom_argv(actr), "=");
+				s = strchr(prom_argv(actr), '=');
 				if (s) {
 					s++;
 					strcpy(cp, s);
