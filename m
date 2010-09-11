Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Sep 2010 15:33:53 +0200 (CEST)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:45970 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491016Ab0IKNdr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 Sep 2010 15:33:47 +0200
Received: by eye22 with SMTP id 22so2595888eye.36
        for <multiple recipients>; Sat, 11 Sep 2010 06:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=oVborOrv6sF1qWewRUmCF/JFKm48zwCfCAMSLlRnau0=;
        b=sKW9Ub2u3iMWFwD5ySt4GMkyGi/7hws1icU5zJoDfGaUOBbkC+lNnspaOXeNHW6Xps
         xMiJkfvHJYG4JnkchsSpaoay1fVfLRwxE6mN3ky3syrA6Wim+afwT2gIl12tjaXH0jNu
         ymgXyG/Q5gHrahyIkG7G4mYV5r59h+o+h7rEM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=cw1AhabBzBAE9w64Rphy+XfmNVEAg83nn1XoRXvmTxqI+RjdLQpoFhynYFCZRPGrgr
         CSVJ++yfKIC2Dj7qvOezwBkcJ5HcC2s2UxDk5A5cosBnK+m8jXUnjslZH3ZWrzUpHFVa
         MzxADZNE3azUF7TK0vtxLFlUo86cgZ4STwO4E=
Received: by 10.213.7.131 with SMTP id d3mr340980ebd.55.1284212024831;
        Sat, 11 Sep 2010 06:33:44 -0700 (PDT)
Received: from localhost.localdomain (79-134-110-186.cust.suomicom.fi [79.134.110.186])
        by mx.google.com with ESMTPS id z55sm5736289eeh.9.2010.09.11.06.33.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 11 Sep 2010 06:33:44 -0700 (PDT)
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH] arch: mips: use newly introduced hex_to_bin()
Date:   Sat, 11 Sep 2010 16:33:29 +0300
Message-Id: <1284212009-25708-1-git-send-email-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 1.7.2.2
X-archive-position: 27745
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andy.shevchenko@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 9019

Remove custom implementation of hex_to_bin().

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/rb532/devices.c |   24 +++++++++---------------
 1 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/arch/mips/rb532/devices.c b/arch/mips/rb532/devices.c
index 041fc1a..a969eb8 100644
--- a/arch/mips/rb532/devices.c
+++ b/arch/mips/rb532/devices.c
@@ -251,28 +251,22 @@ static struct platform_device *rb532_devs[] = {
 
 static void __init parse_mac_addr(char *macstr)
 {
-	int i, j;
-	unsigned char result, value;
+	int i, h, l;
 
 	for (i = 0; i < 6; i++) {
-		result = 0;
-
 		if (i != 5 && *(macstr + 2) != ':')
 			return;
 
-		for (j = 0; j < 2; j++) {
-			if (isxdigit(*macstr)
-			    && (value =
-				isdigit(*macstr) ? *macstr -
-				'0' : toupper(*macstr) - 'A' + 10) < 16) {
-				result = result * 16 + value;
-				macstr++;
-			} else
-				return;
-		}
+		h = hex_to_bin(*macstr++);
+		if (h == -1)
+			return;
+
+		l = hex_to_bin(*macstr++);
+		if (l == -1)
+			return;
 
 		macstr++;
-		korina_dev0_data.mac[i] = result;
+		korina_dev0_data.mac[i] = (h << 4) + l;
 	}
 }
 
-- 
1.7.2.2
