Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Sep 2014 10:57:24 +0200 (CEST)
Received: from mail-la0-f54.google.com ([209.85.215.54]:46287 "EHLO
        mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008651AbaIJI5WhWicB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Sep 2014 10:57:22 +0200
Received: by mail-la0-f54.google.com with SMTP id b17so21331202lan.13
        for <linux-mips@linux-mips.org>; Wed, 10 Sep 2014 01:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=cZkjAc9pz6m/Iobgm2yaowe/QmxPBsdQpY5FcdT2s6E=;
        b=GwAbtU8p5htDIMW7NN/SP18cQSTPV2eKJxSY1yZw29c0O/980KELZr2qf6HpT+qWMX
         qmXT0l0HRwnYGsc9rQr8g+LENXitlXokb/REQ+Bz8GdicRrzTpCEVBuHq9/29yRYcTr6
         tDKrpbwa09Mhjrp6TDuFeCNx2lLbt9wPowDdGTY8MOE6M3JH0Ny2nxGKU4GCfJa8gL1d
         /FrGUfRU2aHEdwj1t/JHp/8m93iKxRVqGF6muxq11CHEhcA9PsR0sGt+y7szCT0MzQRi
         1eIwwhpxa+Him0f3v8HuVi+CAEwn3cx8MWYiwQjSn4RRYTdxa8u8NjD6vRuvo9Y2ynVf
         EcbQ==
X-Received: by 10.152.42.209 with SMTP id q17mr6621753lal.13.1410339437061;
        Wed, 10 Sep 2014 01:57:17 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by mx.google.com with ESMTPSA id bt9sm5405158lbd.47.2014.09.10.01.57.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Sep 2014 01:57:16 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Markos Chandras <Markos.Chandras@imgtec.com>,
        Greg KH <greg@kroah.com>, linux-mips@linux-mips.org,
        linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH] mips/uapi: Add definition of TIOC[SG]RS485
Date:   Wed, 10 Sep 2014 10:57:08 +0200
Message-Id: <1410339428-2825-1-git-send-email-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.1.0
Return-Path: <ricardo.ribalda@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42491
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ricardo.ribalda@gmail.com
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

Commit: e676253b19b2d269cccf67fdb1592120a0cd0676 (serial/8250: Add
support for RS485 IOCTLs), adds support for RS485 ioctls for 825_core on
all the archs. Unfortunaltely the definition of TIOCSRS485 and
TIOCGRS485 was missing on the ioctls.h file

Reported-by: Markos Chandras <markos.chandras@imgtec.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 arch/mips/include/uapi/asm/ioctls.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/include/uapi/asm/ioctls.h b/arch/mips/include/uapi/asm/ioctls.h
index b1e6377..740219c 100644
--- a/arch/mips/include/uapi/asm/ioctls.h
+++ b/arch/mips/include/uapi/asm/ioctls.h
@@ -81,6 +81,8 @@
 #define TCSETS2		_IOW('T', 0x2B, struct termios2)
 #define TCSETSW2	_IOW('T', 0x2C, struct termios2)
 #define TCSETSF2	_IOW('T', 0x2D, struct termios2)
+#define TIOCGRS485	_IOR('T', 0x2E, struct serial_rs485)
+#define TIOCSRS485	_IOWR('T', 0x2F, struct serial_rs485)
 #define TIOCGPTN	_IOR('T', 0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T', 0x31, int)  /* Lock/unlock Pty */
 #define TIOCGDEV	_IOR('T', 0x32, unsigned int) /* Get primary device node of /dev/console */
-- 
2.1.0
