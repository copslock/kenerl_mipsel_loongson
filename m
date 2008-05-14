Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 May 2008 06:37:04 +0100 (BST)
Received: from mx1.redhat.com ([66.187.233.31]:9685 "EHLO mx1.redhat.com")
	by ftp.linux-mips.org with ESMTP id S20029952AbYENFhB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 May 2008 06:37:01 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m4E5aub3011805;
	Wed, 14 May 2008 01:36:56 -0400
Received: from file.rdu.redhat.com (file.rdu.redhat.com [10.11.255.147])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m4E5aub3029283;
	Wed, 14 May 2008 01:36:56 -0400
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [10.10.36.72])
	by file.rdu.redhat.com (8.13.1/8.13.1) with ESMTP id m4E5augg016264;
	Wed, 14 May 2008 01:36:56 -0400
Received: from devserv.devel.redhat.com (localhost.localdomain [127.0.0.1])
	by devserv.devel.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id m4E5atmx014302;
	Wed, 14 May 2008 01:36:55 -0400
Received: (from drepper@localhost)
	by devserv.devel.redhat.com (8.12.11.20060308/8.12.11/Submit) id m4E5atee014300;
	Wed, 14 May 2008 01:36:55 -0400
Date:	Wed, 14 May 2008 01:36:55 -0400
From:	Ulrich Drepper <drepper@redhat.com>
Message-Id: <200805140536.m4E5atee014300@devserv.devel.redhat.com>
To:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH] flag parameters: MIPS socket flags
Cc:	akpm@linux-foundation.org, torvalds@linux-foundation.org
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Return-Path: <drepper@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19266
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: drepper@redhat.com
Precedence: bulk
X-list: linux-mips

MIPS defines its own socket types.  So we have to define the new socket
flags and the type mask for MIPS as well.

 socket.h |    7 +++++++
 1 file changed, 7 insertions(+)


Signed-off-by: Ulrich Drepper <drepper@redhat.com>

diff --git a/include/asm-mips/socket.h b/include/asm-mips/socket.h
index 63f6025..facc2d7 100644
--- a/include/asm-mips/socket.h
+++ b/include/asm-mips/socket.h
@@ -102,6 +102,13 @@ enum sock_type {
 };
 
 #define SOCK_MAX (SOCK_PACKET + 1)
+/* Mask which covers at least up to SOCK_MASK-1.  The
+ *  * remaining bits are used as flags. */
+#define SOCK_TYPE_MASK 0xf
+
+/* Flags for socket, socketpair, paccept */
+#define SOCK_CLOEXEC	O_CLOEXEC
+#define SOCK_NONBLOCK	O_NONBLOCK
 
 #define ARCH_HAS_SOCKET_TYPES 1
 
