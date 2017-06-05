Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jun 2017 19:10:56 +0200 (CEST)
Received: from mail-wr0-x243.google.com ([IPv6:2a00:1450:400c:c0c::243]:35437
        "EHLO mail-wr0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991512AbdFERKs0UoFK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Jun 2017 19:10:48 +0200
Received: by mail-wr0-x243.google.com with SMTP id g76so8026082wrd.2;
        Mon, 05 Jun 2017 10:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RaHxKEA7PD8t2BRHVbFyTlKEsaurzcZhE8Rf1fvp/K8=;
        b=czuJj/DbOcFuD5lWmGtMTUqpAJ9og96ouiVAdlwTi87gESGYv5yP6PfS8Bzjbg0OFw
         Hn3kq2Bm9LVL6WE1Of6GkRgSvEj8Xu8zafl11F2OwKKQKfGdp94ewZjfTMBQ3MDkiQ37
         0IlyYKE8PiLFUQaa2KTwtrBC3V/vUiFSscHQmCUMgukxAhy7VffhhaOyiSh0xeWSJHJh
         Yn50pHfDjD1uEaOh1HuwUQwgkYVQkc1g4c0kVCn2f17WdZAOOjGhi5H4IES6w9b6yU9B
         BV7GT1jQt0OP//5uP4cx0KDw7awJGi81MlZ2UN206FyFLUgdO/0NN81n05goqFybPcCs
         RLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RaHxKEA7PD8t2BRHVbFyTlKEsaurzcZhE8Rf1fvp/K8=;
        b=UTy9+FPMh4vnsYBu05HMHxojkEJ3xVqG42oOKE8d72aJfvhmYfzfyOeIetBijpQJ0h
         r0m1kyJtQpVZfyNl2J3CMJeyUCMacfX3bq39ip2du8znhih5p3Y5kta9xORnGd95PM8x
         6/rVZRrLRC9mgTNIhs3wbFreM8T7g1/EJ2vCV7lDbRWbKuoki/xgLDtcbInCnxTQCd2R
         6nXHil6jh9cCK5GBaks7rikZc9LTMuXM0OqDx95hPnWpxq2tq3D/Xq/r9StODNJm3/aA
         79leOfRY/B+NglXU9c8QeFBPijvaBdEK0bMfBKReKBAtGn5dMkGoFVQYDZlvflRtxGbc
         VjJQ==
X-Gm-Message-State: AODbwcAp4Kw+kz/Zz2m3O6e7KJtVGJ12V9R97dqfi3bYxaqGx76pBEHx
        yKro/UQA7rnh3072jLQ=
X-Received: by 10.223.161.69 with SMTP id r5mr167809wrr.0.1496682640155;
        Mon, 05 Jun 2017 10:10:40 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id p139sm156567wmb.22.2017.06.05.10.10.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jun 2017 10:10:39 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     msalter@redhat.com, dmitry.torokhov@gmail.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] MIPS: Make individual platforms select ARCH_MIGHT_HAVE_PC_SERIO
Date:   Mon,  5 Jun 2017 10:10:32 -0700
Message-Id: <20170605171033.15008-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.9.3
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58212
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

Out of the many MIPS platforms only 3 appear to be actually using an
I8042 keyboard controller: SGI, JAZZ and LOOGSON64, remove
ARCH_MIGHT_HAVE_PC_SERIO from the top-level MIPS Kconfig symbol and move
it down to those platforms that need it.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 0b15978c0f88..c96547cdca61 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -7,7 +7,6 @@ config MIPS
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_MIGHT_HAVE_PC_PARPORT
-	select ARCH_MIGHT_HAVE_PC_SERIO
 	select ARCH_SUPPORTS_UPROBES
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF if 64BIT
@@ -347,6 +346,7 @@ config MACH_JAZZ
 	select I8253
 	select I8259
 	select ISA
+	select ARCH_MIGHT_HAVE_PC_SERIO
 	select SYS_HAS_CPU_R4X00
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL
@@ -423,6 +423,7 @@ config MACH_LOONGSON32
 
 config MACH_LOONGSON64
 	bool "Loongson-2/3 family of machines"
+	select ARCH_MIGHT_HAVE_PC_SERIO
 	select SYS_SUPPORTS_ZBOOT
 	help
 	  This enables the support of Loongson-2/3 family of machines.
@@ -1294,6 +1295,7 @@ config SGI_HAS_ZILOG
 	bool
 
 config SGI_HAS_I8042
+	select ARCH_MIGHT_HAVE_PC_SERIO
 	bool
 
 config DEFAULT_SGI_PARTITION
-- 
2.9.3
