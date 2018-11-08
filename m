Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2018 15:47:26 +0100 (CET)
Received: from mail-pf1-x443.google.com ([IPv6:2607:f8b0:4864:20::443]:39537
        "EHLO mail-pf1-x443.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992969AbeKHOrIW3Uhv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Nov 2018 15:47:08 +0100
Received: by mail-pf1-x443.google.com with SMTP id n11-v6so9398786pfb.6;
        Thu, 08 Nov 2018 06:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LcouHPlA21WmVqJldeSHxclMup9IM+x2oKuWevoKsOg=;
        b=JkmqcX8KZyNmO2n/uztZnRJdiSbewzm6GMv+1vFxX95JSFDLt6x5HLz2EN/e9Jpfmu
         iZCMGCe2weJQ8H4YFeusZ8Do9hmfAC+UeDCoic0wET0nGXs8cJlME4+p99owc0G1aqDD
         1P2sgBBSp7WHPXj5mpHc+lGT1W85JqqIdDwduXIFiWhvXc6Ep3aJd5wlUkc0XtDhY74Z
         0FJxfXdKSCYLU1Yuzj2Xx5IdQs5XMqd4yUXztSijafQQyyelKZbPiq+NBNv8N9yKp2F9
         2DN+4Y5h/H3PLmrEzP1dh2/JCSomFThLksiKIUDaU87jTX0fcrlJ4lQ+uy/R2SY11J+J
         Iy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LcouHPlA21WmVqJldeSHxclMup9IM+x2oKuWevoKsOg=;
        b=tU0O3plCP6Qd9Bei6fvpWUsnTLP+jOXHDCiy7g+ow7j4iJP6s8z5VRYOfRtUNjzX9V
         vkmLjucH5BRDVYYNij9ArVcG3tLPwYLPrIFCC+I2qfwLXr7oclSzxUHJO9d2s8hNtTzC
         cbO1wNFeZiAVBlDB2mgBNje1ZalZ+02y9FC6nwA8vuv5pUqvOZojuKfKsIXPt1dD94pO
         A8f3bCWE/IXSMb9pFPSYSvE7mjT00/TmEhgV01cJhAnTYQ1Xcf2Z4f+M+omDrDzHg5Mw
         o7Jq0MwhmuPJNXwrTqkNVKLOAojGReaOfB+TKfOj2jgfLWbM+n58OWgzUIJ91J/FATup
         prgw==
X-Gm-Message-State: AGRZ1gIVtkxVYWAoVsCJIlNTBDKVJ+P8T0z4aYnWtw52VYG+49r3cGg1
        kV869H/L9bNllxFLHt7Nrec=
X-Google-Smtp-Source: AJdET5fbrIVBuJI6Qp4ZjmIMOIFNQb21T3aRd5oUOxuTC+6IplUmqnGeqIy8/K/AJagGlPJnaalnxg==
X-Received: by 2002:a63:4926:: with SMTP id w38mr3857439pga.353.1541688427616;
        Thu, 08 Nov 2018 06:47:07 -0800 (PST)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:18:d9bf:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id k75-v6sm11526731pfb.119.2018.11.08.06.46.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 06:47:07 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, christoffer.dall@arm.com,
        marc.zyngier@arm.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, jhogan@kernel.org,
        ralf@linux-mips.org, paul.burton@mips.com, paulus@ozlabs.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devel@linuxdriverproject.org, kvm@vger.kernel.org,
        michael.h.kelley@microsoft.com, vkuznets@redhat.com
Subject: [Resend PATCH V5 3/10] x86/Hyper-v: Add trace in the hyperv_nested_flush_guest_mapping_range()
Date:   Thu,  8 Nov 2018 22:46:32 +0800
Message-Id: <20181108144639.11206-3-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181108144639.11206-1-Tianyu.Lan@microsoft.com>
References: <20181108144639.11206-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Return-Path: <lantianyu1986@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67163
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lantianyu1986@gmail.com
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

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to trace log in the hyperv_nested_flush_
guest_mapping_range().

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/hyperv/nested.c            |  1 +
 arch/x86/include/asm/trace/hyperv.h | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/x86/hyperv/nested.c b/arch/x86/hyperv/nested.c
index 3d0f31e46954..dd0a843f766d 100644
--- a/arch/x86/hyperv/nested.c
+++ b/arch/x86/hyperv/nested.c
@@ -130,6 +130,7 @@ int hyperv_flush_guest_mapping_range(u64 as,
 	else
 		ret = status;
 fault:
+	trace_hyperv_nested_flush_guest_mapping_range(as, ret);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(hyperv_flush_guest_mapping_range);
diff --git a/arch/x86/include/asm/trace/hyperv.h b/arch/x86/include/asm/trace/hyperv.h
index 2e6245a023ef..ace464f09681 100644
--- a/arch/x86/include/asm/trace/hyperv.h
+++ b/arch/x86/include/asm/trace/hyperv.h
@@ -42,6 +42,20 @@ TRACE_EVENT(hyperv_nested_flush_guest_mapping,
 	    TP_printk("address space %llx ret %d", __entry->as, __entry->ret)
 	);
 
+TRACE_EVENT(hyperv_nested_flush_guest_mapping_range,
+	    TP_PROTO(u64 as, int ret),
+	    TP_ARGS(as, ret),
+
+	    TP_STRUCT__entry(
+		    __field(u64, as)
+		    __field(int, ret)
+		    ),
+	    TP_fast_assign(__entry->as = as;
+			   __entry->ret = ret;
+		    ),
+	    TP_printk("address space %llx ret %d", __entry->as, __entry->ret)
+	);
+
 TRACE_EVENT(hyperv_send_ipi_mask,
 	    TP_PROTO(const struct cpumask *cpus,
 		     int vector),
-- 
2.14.4
