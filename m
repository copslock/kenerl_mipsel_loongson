Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Oct 2016 16:12:27 +0200 (CEST)
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35143 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990644AbcJYOMTKOYvP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Oct 2016 16:12:19 +0200
Received: by mail-wm0-f67.google.com with SMTP id o81so1264891wma.2;
        Tue, 25 Oct 2016 07:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=sdEqc1/1aa1n41YHsO8xeQFUe4Dm10q5eDY0iXB9YZw=;
        b=vmHg+eLMO4EpX04eHbdnFyuOVIl9YHM7QQOuf/sOF73mrD0paxrts+qrMv/EGbAeA/
         M87SrWkVilm2J2JKliqJVjY3fYurO/hUUXbb60pUZWmq4r4vxu5T33sL84NQ/Ezp7aQg
         p1POvrneBHoE7MyBNeIJgHPBbosmH9vDH2eXFo9pwLLJS3uvV8Ve/HJYNLDlfdFkzkP8
         AbSe1QpNZf3oKCMDV3AQf93Uj+0KduumYRdO5TaSWJ+D4s5MxOCAX1r4jJlQC+gbsMkS
         MSUp9xGFjtok8IbMXT35VDcazcrnYR5JlcqMTYqhFbZWWopPzJWBsJmuEPWZVgNfHx0y
         SsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sdEqc1/1aa1n41YHsO8xeQFUe4Dm10q5eDY0iXB9YZw=;
        b=UrFpYGMBDGUaVLz3naKW0F/M1+7AsM+WVH0aUiuYlPqp1t0aGdbhtnpXNIXwQ50WRe
         BTnAIFqfFdSpV1Zs5mx6BiN24QMj/Re9qRiC1UrEAs8OfxD+cJBvXT3XoTKP7iMIe0yP
         wrex95Uc/BSDNUVDN19AJV7M8lEtgyiHyW19qP5Z2Ycas5IUCrIqBrQb503HcZjmhVsu
         +Q7C76nhe1O+yet3q9s1hUeP/PV+lNSsN140PcXssWTzCJ8Zh2yGZtXhTBfXceWp1WWr
         8QMdv9Kq9z1jlPPhJOY08X9d9Iom5ZyO5+DA98tyb1f54/Br5xVi6ShVkOqZs11c9ntY
         hFAQ==
X-Gm-Message-State: ABUngvdd8ZkKbDVLaTnRvFLInP+maeyyPS00utyBfKGNGtE+4Wa9gSkvyYh9MDH6Db7Gqg==
X-Received: by 10.28.50.66 with SMTP id y63mr989738wmy.44.1477404732403;
        Tue, 25 Oct 2016 07:12:12 -0700 (PDT)
Received: from dargo.roarinelk.net (88-117-48-204.adsl.highway.telekom.at. [88.117.48.204])
        by smtp.gmail.com with ESMTPSA id u64sm3919455wmd.6.2016.10.25.07.12.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Oct 2016 07:12:11 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] MIPS: fix build with multiple PLATFORM strings
Date:   Tue, 25 Oct 2016 16:12:05 +0200
Message-Id: <20161025141205.244177-1-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.10.1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55570
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

Commit cf2a5e0bb (MIPS: Support generating Flattened Image Trees (.itb))
broke my alchemy devboard build, because it uses more than one entry
in the PLATFORM variable:

make -f kernel/linux/scripts/Makefile.build obj=arch/mips/boot/compressed \
        VMLINUX_LOAD_ADDRESS=[..] PLATFORM=alchemy/common/ alchemy/devboards/ [..] vmlinuz
make[2]: *** No rule to make target 'alchemy/devboards/'.  Stop.
make[1]: *** [arch/mips/Makefile:371: vmlinuz] Error 2

Fix this by wrapping the platform-y expansion in quotes.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index fbf40d3..1a6bac7 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -263,7 +263,7 @@ KBUILD_CPPFLAGS += -DDATAOFFSET=$(if $(dataoffset-y),$(dataoffset-y),0)
 
 bootvars-y	= VMLINUX_LOAD_ADDRESS=$(load-y) \
 		  VMLINUX_ENTRY_ADDRESS=$(entry-y) \
-		  PLATFORM=$(platform-y)
+		  PLATFORM="$(platform-y)"
 ifdef CONFIG_32BIT
 bootvars-y	+= ADDR_BITS=32
 endif
-- 
2.10.1
