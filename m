Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Oct 2004 18:33:42 +0100 (BST)
Received: from smtp.vmb-service.ru ([IPv6:::ffff:80.73.198.33]:28619 "EHLO
	smtp.vmb-service.ru") by linux-mips.org with ESMTP
	id <S8225347AbUJORdg>; Fri, 15 Oct 2004 18:33:36 +0100
Received: from PIX-NAT.vmb-service.ru ([80.73.192.74]:46598 "EHLO alec")
	by Altair with ESMTP id <S1160226AbUJORdX>;
	Fri, 15 Oct 2004 21:33:23 +0400
Reply-To: <a.voropay@vmb-service.ru>
From: "Alec Voropay" <a.voropay@vmb-service.ru>
To: <linux-mips@linux-mips.org>
Subject: PATCH:  JAZZ jazzdma.c  linux_2_4
Date: Fri, 15 Oct 2004 21:35:49 +0400
Organization: VMB-Service
Message-ID: <013201c4b2dd$6c4e64d0$1701a8c0@vmbservice.ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4942.400
Importance: Normal
Return-Path: <a.voropay@vmb-service.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6064
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.voropay@vmb-service.ru
Precedence: bulk
X-list: linux-mips



Spellcheck


diff -Naur -p -X dontdiff linux_2_4/arch/mips/jazz/jazzdma.c
linux_2_4-jazz/arch/mips/jazz/jazzdma.c
--- linux_2_4/arch/mips/jazz/jazzdma.c  Wed Oct 22 04:29:14 2003
+++ linux_2_4-jazz/arch/mips/jazz/jazzdma.c     Fri Oct 15 20:44:52 2004
@@ -108,7 +108,7 @@ unsigned long vdma_alloc(unsigned long p
                return VDMA_ERROR;      /* invalid physical address */
        }

-       spin_lock_saveirq(&jazz_dma_lock, flags);
+       spin_lock_irqsave(&jazz_dma_lock, flags);

        /*
         * Find free chunk
@@ -120,7 +120,7 @@ unsigned long vdma_alloc(unsigned long p
                       first < VDMA_PGTBL_ENTRIES) first++;
                if (first + pages > VDMA_PGTBL_ENTRIES) {
                        /* nothing free */
-                       spin_unlock_restoreirq(&jazz_dma_lock, flags);
+                       spin_unlock_irqrestore(&jazz_dma_lock, flags);
                        return VDMA_ERROR;
                }

@@ -167,7 +167,7 @@ unsigned long vdma_alloc(unsigned long p
                printk("\n");
        }

-       spin_unlock_restoreirq(&jazz_dma_lock, flags);
+       spin_unlock_irqrestore(&jazz_dma_lock, flags);

        return laddr;
 }
