Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Sep 2014 13:53:15 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38467 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008439AbaIILxLxqSzT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Sep 2014 13:53:11 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 498E5EFDD189B;
        Tue,  9 Sep 2014 12:53:02 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 9 Sep 2014 12:53:04 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.67) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 9 Sep 2014 12:53:04 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        <linux-next@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>
Subject: [PATCH linux-next] MIPS: ioctls: Add missing TIOC{S,G}RS485 definitions
Date:   Tue, 9 Sep 2014 12:52:55 +0100
Message-ID: <1410263575-26720-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.1.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.67]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42483
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

Commit e676253b19b2d269cccf67fdb1592120a0cd0676
(serial/8250: Add support for RS485 IOCTLs) added cases for the
TIOC{S,G}RS485 commands but this broke the build for MIPS:

drivers/tty/serial/8250/8250_core.c: In function 'serial8250_ioctl':
drivers/tty/serial/8250/8250_core.c:2874:7: error: 'TIOCSRS485' undeclared
(first use in this function)
drivers/tty/serial/8250/8250_core.c:2886:7: error: 'TIOCGRS485' undeclared
(first use in this function)

This patch adds these missing definitions

Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: <linux-next@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: <linux-serial@vger.kernel.org>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/uapi/asm/ioctls.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/include/uapi/asm/ioctls.h b/arch/mips/include/uapi/asm/ioctls.h
index b1e637757fe3..34050cb6b631 100644
--- a/arch/mips/include/uapi/asm/ioctls.h
+++ b/arch/mips/include/uapi/asm/ioctls.h
@@ -76,6 +76,8 @@
 
 #define TIOCSBRK	0x5427	/* BSD compatibility */
 #define TIOCCBRK	0x5428	/* BSD compatibility */
+#define TIOCGRS485	0x542E
+#define TIOCSRS485	0x542F
 #define TIOCGSID	0x7416	/* Return the session ID of FD */
 #define TCGETS2		_IOR('T', 0x2A, struct termios2)
 #define TCSETS2		_IOW('T', 0x2B, struct termios2)
-- 
2.1.0
