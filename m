Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Aug 2016 12:01:03 +0200 (CEST)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32939 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991977AbcHVKA4oVRLA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Aug 2016 12:00:56 +0200
Received: by mail-pf0-f195.google.com with SMTP id i6so6056471pfe.0;
        Mon, 22 Aug 2016 03:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=PteW8ubLykgS17iGSpHdzRa+V1B1+ib44tNOFEHZtpE=;
        b=KlNj3pQSgdlmtBFZKdmTwMEP3h+kXT1Ml0YCris1lYidbvJlTuCRbdJYvnBP/SnY2n
         QJjY4OU/J+1QAwDZFJh4ovwr9iukGy2v72WL+bzf+fOctizvFtqkWTb4qRt2ko665mbf
         SZ7QJGtu6eKg/JXtU2Qp92JHLGXMRvQosEI8cSLAJ3WjARFXq4GmVK3ySwaFxOM7fT33
         HMaYU11RmVlHsPxpSTxd4IS5KOosCMJrCYPOqm+qj46CdCAdWA/wxOg/2KrvtNEMqz1P
         8PB8ThlXL8/FVzh7nNxTpME6Jt3yKpiuxmePpDkUsYLpv2qdOiExfvrojpsKjptUVr9Z
         W2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=PteW8ubLykgS17iGSpHdzRa+V1B1+ib44tNOFEHZtpE=;
        b=cZTbtqxbyAPYxcQRHMFZqmAuE3pzWj6ExZYwVnbd9n/CJWtB31XInjs8ST05dbINBD
         4s676d7gRV+990G3IsY9c7Z+b4XySADifiiDzZqFaZezX6bhNy2Uz8vR8pc+lL9rr/Zr
         zeu2FwVb4DtmUi+vo96rJGLBrGtq721Tue0VGvZhZdYtWkuUrYjMkqlePjIWi6zgVAXL
         nrGvUuOJ++2qPeeB8ZYc3smnIFTM99Ty/IIcgcarsxkt3nQfOyAb6lAjN5ThkNwVP1jC
         8lOMYkG+OIJ/v5tNb04nUAqL2MVXW/wEPvgCufxuUiIxwWCy7ghdZDN9JzAd47qGZmAD
         eC/A==
X-Gm-Message-State: AEkooutoNzh61K2arNb5+uHp6Us6yrJYqd8ZPZUHtM2YY60klUOHYFXrvE/W5y8jubhLTw==
X-Received: by 10.98.192.144 with SMTP id g16mr41532938pfk.55.1471860050708;
        Mon, 22 Aug 2016 03:00:50 -0700 (PDT)
Received: from ly-pc ([114.222.149.114])
        by smtp.gmail.com with ESMTPSA id ww14sm31011125pac.34.2016.08.22.03.00.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 Aug 2016 03:00:49 -0700 (PDT)
Date:   Mon, 22 Aug 2016 18:00:28 +0800
From:   Yang Ling <gnaygnil@gmail.com>
To:     ralf@linux-mips.org, keguang.zhang@gmail.com
Cc:     james.hogan@imgtec.com, paul.burton@imgtec.com,
        david.daney@cavium.com, chenhc@lemote.com,
        markos.chandras@imgtec.com, macro@imgtec.com, f.fainelli@gmail.com,
        gnaygnil@gmail.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Use PRID_REV_LOONGSON1ABC instead of the legacy macro
Message-ID: <20160822095955.GA5527@ly-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <gnaygnil@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54721
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gnaygnil@gmail.com
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

Signed-off-by: Yang Ling <gnaygnil@gmail.com>
---
 arch/mips/include/asm/cpu.h         | 3 +--
 arch/mips/kernel/cpu-probe.c        | 8 +++++++-
 arch/mips/loongson32/common/setup.c | 6 ++++--
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 9a83724..76c0b56c3 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -239,8 +239,7 @@
 #define PRID_REV_VR4181A	0x0070	/* Same as VR4122 */
 #define PRID_REV_VR4130		0x0080
 #define PRID_REV_34K_V1_0_2	0x0022
-#define PRID_REV_LOONGSON1B	0x0020
-#define PRID_REV_LOONGSON1C	0x0020	/* Same as Loongson-1B */
+#define PRID_REV_LOONGSON1ABC	0x0020
 #define PRID_REV_LOONGSON2E	0x0002
 #define PRID_REV_LOONGSON2F	0x0003
 #define PRID_REV_LOONGSON3A_R1	0x0005
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index a88d442..0afa4be 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1495,8 +1495,14 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		c->cputype = CPU_LOONGSON1;
 
 		switch (c->processor_id & PRID_REV_MASK) {
-		case PRID_REV_LOONGSON1B:
+		case PRID_REV_LOONGSON1ABC:
+#if defined(CONFIG_CPU_LOONGSON1A)
+			__cpu_name[cpu] = "Loongson 1A";
+#elif defined(CONFIG_CPU_LOONGSON1B)
 			__cpu_name[cpu] = "Loongson 1B";
+#elif defined(CONFIG_CPU_LOONGSON1C)
+			__cpu_name[cpu] = "Loongson 1C";
+#endif
 			break;
 		}
 
diff --git a/arch/mips/loongson32/common/setup.c b/arch/mips/loongson32/common/setup.c
index 1640744..1c3324a 100644
--- a/arch/mips/loongson32/common/setup.c
+++ b/arch/mips/loongson32/common/setup.c
@@ -21,8 +21,10 @@ const char *get_system_type(void)
 	unsigned int processor_id = (&current_cpu_data)->processor_id;
 
 	switch (processor_id & PRID_REV_MASK) {
-	case PRID_REV_LOONGSON1B:
-#if defined(CONFIG_LOONGSON1_LS1B)
+	case PRID_REV_LOONGSON1ABC:
+#if defined(CONFIG_LOONGSON1_LS1A)
+		return "LOONGSON LS1A";
+#elif defined(CONFIG_LOONGSON1_LS1B)
 		return "LOONGSON LS1B";
 #elif defined(CONFIG_LOONGSON1_LS1C)
 		return "LOONGSON LS1C";
-- 
1.9.1
