Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jul 2015 18:47:51 +0200 (CEST)
Received: from mail-ob0-f180.google.com ([209.85.214.180]:36321 "EHLO
        mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010579AbbGNQrDjDOGn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jul 2015 18:47:03 +0200
Received: by obnw1 with SMTP id w1so9704416obn.3
        for <linux-mips@linux-mips.org>; Tue, 14 Jul 2015 09:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:from:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=W/Wlvz/r/Fxgu2zDippH2UVQzmBG1+X0NNTBx50shyE=;
        b=oXvYVG+iyjNcRoZXEEn2w9mK3+T8iA4TC4MkbunMmQ7+Ak0GcAUep0+AmxzXBy9nY9
         TJDVPp/+tQbSf9L2BIHg4tX4fBTLaceBzHEOzmdZg6xCycT1kFRNW1p4jW63pqcEnQxF
         MiHeCnLROlODjxYkBgO7IGUUpw66tE23EtcpSkPWXhNEI3fiJdn5Sua8HgQQqaSKZuJk
         HmNFR6JBp5/gWBvpX3vG+QWMOu43MCm/ESOeTF3WqvWjMmIAUSZQNs2rZ4sINowVco5J
         otcs+mDrNMB+yfWcKYbQGhJCT1zVhNlKmrW97lweBRgOIXSO0q/mohcToIhesee/MYF7
         TdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:from:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=W/Wlvz/r/Fxgu2zDippH2UVQzmBG1+X0NNTBx50shyE=;
        b=FWO5lTYcTzFd/ClRSm8LRy3DGb0yLCH3FGaSQYDtwH1pPa5KiEIJjKKotPvxrZW27V
         8ob2tHZynBweUbGQZYfEKs6U7KEwVQNf5AwvudqofSnbhy+Z69skQbvbLKxQPypFX6tm
         cBJwdPKC3h1ZO1dc6IBj7Yabwwul4w2JCVgNuC4/4TT7or6bIHjgCXY1GJhAtyCuC3PI
         +IiBQHB1RNS55SHmXcXYGe6aHapKYuiFmHs3/BaJPGGEZeE88nvI95pCcHIml+whKZDy
         QESxSJhrmJybuiNATjWCAVJfWCmpcUGk69qkpnpC0TbaE+rsFJINkn6n1cGPrvqNvFay
         Qzyw==
X-Gm-Message-State: ALoCoQkrmWaNF5erUTtEedCMAz1HIiMMwxsEZUwpoWWWtC8uFMB97w608zjnq3Wregs+FaGi9iQ8
X-Received: by 10.202.206.77 with SMTP id e74mr20308828oig.132.1436892418086;
        Tue, 14 Jul 2015 09:46:58 -0700 (PDT)
Received: from localhost ([69.71.1.1])
        by smtp.gmail.com with ESMTPSA id oy11sm751403oeb.3.2015.07.14.09.46.55
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Jul 2015 09:46:56 -0700 (PDT)
Subject: [PATCH v2 5/8] MIPS: Remove "weak" from get_c0_compare_int()
 declaration
To:     Ralf Baechle <ralf@linux-mips.org>
From:   Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 14 Jul 2015 11:46:54 -0500
Message-ID: <20150714164654.1541.46928.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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
X-archive-position: 48288
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

get_c0_compare_int() is defined in several files.  Each definition is weak,
so I assume Kconfig prevents two or more from being included.  The caller
contains default code used when get_c0_compare_int() isn't defined at all.

Add a weak get_c0_compare_int() definition with the default code and remove
the weak annotation from the declaration.

Then the platform implementations will be strong and will override the weak
default.  If multiple platforms are ever configured in, we'll get a link
error instead of calling a random platform's implementation.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
---
 arch/mips/include/asm/time.h |    2 +-
 arch/mips/kernel/cevt-r4k.c  |   11 +++++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
index ce6a7d5..44a9c3a 100644
--- a/arch/mips/include/asm/time.h
+++ b/arch/mips/include/asm/time.h
@@ -51,7 +51,7 @@ extern int get_c0_perfcount_int(void);
 /*
  * Initialize the calling CPU's compare interrupt as clockevent device
  */
-extern unsigned int __weak get_c0_compare_int(void);
+extern unsigned int get_c0_compare_int(void);
 extern int r4k_clockevent_init(void);
 
 static inline int mips_clockevent_init(void)
diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index d70c4d8..cc7cc46 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -174,6 +174,11 @@ int c0_compare_int_usable(void)
 	return 1;
 }
 
+unsigned int __weak get_c0_compare_int(void)
+{
+	return MIPS_CPU_IRQ_BASE + cp0_compare_irq;
+}
+
 int r4k_clockevent_init(void)
 {
 	unsigned int cpu = smp_processor_id();
@@ -189,11 +194,9 @@ int r4k_clockevent_init(void)
 	/*
 	 * With vectored interrupts things are getting platform specific.
 	 * get_c0_compare_int is a hook to allow a platform to return the
-	 * interrupt number of it's liking.
+	 * interrupt number of its liking.
 	 */
-	irq = MIPS_CPU_IRQ_BASE + cp0_compare_irq;
-	if (get_c0_compare_int)
-		irq = get_c0_compare_int();
+	irq = get_c0_compare_int();
 
 	cd = &per_cpu(mips_clockevent_device, cpu);
 
