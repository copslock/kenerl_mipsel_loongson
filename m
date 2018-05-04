Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 May 2018 21:05:48 +0200 (CEST)
Received: from mail-pg0-x241.google.com ([IPv6:2607:f8b0:400e:c05::241]:33826
        "EHLO mail-pg0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991819AbeEDTFmMbqOf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 May 2018 21:05:42 +0200
Received: by mail-pg0-x241.google.com with SMTP id g20-v6so9349500pgv.1;
        Fri, 04 May 2018 12:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RNStCdXa0WjaPBzLSJs4J472Lz/BGcsyz8q4Hyt7EFY=;
        b=eMC/T5clAGsN9TkVkIk1cTiKMR8mnG8R4MQlXweimfWOLP+VKOL5ezh3KurEATJAyO
         WP1SfKsX6msgFciDlOtAh3kV1rwpAxQ7LfYJCXtCW/+UaXI2qB0R4qU+O4yvdKdbQBJc
         J1ojVCY/Qh4JYKxSnVU3bdfdDXY5EVf0awkj1m9oBdvL8N3oFN1S2wirOnTytxnSY8de
         g3W75Bl5YfmVdw7qvuA1Wl9xKoWmTTJ6Mua8li2yNtpKj6g/Nm/zLZk5cWh+j+rl1m5C
         iivxB53spXSNKzFKV5XEyZEdD55g90YhiBQfGtllCh8FEdzxCHHrquI9dtjQr6yH7XDD
         rkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RNStCdXa0WjaPBzLSJs4J472Lz/BGcsyz8q4Hyt7EFY=;
        b=fghVoRqPVSmXyWVXE6LnaucT0EfO+NEl5unc/OwWPLwjiqT1KxtHs/GtVvCo/hUJWZ
         JTqMbf+Zyp6lSJLd0lFiNmdhkiJE/zkMH9Vz7OIWetwrPcwiEACr0oSL3TSLqvwKyrLB
         3flc562xNK8NXEo2fY6Vy9/gDdJKTf4Ef/EuZhfvjaZxRC3gNk9P4LMppJ9YBG6mgW7t
         pmFQlbdq4ZMsUChUwj7X2LCTfUDvSD2XkHZsnPMB5U9OnXWjYtb80ot/ENsBtvIp7SwG
         BvXHmuLD5Qaa5EGKoOQUxcfoFRmOW0fJXDpmFhUifXIMrEtybCO3018JLWBw/CsB4C4a
         Rt3Q==
X-Gm-Message-State: ALQs6tBGD1oWhRNUNYcVUyt9OLld9FMYdPiIPONX56ly4JMMPlVZ6CPj
        yyZsoEc3CacLeYLVk/jTEq1rmg==
X-Google-Smtp-Source: AB8JxZrNM7wAawFxLp1gQ6fCewYnH9cTbwS7v8zoOG4fXcNcqS37sAgCbFechnxgWdXWGesBNKXzrQ==
X-Received: by 2002:a17:902:b087:: with SMTP id p7-v6mr27148850plr.227.1525460735428;
        Fri, 04 May 2018 12:05:35 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:877f:9499::c68])
        by smtp.gmail.com with ESMTPSA id o10-v6sm30609399pgc.80.2018.05.04.12.05.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 May 2018 12:05:34 -0700 (PDT)
From:   Khem Raj <raj.khem@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Khem Raj <raj.khem@gmail.com>, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] mips: Disable attribute-alias warnings
Date:   Fri,  4 May 2018 12:05:30 -0700
Message-Id: <20180504190530.1879-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.17.0
Return-Path: <raj.khem@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63873
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raj.khem@gmail.com
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

This warning is seen with gcc-8

error: 'sys_cachectl' alias between functions of incompatible types
'long int(char *, int,  int)'
and 'long int(long int,  long int,  long int)'

Signed-off-by: Khem Raj <raj.khem@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/kernel/Makefile | 2 ++
 arch/mips/mm/Makefile     | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index f10e1e15e1c6..eb92e52eb3db 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -2,6 +2,8 @@
 #
 # Makefile for the Linux/MIPS kernel.
 #
+CFLAGS_signal.o		+= $(call cc-disable-warning, attribute-alias)
+CFLAGS_syscall.o	+= $(call cc-disable-warning, attribute-alias)
 
 extra-y		:= head.o vmlinux.lds
 
diff --git a/arch/mips/mm/Makefile b/arch/mips/mm/Makefile
index c463bdad45c7..b7f9ef80dac7 100644
--- a/arch/mips/mm/Makefile
+++ b/arch/mips/mm/Makefile
@@ -2,6 +2,7 @@
 #
 # Makefile for the Linux/MIPS-specific parts of the memory manager.
 #
+CFLAGS_cache.o			+= $(call cc-disable-warning, attribute-alias)
 
 obj-y				+= cache.o dma-default.o extable.o fault.o \
 				   gup.o init.o mmap.o page.o page-funcs.o \
-- 
2.17.0
