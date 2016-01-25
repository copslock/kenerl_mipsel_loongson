Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jan 2016 23:27:50 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:37331 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011469AbcAYWYxkhUyx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Jan 2016 23:24:53 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 5018520303;
        Mon, 25 Jan 2016 22:24:52 +0000 (UTC)
Received: from localhost (199-83-221-254.PUBLIC.monkeybrains.net [199.83.221.254])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7BA420398;
        Mon, 25 Jan 2016 22:24:51 +0000 (UTC)
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
Subject: [PATCH v2 10/16] net/xfrm_user: Use in_compat_syscall to deny compat syscalls
Date:   Mon, 25 Jan 2016 14:24:24 -0800
Message-Id: <ba8cd4d5f06bead4294ac3ff26e2b76d10536d83.1453759363.git.luto@kernel.org>
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
X-archive-position: 51370
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

The code wants to prevent compat code from receiving messages.  Use
in_compat_syscall for this.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 net/xfrm/xfrm_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 805681a7d356..2cc7af858c6f 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2449,7 +2449,7 @@ static int xfrm_user_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 	int type, err;
 
 #ifdef CONFIG_COMPAT
-	if (is_compat_task())
+	if (in_compat_syscall())
 		return -ENOTSUPP;
 #endif
 
-- 
2.5.0
