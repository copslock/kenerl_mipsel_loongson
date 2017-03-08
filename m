Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Mar 2017 02:47:27 +0100 (CET)
Received: from mail-qk0-x243.google.com ([IPv6:2607:f8b0:400d:c09::243]:35773
        "EHLO mail-qk0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993899AbdCHBqzC-lPG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Mar 2017 02:46:55 +0100
Received: by mail-qk0-x243.google.com with SMTP id o135so6600789qke.2;
        Tue, 07 Mar 2017 17:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OZTzgef7MA6U/jvdZkNWPsdqsiWJoq509KYI5FmDrTQ=;
        b=o4nBOEP2ywBrAnVm3Oib1I8vmevif6aYsmbEaxSlnMHGIsi0H0/9LnbOpI/RRe5PMT
         7NrvIZJ+OlY7otmb1+b7Rpr+8OhcpzlL7g+gvf3NtU/rXoxADIPM4KmptiFFvb1galJP
         GEnGjMroTu/vJnhBHHdf70p3FWxTKxAj/VK8ZSykcVNlnl5a4gXzMZtYtQcRiTuvGZGN
         LPPONsaJTlfXWhASBFzpKjkP1xA3DHT+gvmnoxvVh/kavLwEj1ORfh8aGwLcKRtvyY7q
         4WckIzMnR3iFzSnbKZgzvkRvAWlPMz6smikOaOE/hMxDtrG63cvRN1mflqe7S5rSOsDe
         h5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OZTzgef7MA6U/jvdZkNWPsdqsiWJoq509KYI5FmDrTQ=;
        b=sE50/Rmsi9UfifNPwTCKKoLiWbV2Q9Iafy1IslITkfy1Ql7mOtQTm1aLa2sDKPU5PT
         YCNTnriaqHdMZ3VR1KrUXKWoRByXNZPVe2Hp6XhTKlnOtnUw1uMOVWpG94HEX5TJBieg
         8DhNouDIN5sNmUSTurGxpO9E/tBkqGtt4jxe5ZioC9C+nUyv8uJp3S9vXTSNDp/MIEEw
         q+/HENxVwPef6B/luupjrgF7G3WPn6DGuEViCQXm8JY2CmUD+VOOYswxxl4SaSsxNQUP
         IQrRvoQ7X/6NUVFryhNpxgYfTUBXXnVk42AoWRXCWY4YBNXnYQBt+IUOUwfKCLXHgjOc
         I6rA==
X-Gm-Message-State: AMke39m4A0RulFBBSW9qg7llpvsPLnAqYMYf6Ri2BEN1eL9k4/uPXi558jhTi1IPKtHyjg==
X-Received: by 10.55.148.71 with SMTP id w68mr4458105qkd.268.1488937609421;
        Tue, 07 Mar 2017 17:46:49 -0800 (PST)
Received: from fainelli-desktop.irv.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id h27sm1198892qtf.24.2017.03.07.17.46.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Mar 2017 17:46:48 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, james.hogan@imgtec.com,
        paul.burton@imgtec.com, marcin.nowakowski@imgtec.com,
        justinpopo6@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 1/2] MIPS: kexec: Provide bootloader arguments by default
Date:   Tue,  7 Mar 2017 17:46:40 -0800
Message-Id: <20170308014641.16267-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170308014641.16267-1-f.fainelli@gmail.com>
References: <20170308014641.16267-1-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57077
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

In case we do not implement a _machine_kexec_shutdown callback to do
platform specific kexec shutdown operations, the most sensible thing to
do is to provide the kexec'd kernel with the same arguments we initially
booted with.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/kernel/machine_kexec.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/machine_kexec.c b/arch/mips/kernel/machine_kexec.c
index 8b574bcd39ba..8c5bbf302ab1 100644
--- a/arch/mips/kernel/machine_kexec.c
+++ b/arch/mips/kernel/machine_kexec.c
@@ -11,6 +11,7 @@
 #include <linux/delay.h>
 
 #include <asm/cacheflush.h>
+#include <asm/bootinfo.h>
 #include <asm/page.h>
 
 extern const unsigned char relocate_new_kernel[];
@@ -66,8 +67,14 @@ machine_kexec_cleanup(struct kimage *kimage)
 void
 machine_shutdown(void)
 {
-	if (_machine_kexec_shutdown)
+	if (_machine_kexec_shutdown) {
 		_machine_kexec_shutdown();
+	} else {
+		kexec_args[0] = fw_arg0;
+		kexec_args[1] = fw_arg1;
+		kexec_args[2] = fw_arg2;
+		kexec_args[3] = fw_arg3;
+	}
 }
 
 void
-- 
2.9.3
