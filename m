Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Mar 2007 15:40:36 +0000 (GMT)
Received: from smtp-ext.int-evry.fr ([157.159.11.17]:44773 "EHLO
	smtp-ext.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20021691AbXCPPkb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Mar 2007 15:40:31 +0000
Received: from [192.168.3.2] (florian.maisel.int-evry.fr [157.159.41.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 17A1CD0E315
	for <linux-mips@linux-mips.org>; Fri, 16 Mar 2007 16:39:24 +0100 (CET)
Message-ID: <45FABA5A.5000007@int-evry.fr>
Date:	Fri, 16 Mar 2007 16:40:10 +0100
From:	Florian Fainelli <florian.fainelli@int-evry.fr>
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [PATCH] Fix a warning in lib-64/dump_tlb.c
X-Enigmail-Version: 0.94.1.1
OpenPGP: id=DABD1772
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <florian.fainelli@int-evry.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14497
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@int-evry.fr
Precedence: bulk
X-list: linux-mips

Hi all,

This patch suppresses a warning in arch/mips/lib-64/dump_tlb.c

Signed-off-by: Florian Fainelli <florian.fainelli@int-evry.fr>

-----
diff --git a/arch/mips/lib-64/dump_tlb.c b/arch/mips/lib-64/dump_tlb.c
index 8232900..60a87c5 100644
--- a/arch/mips/lib-64/dump_tlb.c
+++ b/arch/mips/lib-64/dump_tlb.c
@@ -30,6 +30,7 @@ static inline const char *msk2str(unsigned int mask)
        case PM_64M:    return "64Mb";
        case PM_256M:   return "256Mb";
 #endif
+       default:        return NULL;
        }
 }
