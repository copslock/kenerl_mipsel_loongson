Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jun 2010 00:01:42 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:17124 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492329Ab0FPWAv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jun 2010 00:00:51 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c1949a80001>; Wed, 16 Jun 2010 15:01:12 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 16 Jun 2010 15:00:50 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 16 Jun 2010 15:00:50 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.3) with ESMTP id o5GM0jR8008627;
        Wed, 16 Jun 2010 15:00:45 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o5GM0fGK008617;
        Wed, 16 Jun 2010 15:00:41 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 2/2] MIPS: Make init_vdso a subsys_initcall.
Date:   Wed, 16 Jun 2010 15:00:28 -0700
Message-Id: <1276725628-8572-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1276725628-8572-1-git-send-email-ddaney@caviumnetworks.com>
References: <1276725628-8572-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 16 Jun 2010 22:00:50.0126 (UTC) FILETIME=[61C20EE0:01CB0D9F]
X-archive-position: 27149
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 11589

Quoting from Jiri Slaby's patch of a similar nature for x86:

    When initrd is in use and a driver does request_module() in its
    module_init (i.e. __initcall or device_initcall), a modprobe
    process is created with VDSO mapping. But VDSO is inited even in
    __initcall, i.e. on the same level (at the same time), so it may
    not be inited yet (link order matters).

Move init_vdso up to subsys_initcall to avoid the issue.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Cc: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/kernel/vdso.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
index 891c117..7baa0b5 100644
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -63,7 +63,7 @@ static int __init init_vdso(void)
 
 	return 0;
 }
-device_initcall(init_vdso);
+subsys_initcall(init_vdso);
 
 static unsigned long vdso_addr(unsigned long start)
 {
-- 
1.6.6.1
