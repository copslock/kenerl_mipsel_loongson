Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 01:13:33 +0200 (CEST)
Received: from mail-ig0-f177.google.com ([209.85.213.177]:35918 "EHLO
        mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010492AbbGLXMQeprhe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2015 01:12:16 +0200
Received: by igbij6 with SMTP id ij6so9990997igb.1
        for <linux-mips@linux-mips.org>; Sun, 12 Jul 2015 16:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:from:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=g21SjBvBHo10xejElLfy5Ohhy2lZs4zu1bdUgBvGL8E=;
        b=cOqI3cc//0LTy+Nu6uhMLnNkOp3lnYkWadBzXrQL3E2KebENBDRBplZqCGKkXmqMDL
         AITDh5RqxhaUEylZX2cUUfoAimoXstNynWQQA1L30CESFZwkIGJiFfxpPYJhzzn2erMM
         6X2SzWO/sdi6XX8M7FPHR9yBpXDAmXcowA8x3WEvvCVMCoV+rTzugP5dywcBxg+ocBeN
         auFT+0t163RvJqbnN948DtT9buIg1xkJeRnseWMzHZcooQe2aWxYaTVLQ6eapHJZz1HH
         c/ot9iZvIXefq3wmi9kPyGn/zZLfaNWL5vzx1reycUDOJaWSJvRFg8rwTWvYrKxGjW9n
         BKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:from:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=g21SjBvBHo10xejElLfy5Ohhy2lZs4zu1bdUgBvGL8E=;
        b=Kn4FB5VO2cTcTRlsgdTYXA2cC/w+k5vgaE8HzPU325TQn+xucrMUPo6KgeiAujFTOc
         zV2sM68KXCaCqEG2jKZE7qZdQpCnEsHr2Sw+RB09oMUBS36Ilovtb/r4JLV+bL//TLpm
         QDvH/VQEr5iX/F6HrTFvv1EW0g+YBxZY8JFKk1NEs6WSQaXyCgAUEkllO8dEf48mTRdN
         4XEIqkmAXUhAUbHofAKBCBE61RzHdGoA7hTTSGf+W5ABWgBpBiaugjYZZF8UokU4xEu2
         bam8xRpjATJJ1c60XbpDTPRVpazzXaJIetptv7vLXPol40gKP067w1WHYgATzTfJI2/1
         bIlA==
X-Gm-Message-State: ALoCoQmma0s37/cu+7lvWy9WhQXoLKmBhgry+Q8upR1WkrL6nYf2IkFehFuT3srPAvB+BXCTLJeh
X-Received: by 10.50.136.134 with SMTP id qa6mr9663740igb.26.1436742730998;
        Sun, 12 Jul 2015 16:12:10 -0700 (PDT)
Received: from localhost ([69.71.1.1])
        by smtp.gmail.com with ESMTPSA id w75sm6958601iod.34.2015.07.12.16.12.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 12 Jul 2015 16:12:09 -0700 (PDT)
Subject: [PATCH 9/9] MIPS: Remove "__weak" definition from arch-specific
 linkage.h
To:     Ralf Baechle <ralf@linux-mips.org>
From:   Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>,
        linux-kernel@vger.kernel.org
Date:   Sun, 12 Jul 2015 18:12:03 -0500
Message-ID: <20150712231203.11177.67274.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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
X-archive-position: 48212
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

"__weak" is defined in include/linux/compiler-gcc.h.  We shouldn't need an
arch-specific definition.

Remove the "__weak" definition from arch/mips/include/asm/linkage.h.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/mips/include/asm/linkage.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/include/asm/linkage.h b/arch/mips/include/asm/linkage.h
index 2767dda..99651b0 100644
--- a/arch/mips/include/asm/linkage.h
+++ b/arch/mips/include/asm/linkage.h
@@ -5,7 +5,6 @@
 #include <asm/asm.h>
 #endif
 
-#define __weak __attribute__((weak))
 #define cond_syscall(x) asm(".weak\t" #x "\n" #x "\t=\tsys_ni_syscall")
 #define SYSCALL_ALIAS(alias, name)					\
 	asm ( #alias " = " #name "\n\t.globl " #alias)
