Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 01:12:59 +0200 (CEST)
Received: from mail-ie0-f177.google.com ([209.85.223.177]:35573 "EHLO
        mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010267AbbGLXLymKhKe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2015 01:11:54 +0200
Received: by iecuq6 with SMTP id uq6so224727770iec.2
        for <linux-mips@linux-mips.org>; Sun, 12 Jul 2015 16:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:from:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=69bgGAHkFsfOd0D50aR7g1o2MTe3pnK0RLytktxWn3A=;
        b=AD8xjgUqc0o/+hGW+CVu6H4s/qSBv+RVGy9ynP+aZ+G/K4ZvNiwrkodXqnFa9gA+bC
         zNYtCEFsuUYY298JtXc2t3UEywMRAV/w03mYLEHF5tgsob4G2Ykwu0rUZgYAncAhT5/Q
         j5vTu9icBOLYWFvqoHIu+NbOOPHBSN448PMCc/uvraIgcuRTX7HfrsbrZwquPG4dVoXv
         1ZsVxb7H59s+Jrfr0xTUkD2Q8qYyIvVlKQkiKngr8UOer5tOjM+3VRc+RwAJDuZHKSyM
         EFfEHhipvHa4UyQzi5YDgptdkFo3fcuI9zlIlULuPONAGzvXu/uxv+0aR+uq1ukW+zNC
         Gc/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:from:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=69bgGAHkFsfOd0D50aR7g1o2MTe3pnK0RLytktxWn3A=;
        b=ZnjK8DgZJoDHB4GNSa8n+3oO99ciZUunx5MiUCFbgQ2E/rUaUdxexshkZq1NtOcNgi
         N0GCrpExqzFlQsD/p2pKgjld5UoK7BxcYCKsGk0lG6faMCD2fHw6DVcxy/iT6OSX42bI
         gGmqVOE6HL6/psmvV/mYoZdkvQMdeGWF+BGmPcT9DGJ2kC5NqWGVkoHguSQPWuTFklrr
         ka1oQkGVHXmnnG/eCqEQ6huYrDwpWq/DXzOmh58z31HGBbFl3TVCV5lSE6blFw0Qx2q2
         pfZubHydXVdCxlExpvUSLdJToJLYr8lgf99dJyOEKZCOn3XlOmNzpvsjLeBplvg+WSio
         34WA==
X-Gm-Message-State: ALoCoQldp/tVPy4Af/FXngz0TWvvteiHF+evlgpLSTB/kL7cCXPgB8+4YX9SCWdKaa8Qly+A2teX
X-Received: by 10.107.136.89 with SMTP id k86mr45076986iod.53.1436742709115;
        Sun, 12 Jul 2015 16:11:49 -0700 (PDT)
Received: from localhost ([69.71.1.1])
        by smtp.gmail.com with ESMTPSA id p22sm11368851ioi.32.2015.07.12.16.11.47
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 12 Jul 2015 16:11:47 -0700 (PDT)
Subject: [PATCH 7/9] MIPS: Remove "weak" from get_c0_fdc_int() declaration
To:     Ralf Baechle <ralf@linux-mips.org>
From:   Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>,
        linux-kernel@vger.kernel.org
Date:   Sun, 12 Jul 2015 18:11:46 -0500
Message-ID: <20150712231146.11177.23561.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150712230402.11177.11848.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150712230402.11177.11848.stgit@bhelgaas-glaptop2.roam.corp.google.com>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48210
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
CC: James Hogan <james.hogan@imgtec.com>
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
