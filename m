Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2015 19:27:48 +0100 (CET)
Received: from mail-io0-f180.google.com ([209.85.223.180]:36023 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007036AbbLHS1rFLdSe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2015 19:27:47 +0100
Received: by iofh3 with SMTP id h3so33241121iof.3
        for <linux-mips@linux-mips.org>; Tue, 08 Dec 2015 10:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=5ubojbb1moAgyHhPg7d+Zbje1MUXCxx7zuSYHaCMfnA=;
        b=NrTuF/r7jk24a3XgDLtGGEOODV/rVGjaP+g4smP/zCxCEJiNHqZBYMYDI26AM+vMuo
         gQfzjETeBKWiN0kFgSPSd23LDPCMCiubbx0zcLvJ4rTnZCAL1tnpB5vtVdlblbqR+XCV
         VSBhJGsva54Nd8EDrXVWxSSeVlhbO+mZvrxTrlTEw2zFqEMfoYrcNpnCP8UFToB7WVyN
         Qiq+kslgrQm2c3UZK8OdoFTD6U2WuNPtctkq+IjXhKKKAxsf6BIVCbsV0uSJOFSLnPkb
         4Anj/BsiuKinWdIsze+swSgCGm+E/rxRTQKj/O8ijQCPc+WjpkZhoxedv2ch9VSkGu/z
         pHvg==
X-Received: by 10.107.17.160 with SMTP id 32mr1421486ior.28.1449599261118;
        Tue, 08 Dec 2015 10:27:41 -0800 (PST)
Received: from kolya-laptop.shuttercorp.net (dhcp-108-170-142-183.cable.user.start.ca. [108.170.142.183])
        by smtp.gmail.com with ESMTPSA id x4sm1798194igw.12.2015.12.08.10.27.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Dec 2015 10:27:40 -0800 (PST)
From:   Nikolay Martynov <mar.kolya@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Nikolay Martynov <mar.kolya@gmail.com>
Subject: [PATCH] mips: Fix CPC_BASE_ADDR mask to match datasheet
Date:   Tue,  8 Dec 2015 13:27:02 -0500
Message-Id: <1449599222-8967-1-git-send-email-mar.kolya@gmail.com>
X-Mailer: git-send-email 2.6.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <mar.kolya@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50447
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mar.kolya@gmail.com
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

According to 'MIPS32® interAptivTM Multiprocessing
System Programmer’s Guide' CPC_BASE_ADDR takes bits [31:15].

This change is tested ith mt7621 which wasn't working without it.

Signed-off-by: Nikolay Martynov <mar.kolya@gmail.com>
---
 arch/mips/include/asm/mips-cm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index 6516e9d..f942ec2 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -286,8 +286,8 @@ BUILD_CM_Cx_R_(tcid_8_priority,	0x80)
 #define CM_GCR_GIC_BASE_GICEN_MSK		(_ULCAST_(0x1) << 0)
 
 /* GCR_CPC_BASE register fields */
-#define CM_GCR_CPC_BASE_CPCBASE_SHF		17
-#define CM_GCR_CPC_BASE_CPCBASE_MSK		(_ULCAST_(0x7fff) << 17)
+#define CM_GCR_CPC_BASE_CPCBASE_SHF		15
+#define CM_GCR_CPC_BASE_CPCBASE_MSK		(_ULCAST_(0x1ffff) << 15)
 #define CM_GCR_CPC_BASE_CPCEN_SHF		0
 #define CM_GCR_CPC_BASE_CPCEN_MSK		(_ULCAST_(0x1) << 0)
 
-- 
2.6.3
