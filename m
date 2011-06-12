Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Jun 2011 20:59:08 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:44815 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491065Ab1FLS5g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 12 Jun 2011 20:57:36 +0200
Received: by wyb28 with SMTP id 28so3834930wyb.36
        for <multiple recipients>; Sun, 12 Jun 2011 11:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:to:cc:subject:date:message-id
         :x-mailer:in-reply-to:references;
        bh=F5WQuaffYZiyBqJtIFIUvVQtW/dO8a6s/mJcjvgSHxE=;
        b=sO6dSoEHMxN5aogvnmJQ5fVnGIM39A0Dgu+9MCXGD4Bzsb3vz4q6jRFd3/kcv6EucQ
         WyE1attz4o7k+5Jw9dELrAhXSLVzQ1kH2E+cesmMzrgc7MszfDnN2Ett5Ra7pKN1glYb
         0DmpSz25iqkxU0ikg+/4eZXilaLozXFznBVS4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=BYuLD2Wruzk5zdg6bFWIVz5P4pbGJC2pAfgBkw9n/1+cccjGKeH5PBN+BN26d7HkLV
         Mp2nM7T6Wf7V2aQZ6m6mOWfLIcEfpY+Qmq+5m0lmyLLzSs8+VfqCo7F1IIgE0G4ixorJ
         HSb51RJF0aKW/UoEdODIf9tIdpktmNesePoCM=
Received: by 10.227.168.207 with SMTP id v15mr4380324wby.50.1307905050027;
        Sun, 12 Jun 2011 11:57:30 -0700 (PDT)
Received: from localhost.localdomain (fbx.mimichou.net [82.236.225.16])
        by mx.google.com with ESMTPS id et5sm3674911wbb.16.2011.06.12.11.57.28
        (version=SSLv3 cipher=OTHER);
        Sun, 12 Jun 2011 11:57:29 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 5/5] MIPS: ar7: use linux/time.h instead of asm/time.h
Date:   Sun, 12 Jun 2011 20:57:21 +0200
Message-Id: <1307905041-18391-5-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1307905041-18391-1-git-send-email-florian@openwrt.org>
References: <1307905041-18391-1-git-send-email-florian@openwrt.org>
X-archive-position: 30359
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10220

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/ar7/time.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/ar7/time.c b/arch/mips/ar7/time.c
index 22c9321..37777bf 100644
--- a/arch/mips/ar7/time.c
+++ b/arch/mips/ar7/time.c
@@ -22,8 +22,8 @@
 #include <linux/time.h>
 #include <linux/err.h>
 #include <linux/clk.h>
+#include <linux/time.h>
 
-#include <asm/time.h>
 #include <asm/mach-ar7/ar7.h>
 
 void __init plat_time_init(void)
-- 
1.7.4.1
