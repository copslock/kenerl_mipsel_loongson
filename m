Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Aug 2017 01:05:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:49686 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23995127AbdHGXDwZXUII (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Aug 2017 01:03:52 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 98F2E6D008D9C;
        Tue,  8 Aug 2017 00:03:41 +0100 (IST)
Received: from localhost (10.20.1.88) by HHMAIL01.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 8 Aug 2017 00:03:46
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 7/7] MIPS: generic: Bump default NR_CPUS to 16
Date:   Mon, 7 Aug 2017 16:01:18 -0700
Message-ID: <20170807230119.10629-8-paul.burton@imgtec.com>
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
X-archive-position: 59413
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

In generic_defconfig set CONFIG_NR_CPUS to 16 rather than 2, which is a
rather too low limit for many modern day MIPS systems.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org

---

 arch/mips/configs/generic_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/configs/generic_defconfig b/arch/mips/configs/generic_defconfig
index a638028b1425..26b1cd5ffbf5 100644
--- a/arch/mips/configs/generic_defconfig
+++ b/arch/mips/configs/generic_defconfig
@@ -3,7 +3,7 @@ CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_MIPS_CPS=y
 CONFIG_CPU_HAS_MSA=y
 CONFIG_HIGHMEM=y
-CONFIG_NR_CPUS=2
+CONFIG_NR_CPUS=16
 CONFIG_MIPS_O32_FP64_SUPPORT=y
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ_IDLE=y
-- 
2.14.0
