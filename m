Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Oct 2011 15:46:11 +0200 (CEST)
Received: from re04.intra2net.com ([82.165.46.26]:49328 "EHLO
        re04.intra2net.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903644Ab1J2NqE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 29 Oct 2011 15:46:04 +0200
Received: from intranator.m.i2n (unknown [172.16.1.99])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by re04.intra2net.com (Postfix) with ESMTP id 1414430127;
        Sat, 29 Oct 2011 15:45:58 +0200 (CEST)
Received: from localhost (intranator.m.i2n [127.0.0.1])
        by localhost (Postfix) with ESMTP id D45292AC54;
        Sat, 29 Oct 2011 15:45:57 +0200 (CEST)
X-Virus-Scanned: by Intranator (www.intra2net.com) with AMaViS and F-Secure
        AntiVirus (fsavdb 2011-10-29_04)
Received: from pikkukde.a.i2n (unknown [192.168.12.2])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by intranator.m.i2n (Postfix) with ESMTPS id CABC12AC51;
        Sat, 29 Oct 2011 15:45:56 +0200 (CEST)
Message-ID: <4EAC0394.5000807@intra2net.com>
Date:   Sat, 29 Oct 2011 15:45:56 +0200
From:   Thomas Jarosch <thomas.jarosch@intra2net.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix off-by-two in arcs_cmdline buffer size check
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-archive-position: 31322
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.jarosch@intra2net.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21297

Cause is a misplaced bracket.

The code

    strlen(buf+1)

will be two bytes less than

    strlen(buf)+1

The +1 is in this code to reserve space for an additional space character.

Signed-off-by: Thomas Jarosch <thomas.jarosch@intra2net.com>
---
 arch/mips/pmc-sierra/yosemite/prom.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/pmc-sierra/yosemite/prom.c b/arch/mips/pmc-sierra/yosemite/prom.c
index cf4c868..a6d5eb3 100644
--- a/arch/mips/pmc-sierra/yosemite/prom.c
+++ b/arch/mips/pmc-sierra/yosemite/prom.c
@@ -102,7 +102,7 @@ void __init prom_init(void)
 
 	/* Get the boot parameters */
 	for (i = 1; i < argc; i++) {
-		if (strlen(arcs_cmdline) + strlen(arg[i] + 1) >=
+		if (strlen(arcs_cmdline) + strlen(arg[i]) + 1 >=
 		    sizeof(arcs_cmdline))
 			break;
 
-- 
1.7.6.4
