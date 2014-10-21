Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2014 06:31:21 +0200 (CEST)
Received: from mail-pa0-f50.google.com ([209.85.220.50]:49670 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011991AbaJUE2wZrVE9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Oct 2014 06:28:52 +0200
Received: by mail-pa0-f50.google.com with SMTP id kx10so513552pab.23
        for <multiple recipients>; Mon, 20 Oct 2014 21:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wK+0WH1CQCr/ZoFQQDwrS7MQ6zWpwnvmYA/GTvqwV0k=;
        b=aBO6ZwLe4fYJq0qWfPotzyF1Hj/epVtg/MnJAijT1sV8sAl+frir3SR+nUeGlzcuPi
         /kCxsOLOV5JSRF0nAo8JjBMcHkuqbaVRaaM75Qwh+SW3SLQBFJQCjnkgwuaE6EmdX1Dl
         UopzZO+gGjvphxeFCIuPsI5qyMGJim3yIGSyvY4DLe9LBpGmSE+vk6mL6gyOjJJKsmlN
         qqCsLOYNjnPNVDdqzCYBnnNGjCAwM7lrsyP8UjPZcI0dZHVcVCI5nZ2sKxC/lozLJI2v
         TZPF+TPIPpfxdzBO59P9+p97zoyxezvdSm0LWOZdTc+xwHYr6DD5b3ouQ4qmo9M7naL2
         jU6g==
X-Received: by 10.66.242.14 with SMTP id wm14mr31877381pac.77.1413865725788;
        Mon, 20 Oct 2014 21:28:45 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id b2sm10498181pbu.42.2014.10.20.21.28.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 20 Oct 2014 21:28:45 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org,
        jfraser@broadcom.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
Subject: [PATCH/RFC 08/17] MIPS: BMIPS: Select the appropriate L1_CACHE_SHIFT for 438x and 5000 CPUs
Date:   Mon, 20 Oct 2014 21:27:58 -0700
Message-Id: <1413865687-15255-9-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413865687-15255-1-git-send-email-cernekee@gmail.com>
References: <1413865687-15255-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43407
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

BMIPS438x has a 64-byte D$ line size and BMIPS5000 has a 128-byte L2
line size.  If L1_CACHE_SHIFT is undersized, DMA buffers will not be
cacheline-aligned and terrible things will happen.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 37b085c..38e02e1 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1587,12 +1587,14 @@ config CPU_BMIPS4350
 
 config CPU_BMIPS4380
 	bool
+	select MIPS_L1_CACHE_SHIFT_6
 	select SYS_SUPPORTS_SMP
 	select SYS_SUPPORTS_HOTPLUG_CPU
 
 config CPU_BMIPS5000
 	bool
 	select MIPS_CPU_SCACHE
+	select MIPS_L1_CACHE_SHIFT_7
 	select SYS_SUPPORTS_SMP
 	select SYS_SUPPORTS_HOTPLUG_CPU
 
-- 
2.1.1
