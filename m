Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2012 23:40:47 +0200 (CEST)
Received: from mail-la0-f49.google.com ([209.85.215.49]:39711 "EHLO
        mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823038Ab2JOVjEdnx7S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Oct 2012 23:39:04 +0200
Received: by mail-la0-f49.google.com with SMTP id z14so3679407lag.36
        for <multiple recipients>; Mon, 15 Oct 2012 14:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=kEmcfkbqJdebmBvxHRMgJ7EzdbzcjIrov3M7D4WQElE=;
        b=Kb2ahKv67P33s0veZJoPym+ODVshSPpz69mGmy9r71Bm6kfNStKlnsoaXn+5+xTxKP
         g9VoNTstWwON2ROvKsjbS13qDbbgForN1bpO4fT/PStAxRc+k+B/F0gE1kspQXH73zgT
         5+jTjHA2vDLwZ1e6xht/Dkeugj9fXA09LHj3DSmTw3POI2EL/2AfaoIQ/g8PNPwPL0RT
         IdFWr3FA//3IeRi8zTqVMMe17EluT+XO9FkDmCWgkUd63xmW00NMa0rNJhw8r76RfjqV
         jNqfjqgei3ckm1Y1Flm1urrSGn8VPIDECMd63X7SYoVhIRoFCOvK4ymBY/hDudvWxF/9
         S31w==
Received: by 10.152.105.33 with SMTP id gj1mr11113717lab.49.1350337138965;
        Mon, 15 Oct 2012 14:38:58 -0700 (PDT)
Received: from localhost.localdomain (broadband-95-84-154-9.nationalcablenetworks.ru. [95.84.154.9])
        by mx.google.com with ESMTPS id h8sm4953930lbk.0.2012.10.15.14.38.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 15 Oct 2012 14:38:58 -0700 (PDT)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Antony Pavlov <antonynpavlov@gmail.com>
Subject: [PATCH 2/2] MIPS: JZ4740: add missing header file to serial.h
Date:   Tue, 16 Oct 2012 01:38:47 +0400
Message-Id: <1350337127-11315-2-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1350337127-11315-1-git-send-email-antonynpavlov@gmail.com>
References: <1350337127-11315-1-git-send-email-antonynpavlov@gmail.com>
X-archive-position: 34707
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

The 'uart_port' struct is used in the declaration of
the jz4740_serial_out() function.
This commit adds the missing header file containing
declaration of the 'uart_port' struct.

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
---
 arch/mips/jz4740/serial.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/jz4740/serial.h b/arch/mips/jz4740/serial.h
index aa5a939..dfc155c 100644
--- a/arch/mips/jz4740/serial.h
+++ b/arch/mips/jz4740/serial.h
@@ -16,6 +16,8 @@
 #ifndef __MIPS_JZ4740_SERIAL_H__
 #define __MIPS_JZ4740_SERIAL_H__
 
+#include <linux/serial_core.h>
+
 void jz4740_serial_out(struct uart_port *p, int offset, int value);
 
 #endif
-- 
1.7.10.4
