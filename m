Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jan 2016 23:29:17 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:37428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011573AbcAYWY7LzffA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Jan 2016 23:24:59 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id C775B203C2;
        Mon, 25 Jan 2016 22:24:57 +0000 (UTC)
Received: from localhost (199-83-221-254.PUBLIC.monkeybrains.net [199.83.221.254])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F38C203B5;
        Mon, 25 Jan 2016 22:24:57 +0000 (UTC)
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
Subject: [PATCH v2 15/16] uhid: Check write() bitness using in_compat_syscall
Date:   Mon, 25 Jan 2016 14:24:29 -0800
Message-Id: <8c4d604b079099acb0df9ad849d53b589ea7aa9a.1453759363.git.luto@kernel.org>
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
X-archive-position: 51375
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

uhid changes the format expected in write() depending on bitness.
It should check the syscall bitness directly.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/hid/uhid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index e094c572b86e..16b6f11a0700 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -384,7 +384,7 @@ struct uhid_create_req_compat {
 static int uhid_event_from_user(const char __user *buffer, size_t len,
 				struct uhid_event *event)
 {
-	if (is_compat_task()) {
+	if (in_compat_syscall()) {
 		u32 type;
 
 		if (get_user(type, buffer))
-- 
2.5.0
