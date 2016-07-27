Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jul 2016 12:43:56 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:36186 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992215AbcG0Knt0j-Qd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Jul 2016 12:43:49 +0200
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 222EA81229;
        Wed, 27 Jul 2016 10:43:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-116-10.phx2.redhat.com [10.3.116.10])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u6RAhbVA008975;
        Wed, 27 Jul 2016 06:43:38 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] KEYS: MIPS64 needs to use compat_sys_keyctl for 32-bit
 userspace
From:   David Howells <dhowells@redhat.com>
To:     linux-mips@linux-mips.org
Cc:     smueller@chronox.de, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, dhowells@redhat.com,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Date:   Wed, 27 Jul 2016 11:43:37 +0100
Message-ID: <146961621766.14504.8539728847207913941.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 27 Jul 2016 10:43:40 +0000 (UTC)
Return-Path: <dhowells@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54380
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhowells@redhat.com
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

MIPS64 needs to use compat_sys_keyctl for 32-bit userspace rather than
calling sys_keyctl.  The latter will work in a lot of cases, thereby hiding
the issue.

Reported-by: Stephan Mueller <smueller@chronox.de>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: stable@vger.kernel.org
---

 arch/mips/kernel/scall64-n32.S |    2 +-
 arch/mips/kernel/scall64-o32.S |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index 9c0b387d6427..51d3988933f8 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -348,7 +348,7 @@ EXPORT(sysn32_call_table)
 	PTR	sys_ni_syscall			/* available, was setaltroot */
 	PTR	sys_add_key
 	PTR	sys_request_key
-	PTR	sys_keyctl			/* 6245 */
+	PTR	compat_sys_keyctl		/* 6245 */
 	PTR	sys_set_thread_area
 	PTR	sys_inotify_init
 	PTR	sys_inotify_add_watch
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index f4f28b1580de..6efa7136748f 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -504,7 +504,7 @@ EXPORT(sys32_call_table)
 	PTR	sys_ni_syscall			/* available, was setaltroot */
 	PTR	sys_add_key			/* 4280 */
 	PTR	sys_request_key
-	PTR	sys_keyctl
+	PTR	compat_sys_keyctl
 	PTR	sys_set_thread_area
 	PTR	sys_inotify_init
 	PTR	sys_inotify_add_watch		/* 4285 */
