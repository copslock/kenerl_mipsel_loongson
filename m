Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 May 2016 14:04:08 +0200 (CEST)
Received: from mail-lb0-f195.google.com ([209.85.217.195]:34174 "EHLO
        mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27032454AbcEUMBY1LORI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 May 2016 14:01:24 +0200
Received: by mail-lb0-f195.google.com with SMTP id t6so60437lbv.1;
        Sat, 21 May 2016 05:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=/xSi1e3hC5skNPVD1E+ZkL/VEZ5OZwAkh/pJH+TqEUE=;
        b=IBe3lTby+15yhkCUX4L6AQhkgo5oLkoqSISBIXcztiumuDXIgbXEeyPrBYHHBN3QiF
         kbJ1nNgUfDyCa8hcVc1+k3qPHV5L0e7rBozNNL6QyBaALomJk48MhINY6lpCuwjY5Xat
         PG6kX356J2/IqRzkNWm6fv4A403NKEZ5RuWOuoeRz/ynADKsJu/ysMvwgcrV+jHRoY8j
         6+UjCNstx5Vb/ykdjJeEXlW7Cce+LqejqqpwHix0Tfspn8a4VMF3wHPSmGRZ2vYVJERO
         SbOLkNkmdX14yAi9Uj08zfOKOU46V8I3hjb7p37rWakccEpdfLt31oYVXq5MAGJ1Ch44
         mC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=/xSi1e3hC5skNPVD1E+ZkL/VEZ5OZwAkh/pJH+TqEUE=;
        b=QqTyyfXkmpYrajruiCnzvMZcpLPULTMict3sT2Ixry6XavfMYXq/5bojiGXaooBlXK
         7Mfc0ybVkzWsLznsScIhI70iUwQUS+dT8SYla8kIbgwoFAWp3H5Y9L9P+8ypyDhGE094
         d3IrE5eLzCVnpEcjHar6SkZEgheD9IvfflcA3U8jKvVSO3l0zeLqugZpUB9HvS9b8Aa6
         m39rfXUX3j/DWXX73fX9rXUrre1g5SpPnCGQL48SuDzSonU2vtXuZzbvRtkVpUcdMlL2
         Ma5QkpqFUxc/EEtxx97QE6S+wJBrBEPsgjmh/WZlT4GsHCh4YiI/iXdb5gXV+3VDabFf
         Hung==
X-Gm-Message-State: AOPr4FUkqGKSxiVjzQYMyERwIrjGUc/RFWIP0vAKWYGs+MZeZwCIEwL8Hz495UUi0dig9A==
X-Received: by 10.112.20.35 with SMTP id k3mr2820990lbe.75.1463832077267;
        Sat, 21 May 2016 05:01:17 -0700 (PDT)
Received: from glen.ipredator.se (anon-35-25.vpn.ipredator.se. [46.246.35.25])
        by smtp.gmail.com with ESMTPSA id zw6sm4032873lbb.14.2016.05.21.05.01.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 21 May 2016 05:01:15 -0700 (PDT)
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
To:     andrea.gelmini@gelma.net
Cc:     trivial@kernel.org, ralf@linux-mips.org, adam.buchbinder@gmail.com,
        linux-mips@linux-mips.org
Subject: [PATCH 0192/1529] Fix typo
Date:   Sat, 21 May 2016 14:01:12 +0200
Message-Id: <20160521120112.9931-1-andrea.gelmini@gelma.net>
X-Mailer: git-send-email 2.8.2.534.g1f66975
Return-Path: <andrea.gelmini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53590
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrea.gelmini@gelma.net
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

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/mips/include/asm/sgi/hpc3.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/sgi/hpc3.h b/arch/mips/include/asm/sgi/hpc3.h
index 4a9c990..c0e3dc0 100644
--- a/arch/mips/include/asm/sgi/hpc3.h
+++ b/arch/mips/include/asm/sgi/hpc3.h
@@ -39,7 +39,7 @@ struct hpc3_pbus_dmacregs {
 	volatile u32 pbdma_dptr;	/* pbus dma channel desc ptr */
 	u32 _unused0[0x1000/4 - 2];	/* padding */
 	volatile u32 pbdma_ctrl;	/* pbus dma channel control register has
-					 * copletely different meaning for read
+					 * completely different meaning for read
 					 * compared with write */
 	/* read */
 #define HPC3_PDMACTRL_INT	0x00000001 /* interrupt (cleared after read) */
-- 
2.8.2.534.g1f66975
