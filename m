Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2015 16:07:25 +0100 (CET)
Received: from mail-wi0-f181.google.com ([209.85.212.181]:38964 "EHLO
        mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012216AbbA2PGzm8GAv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Jan 2015 16:06:55 +0100
Received: by mail-wi0-f181.google.com with SMTP id fb4so25754246wid.2;
        Thu, 29 Jan 2015 07:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nxl6GbT6090iQT/j119AxQcjOWU8A6GszSYaw9GgXLs=;
        b=yy8qDobwL4irkVKYJIwKVzOu9IOV8AygQGfB1h+xRegDucHvvabokLBJ9bghx/uluR
         S4yn5OVKT2CHKbWQVhCVoVVpIl33C9kYCGD8GCTiTuRiKxEBukhDlfb7ek7SPnJtpWEr
         ewCwuP2L4wSdBOXkUSYhdDWzVlId89Jtmw4RJnUkyC931bWFqzOjRHYWx4yOYRqyhI5R
         3H2p2faeZ456QkAq0mj05Nx7lje2XhE1zFb5xkwlpv2pa/kmXFsDg2G9mkBrk4NirrKG
         rVrVLOIy0xz2NcI4zHIROqTkEbP1G6ZTuJV1F4NW7JVr5t3TmDu9/O4by+FNRcSWeP0k
         205A==
X-Received: by 10.180.206.47 with SMTP id ll15mr2116021wic.34.1422544010471;
        Thu, 29 Jan 2015 07:06:50 -0800 (PST)
Received: from dargo.Speedport_W_724V_01011603_00_005 (p4FCD26FC.dip0.t-ipconnect.de. [79.205.38.252])
        by mx.google.com with ESMTPSA id lk2sm2828460wic.22.2015.01.29.07.06.48
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Jan 2015 07:06:48 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH v2 3/3] MIPS: Alchemy: remove declaration for set_cpuspec
Date:   Thu, 29 Jan 2015 16:06:44 +0100
Message-Id: <1422544004-25254-3-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1422544004-25254-1-git-send-email-manuel.lauss@gmail.com>
References: <1422544004-25254-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45536
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

set_cpuspec() has been dropped with commit 074cf656700ddd1d2bd7f815f78e785418beb898
("MIPS: Alchemy: remove cpu_table.") in late 2008.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
v2: initial patch

 arch/mips/alchemy/common/setup.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/alchemy/common/setup.c b/arch/mips/alchemy/common/setup.c
index 9a0c4c8..2902138 100644
--- a/arch/mips/alchemy/common/setup.c
+++ b/arch/mips/alchemy/common/setup.c
@@ -34,7 +34,6 @@
 #include <au1000.h>
 
 extern void __init board_setup(void);
-extern void set_cpuspec(void);
 extern void __init alchemy_set_lpj(void);
 
 void __init plat_mem_setup(void)
-- 
2.2.2
