Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Dec 2014 03:16:00 +0100 (CET)
Received: from resqmta-po-08v.sys.comcast.net ([96.114.154.167]:53433 "EHLO
        resqmta-po-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008569AbaLLCP6lJnyQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Dec 2014 03:15:58 +0100
Received: from resomta-po-19v.sys.comcast.net ([96.114.154.243])
        by resqmta-po-08v.sys.comcast.net with comcast
        id SSFo1p0025FMDhs01SFqNd; Fri, 12 Dec 2014 02:15:50 +0000
Received: from [192.168.1.13] ([76.100.35.31])
        by resomta-po-19v.sys.comcast.net with comcast
        id SSFo1p00H0gJalY01SFpwK; Fri, 12 Dec 2014 02:15:50 +0000
Message-ID: <548A4FC7.1080700@gentoo.org>
Date:   Thu, 11 Dec 2014 21:15:35 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: Update arch/mips/include/asm/sgi/sgi.h
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1418350550;
        bh=dTUk8p5drIeVlAOopuyxq2vQ0hfO9U2uw/PemRy8ijY=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=Urw5W7v7PQ1TlWqqB6+iuobLuMFBpST8nQkxSZFMXjqAHGUYC3ixKTYsq1id6Xwsv
         Y3DB8tQf5/ojkeXu0BugSBHOpUACH7LbeqCtw76znx6S2VsMJSIVT9ZXR/BO3U52Z9
         KWv5NKOJRl0XjnYETx0U44vRmQcgSSOooJDle+o2Td669Ko0H5xBTQEExlMUp6df7J
         pAVtMrISLuEmHJXKO/ruDuzrymo2zLR8F0x+IclDQt4kRss/t8RCW8+evB15b8Aurt
         e/KkDObuKwWhrsdorkQvHYLBQ/hh15kLmmtAQGkQgTj7g/K57/dDStlaMlNFIWjQ6v
         ghB8wbbk5wenQ==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44623
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Update arch/mips/include/asm/sgi/sgi.h with some updated information on SGI
systems.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---
 arch/mips/include/asm/sgi/sgi.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/asm/sgi/sgi.h b/arch/mips/include/asm/sgi/sgi.h
index 645cea7..b615571 100644
--- a/arch/mips/include/asm/sgi/sgi.h
+++ b/arch/mips/include/asm/sgi/sgi.h
@@ -22,14 +22,15 @@ enum sgi_mach {
 	ip17,	/* R4K UP */
 	ip19,	/* R4K MP */
 	ip20,	/* R4K UP, Indigo */
-	ip21,	/* TFP MP */
-	ip22,	/* R4x00 UP, Indigo2 */
+	ip21,	/* R8k/TFP MP */
+	ip22,	/* R4x00 UP, Indy, Indigo2 */
 	ip25,	/* R10k MP */
-	ip26,	/* TFP UP, Indigo2 */
-	ip27,	/* R10k MP, R12k MP, Origin */
-	ip28,	/* R10k UP, Indigo2 */
-	ip30,	/* Octane */
-	ip32,	/* O2 */
+	ip26,	/* R8k/TFP UP, Indigo2 */
+	ip27,	/* R10k MP, R12k MP, R14k MP, Origin 200/2k, Onyx2 */
+	ip28,	/* R10k UP, Indigo2 Impact R10k */
+	ip30,	/* R10k MP, R12k MP, R14k MP, Octane */
+	ip32,	/* R5k UP, RM5200 UP, RM7k UP, R10k UP, R12k UP, O2 */
+	ip35,   /* R14k MP, R16k MP, Origin 300/3k, Onyx3, Fuel, Tezro */
 };
 
 extern enum sgi_mach sgimach;
