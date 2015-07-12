Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 00:02:33 +0200 (CEST)
Received: from mail-ie0-f172.google.com ([209.85.223.172]:34741 "EHLO
        mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010472AbbGLWCLeqUM2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2015 00:02:11 +0200
Received: by iebmu5 with SMTP id mu5so223557306ieb.1
        for <linux-mips@linux-mips.org>; Sun, 12 Jul 2015 15:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:from:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=HUOzm81gXDUFMUCVjOKlh//uL1flnRxJxETARgOFxb0=;
        b=iQS6rQ90G5X7KEj2pvi1IiHXhLGdaAkJ+iOd29EirJ+64WQWxidiH+dSZpq67m53xz
         HadszXnFysIn+y6bxcc2pYMTzppEpSmT52yi2ie7xJrYP3BDEikw5UAKUxkCjqDscDLV
         KAXI5AweacDfsGEAIQRxB2+xj1RDbAUiP5VPRwFwEh+r71EBTzHH/2Yp6wMhWUQ21k0M
         EWU124+KC566v1lOJeaHGxtocXuo72/4AQ11aaL4UlfpatZBc9M1KM8FJu4+IXECRUFf
         3PdlvcViGR6toZXB0SJJpFXtn4tKWmr3adAVgpZMIPwcIbwXoTLCs+1s2cN0369KpdiS
         mPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:from:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=HUOzm81gXDUFMUCVjOKlh//uL1flnRxJxETARgOFxb0=;
        b=e3xGYVZTljXc4p2bWmN/qj1/TdFTlH81OpEOqT/k/QmZZS2DEo2fKYOxF1umuPkFSR
         Wx8uzsbEidNt+sHa2+J71Qpw0H2PUXZtSZVzik5igvTiAzthDG20r61zn8cEtv9ELN0I
         Dnc5toxEay2uR1O/oLoChQ7ww6B64j48b1MJXX5Y7vqWS4Jzl9EYGnUtidtfgAEDia/8
         +Wh2FmqEuj59rVC5yMyoxJuqAo8pT9z7M5AVVi8MLHJGZv2ne0+MhJR9jRXt3Jcx+QtA
         SSguLXxO4AeRXS8W3jzCCsD6DkuLUPsXo/C69tVcyQP9UgHPhRDZv+11HFsWiOcjicDx
         QfRA==
X-Gm-Message-State: ALoCoQnLtCH07UXPb5F+yzzJD9EbVe9orB+IBDPSwTlcRqLrhiEIQtK+W0DQlOm3c9D2wr8bviry
X-Received: by 10.107.166.136 with SMTP id p130mr17625202ioe.163.1436738526001;
        Sun, 12 Jul 2015 15:02:06 -0700 (PDT)
Received: from localhost ([69.71.1.1])
        by smtp.gmail.com with ESMTPSA id b140sm11286613ioe.9.2015.07.12.15.02.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 12 Jul 2015 15:02:04 -0700 (PDT)
Subject: [PATCH 2/3] x86, irq: Clarify "No irq handler" message
To:     Thomas Gleixner <tglx@linutronix.de>
From:   Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        linux-am33-list@redhat.com, linux-ia64@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-alpha@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org
Date:   Sun, 12 Jul 2015 17:02:02 -0500
Message-ID: <20150712220202.7166.22099.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150712215559.7166.33068.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150712215559.7166.33068.stgit@bhelgaas-glaptop2.roam.corp.google.com>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48201
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
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

Previously we printed, e.g.,

  do_IRQ: 0.242 No irq handler for vector (irq -1)

There's no clue about what "0.242" means, and the IRQ number, which is the
important generic information used by drivers and /proc/interrupts, is
almost an afterthought.

Change the format to this:

  No handler for IRQ -1 (CPU 0 vector 0xf2)

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/kernel/irq.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 2949c6e..3c6b069 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -224,9 +224,8 @@ __visible unsigned int __irq_entry do_IRQ(struct pt_regs *regs)
 		ack_APIC_irq();
 
 		if (irq != IRQ_RETRIGGERED) {
-			pr_emerg_ratelimited("%s: %d.%d No irq handler for vector (irq %d)\n",
-					     __func__, smp_processor_id(),
-					     vector, irq);
+			pr_emerg_ratelimited("No handler for IRQ %d (CPU %d vector %#x)\n",
+					     irq, smp_processor_id(), vector);
 		} else {
 			__this_cpu_write(vector_irq[vector], IRQ_UNDEFINED);
 		}
