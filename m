Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2012 23:39:34 +0200 (CEST)
Received: from mail-la0-f49.google.com ([209.85.215.49]:62904 "EHLO
        mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823036Ab2JOVjB0p100 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Oct 2012 23:39:01 +0200
Received: by mail-la0-f49.google.com with SMTP id z14so3679391lag.36
        for <multiple recipients>; Mon, 15 Oct 2012 14:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=BnepeiBnR4zdBO/VgJAl9GK1G+cbenYP2/H3gs7dKeI=;
        b=M3SV8I8AdEL89zPEyBY7UV12clK1ayOWK3CymL/zcWz9dRZyaYvQnmYXjMXo/WXPHh
         QDd1wW+Gh62aRawl88TZgUDBTEqTwbruCJ0BeZPGA43U73X2fyf6BKDdPEVdYMZ/cgDv
         1Rxlte/X2t7SS4aaQ77op9Pmf4/wl9J5JabNNSvxc52H8Cm0/2xLfBWKqxCBG094RlC+
         /OFczZXjNvjWJGOW1qANuj0Jj3gLXQ6r/v6k5q81QB1CkxDLJoi/G1vIzgdq+SaUH8Dd
         pnPKbvgp4rNwkuTfoe2Mom+qHxmWJVHb8d1Olhae9QW93fHER4BxH5rKrUjP+s7rpwgl
         p8kQ==
Received: by 10.112.83.104 with SMTP id p8mr4814168lby.41.1350337135673;
        Mon, 15 Oct 2012 14:38:55 -0700 (PDT)
Received: from localhost.localdomain (broadband-95-84-154-9.nationalcablenetworks.ru. [95.84.154.9])
        by mx.google.com with ESMTPS id h8sm4953930lbk.0.2012.10.15.14.38.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 15 Oct 2012 14:38:54 -0700 (PDT)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Antony Pavlov <antonynpavlov@gmail.com>
Subject: [PATCH 1/2] MIPS: JZ4740: fix '#include guard' in serial.h
Date:   Tue, 16 Oct 2012 01:38:46 +0400
Message-Id: <1350337127-11315-1-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 1.7.10.4
X-archive-position: 34706
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
---
 arch/mips/jz4740/serial.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/jz4740/serial.h b/arch/mips/jz4740/serial.h
index b9fe3ad..aa5a939 100644
--- a/arch/mips/jz4740/serial.h
+++ b/arch/mips/jz4740/serial.h
@@ -14,6 +14,7 @@
  */
 
 #ifndef __MIPS_JZ4740_SERIAL_H__
+#define __MIPS_JZ4740_SERIAL_H__
 
 void jz4740_serial_out(struct uart_port *p, int offset, int value);
 
-- 
1.7.10.4
