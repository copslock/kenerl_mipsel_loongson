Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Aug 2017 01:02:47 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:31776 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994864AbdHGXCStvVuI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Aug 2017 01:02:18 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id D8C50A78824F1;
        Tue,  8 Aug 2017 00:02:07 +0100 (IST)
Received: from localhost (10.20.1.88) by HHMAIL01.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 8 Aug 2017 00:02:12
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 2/7] MIPS: SEAD-3: Only include in 32 bit kernels by default
Date:   Mon, 7 Aug 2017 16:01:13 -0700
Message-ID: <20170807230119.10629-3-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.0
In-Reply-To: <20170807230119.10629-1-paul.burton@imgtec.com>
References: <20170807230119.10629-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59408
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The MIPS SEAD-3 development board has only ever been used with 32 bit
CPUs, so including support for it in 64 bit kernels is wasteful since
those kernels will never run on a SEAD-3.

Specify a requirement in the SEAD-3 board config fragment that ensures
the board support is only included in 32 bit kernels, by checking that
CONFIG_32BIT=y.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/configs/generic/board-sead-3.config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/configs/generic/board-sead-3.config b/arch/mips/configs/generic/board-sead-3.config
index 3b5e1ac579eb..df49a592dbb5 100644
--- a/arch/mips/configs/generic/board-sead-3.config
+++ b/arch/mips/configs/generic/board-sead-3.config
@@ -1,3 +1,5 @@
+# require CONFIG_32BIT=y
+
 CONFIG_LEGACY_BOARD_SEAD3=y
 
 CONFIG_AUXDISPLAY=y
-- 
2.14.0
