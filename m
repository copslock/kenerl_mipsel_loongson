Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jan 2016 23:28:06 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:37349 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011559AbcAYWYyrKkyI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Jan 2016 23:24:54 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 6A037203B1;
        Mon, 25 Jan 2016 22:24:53 +0000 (UTC)
Received: from localhost (199-83-221-254.PUBLIC.monkeybrains.net [199.83.221.254])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8658203AC;
        Mon, 25 Jan 2016 22:24:52 +0000 (UTC)
From:   Andy Lutomirski <luto@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        linux-parisc@vger.kernel.org, linux-mips@linux-mips.org,
        sparclinux@vger.kernel.org
Subject: [PATCH v2 11/16] firewire: Use in_compat_syscall to check ioctl compatness
Date:   Mon, 25 Jan 2016 14:24:25 -0800
Message-Id: <35556b0fffab7a629e9a4e1115480ee5bfb5263a.1453759363.git.luto@kernel.org>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <cover.1453759363.git.luto@kernel.org>
References: <cover.1453759363.git.luto@kernel.org>
In-Reply-To: <cover.1453759363.git.luto@kernel.org>
References: <cover.1453759363.git.luto@kernel.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <luto@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51371
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luto@kernel.org
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

Firewire was using is_compat_task to check whether it was in a
compat ioctl or a non-compat ioctl.  Use is_compat_syscall instead
so it works properly on all architectures.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/firewire/core-cdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index 36a7c2d89a01..aee149bdf4c0 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -221,7 +221,7 @@ struct inbound_phy_packet_event {
 #ifdef CONFIG_COMPAT
 static void __user *u64_to_uptr(u64 value)
 {
-	if (is_compat_task())
+	if (in_compat_syscall())
 		return compat_ptr(value);
 	else
 		return (void __user *)(unsigned long)value;
@@ -229,7 +229,7 @@ static void __user *u64_to_uptr(u64 value)
 
 static u64 uptr_to_u64(void __user *ptr)
 {
-	if (is_compat_task())
+	if (in_compat_syscall())
 		return ptr_to_compat(ptr);
 	else
 		return (u64)(unsigned long)ptr;
-- 
2.5.0
