Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Aug 2013 20:41:02 +0200 (CEST)
Received: from mail-ie0-f182.google.com ([209.85.223.182]:59282 "EHLO
        mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822308Ab3HHSk7YZm-U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Aug 2013 20:40:59 +0200
Received: by mail-ie0-f182.google.com with SMTP id tp5so2537625ieb.13
        for <multiple recipients>; Thu, 08 Aug 2013 11:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=zi/HD2jdlUfHMUaumJrj0DMtb/iCp3yo4gjG5bk0fWE=;
        b=kjg6xlgZGpllq9vZdCaAgoX0jeozmC/OB8Kc42XmljFu7KN1KhaXi6UwJyLkcclasQ
         msLYm0eyb+DG0mkIeYlKvZHhSThV1/8dXDSBXNFifNdPNUbfuMZdnxWKfQuoTpSfXJRP
         kSYoHQYrRt5AMq+/mCO+fef98mlrgj6spJ8gBaIkIs3U1jKib8AbcQA7Y8JAFiff3dbd
         1kwZlsF/zACQUKrG8JNyo+W5rKj7m65tt1/nA8asc2BKPDog5CgCRbvjzseV0DfBD3dz
         qSG/nDeXLBlc2opSY6Dj4g9MtefnH+k34N1pNSv1FPm0p4FpzqHrISJpLK1C45nquBey
         eXUg==
X-Received: by 10.50.152.9 with SMTP id uu9mr123841igb.53.1375987253256;
        Thu, 08 Aug 2013 11:40:53 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id vc13sm7636700igb.1.2013.08.08.11.40.51
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 08 Aug 2013 11:40:52 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r78IeoVl003758;
        Thu, 8 Aug 2013 11:40:50 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r78IeoEm003757;
        Thu, 8 Aug 2013 11:40:50 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH v2] MIPS: Discard .eh_frame sections in linker script.
Date:   Thu,  8 Aug 2013 11:40:49 -0700
Message-Id: <1375987249-3724-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37487
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

Some toolchains (including Cavium OCTEON SDK) are emitting .eh_frame
sections by default.  Discard them as they are useless in the kernel.

Signed-off-by: David Daney <david.daney@cavium.com>
---

Changes from v1: Fix changelog spelling.

 arch/mips/kernel/vmlinux.lds.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 05826d2..3b46f7c 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -179,5 +179,6 @@ SECTIONS
 		*(.options)
 		*(.pdr)
 		*(.reginfo)
+		*(.eh_frame)
 	}
 }
-- 
1.7.11.7
