Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Dec 2009 12:56:56 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:36951 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492345AbZL3L4t (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 30 Dec 2009 12:56:49 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 807A834180C7;
        Wed, 30 Dec 2009 12:56:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fRRMV9NcjrUe; Wed, 30 Dec 2009 12:56:46 +0100 (CET)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by zmc.proxad.net (Postfix) with ESMTPSA id 0E22434180C2;
        Wed, 30 Dec 2009 12:56:46 +0100 (CET)
From:   Florian Fainelli <ffainelli@freebox.fr>
Organization: Freebox
To:     Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] ignore vmlinuz
Date:   Wed, 30 Dec 2009 12:53:44 +0100
User-Agent: KMail/1.12.2 (Linux/2.6.31-16-server; KDE/4.3.2; x86_64; ; )
Cc:     linux-mips@linux-mips.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Maxime Bizon <mbizon@freebox.fr>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200912301253.44057.ffainelli@freebox.fr>
Return-Path: <ffainelli@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25466
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ffainelli@freebox.fr
Precedence: bulk
X-list: linux-mips

MIPS compressed kernels output a vmlinuz file in the
top-level directory (maybe others do).
Add vmlinuz to the list of files to ignore by git.

Signed-off-by: Florian Fainelli <ffainelli@freebox.fr>
---
diff --git a/.gitignore b/.gitignore
index fb2190c..de6344e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -37,6 +37,7 @@ modules.builtin
 tags
 TAGS
 vmlinux
+vmlinuz
 System.map
 Module.markers
 Module.symvers
