Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Feb 2015 17:18:34 +0100 (CET)
Received: from mail-pd0-f173.google.com ([209.85.192.173]:43306 "EHLO
        mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006777AbbBVQSceo89q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 22 Feb 2015 17:18:32 +0100
Received: by pdev10 with SMTP id v10so19581181pde.10;
        Sun, 22 Feb 2015 08:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=oU099nSdkEaQYHdlrdRGAOUOmIpVOKbbxknE9Kg6PhY=;
        b=B271cdSVF0NVg/xPI3gvV69DFGt6kTzG6RQJnGP3kWF9eh/ve0lqI60slpEnNWbqXd
         E9MX+X8rEznyRbDOMTcIuhTM8WCTJqM2Yr9mg44HtqezdGdg5cD/lTNbXWkn/xNIFK9y
         tXO6K1BtGdP2b7CYWZ0T5sHQuOtFSbPxnDu1xgNNRcH4W0egsfphhZwxE7Er5RWJveGg
         LO7yQ0kM+Sb4R7t1KE8TYLCn6hBLRgJaPf7mO7EmzSHR0VOACoEs+EhBtrwXaSK/uaAa
         nL881AWEwE2FwqM/DdQypUF89TLx5020Hj5Q9FCGSQwj/de6rQCFRBoPtGsfHEI0msUT
         G8Bg==
X-Received: by 10.68.106.226 with SMTP id gx2mr12805295pbb.78.1424621906641;
        Sun, 22 Feb 2015 08:18:26 -0800 (PST)
Received: from localhost ([182.69.6.244])
        by mx.google.com with ESMTPSA id i9sm33024849pdk.49.2015.02.22.08.18.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 22 Feb 2015 08:18:26 -0800 (PST)
Date:   Sun, 22 Feb 2015 21:48:21 +0530
From:   Tapasweni Pathak <tapaswenipathak@gmail.com>
To:     gleb@kernel.org, pbonzini@redhat.com, ralf@linux-mips.org,
        kvm@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     julia.lawall@lip6.fr, tapaswenipathak@gmail.com
Subject: [PATCH] arch: mips: kvm: Enable after disabling interrupt
Message-ID: <20150222161821.GA6980@kt-Inspiron-3542>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <tapaswenipathak@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45886
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tapaswenipathak@gmail.com
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

Enable disabled interrupt, on unsuccessful operation.

Found by Coccinelle.

Signed-off-by: Tapasweni Pathak <tapaswenipathak@gmail.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
 arch/mips/kvm/tlb.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
index bbcd822..b6beb0e 100644
--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -216,6 +216,7 @@ int kvm_mips_host_tlb_write(struct kvm_vcpu *vcpu, unsigned long entryhi,
 	if (idx > current_cpu_data.tlbsize) {
 		kvm_err("%s: Invalid Index: %d\n", __func__, idx);
 		kvm_mips_dump_host_tlbs();
+		local_irq_restore(flags);
 		return -1;
 	}

--
1.7.9.5
