Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jul 2015 18:48:10 +0200 (CEST)
Received: from mail-ob0-f172.google.com ([209.85.214.172]:36425 "EHLO
        mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010534AbbGNQrMQhFFn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jul 2015 18:47:12 +0200
Received: by obnw1 with SMTP id w1so9707163obn.3
        for <linux-mips@linux-mips.org>; Tue, 14 Jul 2015 09:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:from:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=BykjtjUkTP7CcfddIHshNGWhDqC137deStXN1YosAUc=;
        b=jc4gZ+x/lUIsiBm24IIMmRZ5AZo7kA8en/I+rdoP9CBj9ClO6WC29my8ChGLKiZsKr
         R6I/dpj+V0WOVTKEUmyv0lU08VcgBWYFlLkmhJTaB/u+dOJ6eainexMxGRu+yVKugOmR
         sV/tKD+bnZTDRPJmgNIq/4Pu5yLDzBkAUTGcOtReEm1UNv8+FHfS+M2AG/xLJEZvO6lO
         KE5Qn62wvXzwlukXjV7fXSFhT0A7gvAI39jP/DCgf/rInFdctH3XX7sDOoNMFcni9XNN
         Ed+f+HlhrIzOkejMvYgpOTXbhJ3WBGuhPZUryI06Ucf0XcgPYvktn9ui6vKNWRy8vexM
         g8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:from:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=BykjtjUkTP7CcfddIHshNGWhDqC137deStXN1YosAUc=;
        b=eyJ0vOSFlzlhEEjOOM35aRHspX+6Ubo3oacFebcPg4HfLEJcPvDEv2TSzBRMg/qk+6
         vyBvOty+FUqyYb/xarumTP8uacyegqJe0NwDpv1QgTM7uFP8GFjuTVNfrNrBm6wkcK1d
         j3dYctvQeTHfZzmshFkI/uwCRteEYGTKHhIDRKKsBJMoyvVnLaUZXBnJx3U1zKOARjvh
         U0xGRLnXOiA35e5sO9qyU/eSW++4bMxH8CldsT58CsHxsWUONXvKLhGi3YLqk68pPukV
         AYBZeOJEBBVoQ7osYikAVwCVsF9LPqxbk0t6e+fZIWgTWJVEf3Z4vrYYFN16VGgpIqRb
         uBOw==
X-Gm-Message-State: ALoCoQm9MxWD30Wt3DFDPYKp/+vGxkl0Jy1KcefBFW6ajZLxHJXD1vtnretvAL71cqrth4Ygk8fP
X-Received: by 10.182.153.228 with SMTP id vj4mr21050221obb.83.1436892426725;
        Tue, 14 Jul 2015 09:47:06 -0700 (PDT)
Received: from localhost ([69.71.1.1])
        by smtp.gmail.com with ESMTPSA id sm8sm758127obb.13.2015.07.14.09.47.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Jul 2015 09:47:05 -0700 (PDT)
Subject: [PATCH v2 6/8] MIPS: Remove "weak" from get_c0_fdc_int() declaration
To:     Ralf Baechle <ralf@linux-mips.org>
From:   Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 14 Jul 2015 11:47:03 -0500
Message-ID: <20150714164703.1541.65197.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150714164142.1541.92710.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150714164142.1541.92710.stgit@bhelgaas-glaptop2.roam.corp.google.com>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48289
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

Weak header file declarations are error-prone because they make every
definition weak, and the linker chooses one based on link order (see
10629d711ed7 ("PCI: Remove __weak annotation from pcibios_get_phb_of_node
decl")).

get_c0_fdc_int() is defined only in arch/mips/mti-malta/malta-time.c so
there's no problem with multiple definitions.  But it works better to have
a weak default implementation and allow a strong function to override it.
Then we don't have to test whether a definition is present, and if there
are ever multiple strong definitions, we get a link error instead of
calling a random definition.

Add a weak get_c0_fdc_int() definition with the default code and remove the
weak annotation from the declaration.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
---
 arch/mips/include/asm/irq.h  |    2 +-
 drivers/tty/mips_ejtag_fdc.c |    9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/irq.h b/arch/mips/include/asm/irq.h
index f0db99f8..15e0fec 100644
--- a/arch/mips/include/asm/irq.h
+++ b/arch/mips/include/asm/irq.h
@@ -49,7 +49,7 @@ extern int cp0_compare_irq_shift;
 extern int cp0_perfcount_irq;
 extern int cp0_fdc_irq;
 
-extern int __weak get_c0_fdc_int(void);
+extern int get_c0_fdc_int(void);
 
 void arch_trigger_all_cpu_backtrace(bool);
 #define arch_trigger_all_cpu_backtrace arch_trigger_all_cpu_backtrace
diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c
index 358323c..a8c8cfd 100644
--- a/drivers/tty/mips_ejtag_fdc.c
+++ b/drivers/tty/mips_ejtag_fdc.c
@@ -879,6 +879,11 @@ static const struct tty_operations mips_ejtag_fdc_tty_ops = {
 	.chars_in_buffer	= mips_ejtag_fdc_tty_chars_in_buffer,
 };
 
+int __weak get_c0_fdc_int(void)
+{
+	return -1;
+}
+
 static int mips_ejtag_fdc_tty_probe(struct mips_cdmm_device *dev)
 {
 	int ret, nport;
@@ -967,9 +972,7 @@ static int mips_ejtag_fdc_tty_probe(struct mips_cdmm_device *dev)
 	wake_up_process(priv->thread);
 
 	/* Look for an FDC IRQ */
-	priv->irq = -1;
-	if (get_c0_fdc_int)
-		priv->irq = get_c0_fdc_int();
+	priv->irq = get_c0_fdc_int();
 
 	/* Try requesting the IRQ */
 	if (priv->irq >= 0) {
