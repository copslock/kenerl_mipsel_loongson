Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 May 2016 06:22:39 +0200 (CEST)
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34428 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27030560AbcESEWh2D8rz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 May 2016 06:22:37 +0200
Received: by mail-pa0-f68.google.com with SMTP id yl2so6651663pac.1;
        Wed, 18 May 2016 21:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=kw6sdjZ2/RRCf2D6Uzie/AY46J0bLpz+YqDjO6KW4dE=;
        b=0vIHNaU/S3u7wnI+Jem/rZSd3vXy/RF0VOpCdpO2SyB4V7JsAn4by8fVSj1FIKY/1v
         Dfk7Y7wjQw9yCOo15d8W+sZdoKmdEtXIj1XlNo7DpxdV+CRe/lubvpJGa/QwLcwVPCLP
         reRTd77wYZB5AMt1LXYprh9U2MNu3FbPsf+AbE6umwDj00v5wvEFeLSrGR+xmNgbE7FA
         T+PZ38MVhN2FX+KdOtahgDJYBTM/6XjFNst+lETKfQ5rrl+qNlZLea7166XaFZMDkrFz
         MYgsp1CSxJmm1YE+XD9w6oWuRKe19JphmjGTz1BimQeJkq/moFtTJuN89dOdz2XcCMXu
         GmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=kw6sdjZ2/RRCf2D6Uzie/AY46J0bLpz+YqDjO6KW4dE=;
        b=ELq/A1+qjlKA5Zqu6uEANCG9IpANV5CgPFyFuQS+vwbI8odod2sLQU1wuP0Z50ls6a
         yIJBbu+XztGaeJ20QKHw+cCyfRSQi9kwufS2SDeHN2iKrlW0Y7NT62XuoXfd5xLCcaG3
         RorS/Dr0I98CZXwdKkfwTV3NcEEs3Iz1I42gUISGoCQuN4Y+JHfCMLLdaiDzEJq0cW3N
         JagFewgkw0xhosWStzkWFkXQI5EZP8w3XqjtVGGLoAY9jW9IU1tRY8CAB1zgOmNZdz0e
         +vpPja4MsardqV30QCcyzFcyDRtF7mwe1p+r3d0TBOFpO8/rNyKkBeZSBv4KYdYUFvec
         Gr3g==
X-Gm-Message-State: AOPr4FUYtWLwZUtOxijI1KSzCkrk5+VbKeLvQqhqG80U2E3lUmp/PvBBlVW80ZdI2ccrsQ==
X-Received: by 10.66.221.167 with SMTP id qf7mr16319515pac.94.1463631750676;
        Wed, 18 May 2016 21:22:30 -0700 (PDT)
Received: from ly-pc (li734-185.members.linode.com. [106.185.31.185])
        by smtp.gmail.com with ESMTPSA id p187sm15748841pfb.3.2016.05.18.21.22.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 18 May 2016 21:22:29 -0700 (PDT)
Date:   Thu, 19 May 2016 12:22:19 +0800
From:   Yang Ling <gnaygnil@gmail.com>
To:     ralf@linux-mips.org
Cc:     paul.burton@imgtec.com, markos.chandras@imgtec.com,
        james.hogan@imgtec.com, kumba@gentoo.org, macro@imgtec.com,
        david.daney@cavium.com, gnaygnil@gmail.com,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH V1 2/4] MIPS: Add CPU support for Loongson1C
Message-ID: <20160519042212.GA5236@ly-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <gnaygnil@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53540
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

Loongson1C is a 32-bit SoC designed by Loongson Technology Co., Ltd,
with many features similar to Loongson1B.

Signed-off-by: Yang Ling <gnaygnil@gmail.com>
---
 arch/mips/include/asm/cpu-type.h | 3 ++-
 arch/mips/include/asm/cpu.h      | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/cpu-type.h b/arch/mips/include/asm/cpu-type.h
index fbe1881..bdd6dc1 100644
--- a/arch/mips/include/asm/cpu-type.h
+++ b/arch/mips/include/asm/cpu-type.h
@@ -24,7 +24,8 @@ static inline int __pure __get_cpu_type(const int cpu_type)
 	case CPU_LOONGSON3:
 #endif
 
-#ifdef CONFIG_SYS_HAS_CPU_LOONGSON1B
+#if defined(CONFIG_SYS_HAS_CPU_LOONGSON1B) || \
+    defined(CONFIG_SYS_HAS_CPU_LOONGSON1C)
 	case CPU_LOONGSON1:
 #endif
 
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index a7a9185..f70517d 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -239,6 +239,7 @@
 #define PRID_REV_VR4130		0x0080
 #define PRID_REV_34K_V1_0_2	0x0022
 #define PRID_REV_LOONGSON1B	0x0020
+#define PRID_REV_LOONGSON1C	0x0020	/* Same as Loongson-1B */
 #define PRID_REV_LOONGSON2E	0x0002
 #define PRID_REV_LOONGSON2F	0x0003
 #define PRID_REV_LOONGSON3A	0x0005
-- 
1.9.1
