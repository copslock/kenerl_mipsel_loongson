Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 01:12:43 +0200 (CEST)
Received: from mail-ie0-f171.google.com ([209.85.223.171]:34403 "EHLO
        mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010515AbbGLXLqcY0Ge (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2015 01:11:46 +0200
Received: by iebmu5 with SMTP id mu5so224029456ieb.1
        for <linux-mips@linux-mips.org>; Sun, 12 Jul 2015 16:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:from:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=3WIK4MrvhDTKSYMbwzkV6aH/v6powDnyZHFeaX6LvmU=;
        b=A6ZECOPG6fyvJqUFBOgFyflBXZ+ykCjbP7oD4S047KsvgEUilO2aDlsjsPwBs6SX7z
         7IeaeYfM1gyba0VfWe0D1n0LrJKd0DM71Iz2eqPQpOWv+IZGt/e6tzxCX6h4qMlM/e0L
         Fhmt3p1Rn/GK9Xw0g9Pn5Q6bnk234bvbty5T3XMIbEV2UmBzUMGnOt75m7QNpxnWxPm4
         dVzb3m3dq53D2/TkEisS2MgLg1YgHGTfVNg0CZGX/3cQ4AGtQLd9+68ZFr99r9UgLcfc
         URK1GgRG+JfIAchlR/qfcK4Yuj0tKybhQjNNc1I6W1TDN7tLEGcCdzkvIG7Zvm4WazHE
         vNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:from:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=3WIK4MrvhDTKSYMbwzkV6aH/v6powDnyZHFeaX6LvmU=;
        b=S1XrEaUGCgip3cdMP8WceoCA6UvmvV7ycWpiI9E+lALL/unRaW0iEitTvfFNdhViMF
         n41wqKcLGVvWo64H2es7g/3qdBHrrwf+kdrG/86QYXqA/EzFyAvVYau5LCDNYcz+NCSS
         WqiQ1Byxr5p0KPHDwYmHLEYCufmym8cPWuZEM/S3DOLDcXQ9c0HSH2de2G4kT35axxgY
         W3WFpe/5Y923c4c1ED2TmeP9jnZHTuWWakQXRlR1Ci0gtdpkKINIo6i+lmtViUKf44CR
         cVLZQ9Qg+YpytjJc6qOvibmnyfMdoPRutu5S1vOvdKssSWTMlgLUpFCYi8OukG/qHrqs
         U5IA==
X-Gm-Message-State: ALoCoQm+E2wkEHk7H5Yd7SAz4COy1VmJbQBxo69NFmqNCpzpp+S+BoRezVaB9+xaDJu1iufj5ZTu
X-Received: by 10.107.135.37 with SMTP id j37mr15303250iod.154.1436742700913;
        Sun, 12 Jul 2015 16:11:40 -0700 (PDT)
Received: from localhost ([69.71.1.1])
        by smtp.gmail.com with ESMTPSA id h7sm4499691igt.3.2015.07.12.16.11.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 12 Jul 2015 16:11:39 -0700 (PDT)
Subject: [PATCH 6/9] MIPS: Remove "weak" from get_c0_compare_int()
 declaration
To:     Ralf Baechle <ralf@linux-mips.org>
From:   Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>,
        linux-kernel@vger.kernel.org
Date:   Sun, 12 Jul 2015 18:11:38 -0500
Message-ID: <20150712231137.11177.3681.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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
X-archive-position: 48209
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
 
