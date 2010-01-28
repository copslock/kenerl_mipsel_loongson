Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jan 2010 15:22:21 +0100 (CET)
Received: from mail-ew0-f223.google.com ([209.85.219.223]:50440 "EHLO
        mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492355Ab0A1OWD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Jan 2010 15:22:03 +0100
Received: by mail-ew0-f223.google.com with SMTP id 23so438141ewy.24
        for <multiple recipients>; Thu, 28 Jan 2010 06:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:organization:to:cc:content-type
         :content-transfer-encoding:message-id;
        bh=E6j0qKqRNpC42ixlUSR8qtSUOkPr1SX3kqupRaUn0H0=;
        b=CNZl69i6WGSTP7RGOBc4aRSXqHE8Dz3sMGYDbcgLc0WbyOORn7Md6VUNVa1ivt8GRA
         jSSqUlnz7ddSnwEYjf+bj55rIZE5uKlyYlzhy8UWSSt9cGLnbqLOiOeGBc9/fty5d+bi
         i+1me/28QxJf6wZanE2jD53BMqOGANvw5AeWE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:organization
         :to:cc:content-type:content-transfer-encoding:message-id;
        b=PLsbg2e0XnFDpaFqOSs1UTz1CaNHYUqUXLmEumr9UuortELwL4mNzOqm/82nQWubdu
         ClIlb2IkAVKfNn7kP+V/1KOlhBtPiSqwXfvyQ+LiJ8kI57vbvn7ags8T0jEUzq21NC0g
         JuRAdsg5jq/93DBJeu01srdBSvoqoMi+6RkQM=
Received: by 10.213.26.138 with SMTP id e10mr1442473ebc.80.1264688523240;
        Thu, 28 Jan 2010 06:22:03 -0800 (PST)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id 15sm662925ewy.0.2010.01.28.06.22.02
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 28 Jan 2010 06:22:02 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
Date:   Thu, 28 Jan 2010 15:21:42 +0100
Subject: [PATCH 2/3] MIPS: annotate set_except_vector with __init
MIME-Version: 1.0
X-Length: 1466
Organization: OpenWrt
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201001281521.42925.florian@openwrt.org>
X-archive-position: 25718
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18235

All call sites of set_except_vector are already annotated
with __init, so annotate that one too.

Signed-off-by: Regards, Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 308e434..574608e 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1276,7 +1276,7 @@ unsigned long vi_handlers[64];
  * to interrupt handlers in the address range from
  * KSEG0 <= x < KSEG0 + 256mb on the Nevada.  Oh well ...
  */
-void *set_except_vector(int n, void *addr)
+void __init *set_except_vector(int n, void *addr)
 {
 	unsigned long handler = (unsigned long) addr;
 	unsigned long old_handler = exception_handlers[n];
