Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jul 2010 17:41:29 +0200 (CEST)
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37891 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1492372Ab0GLPlX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Jul 2010 17:41:23 +0200
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4384B6D81;
        Mon, 12 Jul 2010 11:41:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
        :date:from:mime-version:to:cc:subject:references:in-reply-to
        :content-type:content-transfer-encoding; s=sasl; bh=GnigqYJcAhFL
        ytUIq2jd+/v0aps=; b=MQJDmgxvpVN0wpX7YxDpLRWCu763SziWZ/ehf6H83hUJ
        tVIjkejfLOq8udqv+M3ypkpkTTJ3MdLFAXe0SKYQn7qUdSZ8TooyxzTSamA3JUSY
        9K7hyIWgQyXyxVAdGNy5YMYWjoP2TGig4z1c9n5ZmfaE4xk1N3bnLv1jpKl7eOU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
        :from:mime-version:to:cc:subject:references:in-reply-to
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=aS6SZe
        YN2HZBlaYHvZZq1qoRwTB/Z6/lQVUAonUAsJWhd41HmuzegYulIi2lWd4KPiqdyF
        gDWPzejLYjB8lhFVTmqP5GtWGPp0AIF7zc2nSf3HejfuSs57NgVjehPWsdgS/SyV
        NXFSSY70eimzynmIaYjteUx1kYdt9oX+BXVeI=
Received: from b-pb-sasl-quonix. (unknown [127.0.0.1])
        by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 940EDB6D80;
        Mon, 12 Jul 2010 11:41:19 -0400 (EDT)
Received: from [192.168.11.3] (unknown [114.162.174.29]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 24690B6D7F; Mon, 12 Jul
 2010 11:41:14 -0400 (EDT)
Message-ID: <4C3B3798.9010908@pobox.com>
Date:   Tue, 13 Jul 2010 00:41:12 +0900
From:   Shinya Kuribayashi <skuribay@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.10)
 Gecko/20100527 Thunderbird/3.0.5
MIME-Version: 1.0
To:     David VomLehn <dvomlehn@cisco.com>, ralf@linux-mips.org,
        macro@linux-mips.org
CC:     linux-mips@linux-mips.org
Subject: [PATCH 1/2] MIPS: PowerTV: Provide cpu-feature-overrides.h
References: <4C3B36B3.6010800@pobox.com>
In-Reply-To: <4C3B36B3.6010800@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Pobox-Relay-ID: EA74BC5E-8DCB-11DF-B04B-DA91016DD5F0-47602734!b-pb-sasl-quonix.pobox.com
Return-Path: <skuribay@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27375
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: skuribay@pobox.com
Precedence: bulk
X-list: linux-mips

From: David VomLehn <dvomlehn@cisco.com>

This will optimize fls() and __fls() to use CLZ throughout the kernel,
and any other optimizations that depend on constant cpu_has_* values
will also be used.

Signed-off-by: David VomLehn <dvomlehn@cisco.com>
Signed-off-by: Shinya Kuribayashi <skuribay@pobox.com>
---
 .../asm/mach-powertv/cpu-feature-overrides.h       |   59 ++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-powertv/cpu-feature-overrides.h

diff --git a/arch/mips/include/asm/mach-powertv/cpu-feature-overrides.h b/arch/mips/include/asm/mach-powertv/cpu-feature-overrides.h
new file mode 100644
index 0000000..f751e3e
--- /dev/null
+++ b/arch/mips/include/asm/mach-powertv/cpu-feature-overrides.h
@@ -0,0 +1,59 @@
+/*
+ * Copyright (C) 2010  Cisco Systems, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef _ASM_MACH_POWERTV_CPU_FEATURE_OVERRIDES_H_
+#define _ASM_MACH_POWERTV_CPU_FEATURE_OVERRIDES_H_
+#define cpu_has_tlb			1
+#define cpu_has_4kex			1
+#define cpu_has_3k_cache		0
+#define cpu_has_4k_cache		1
+#define cpu_has_tx39_cache		0
+#define cpu_has_fpu			0
+#define cpu_has_counter			1
+#define cpu_has_watch			1
+#define cpu_has_divec			1
+#define cpu_has_vce			0
+#define cpu_has_cache_cdex_p		0
+#define cpu_has_cache_cdex_s		0
+#define cpu_has_mcheck			1
+#define cpu_has_ejtag			1
+#define cpu_has_llsc			1
+#define cpu_has_mips16			0
+#define cpu_has_mdmx			0
+#define cpu_has_mips3d			0
+#define cpu_has_smartmips		0
+#define cpu_has_vtag_icache		0
+#define cpu_has_dc_aliases		0
+#define cpu_has_ic_fills_f_dc		0
+#define cpu_has_mips32r1		0
+#define cpu_has_mips32r2		1
+#define cpu_has_mips64r1		0
+#define cpu_has_mips64r2		0
+#define cpu_has_dsp			0
+#define cpu_has_mipsmt			0
+#define cpu_has_userlocal		0
+#define cpu_has_nofpuex			0
+#define cpu_has_64bits			0
+#define cpu_has_64bit_zero_reg		0
+#define cpu_has_vint			1
+#define cpu_has_veic			1
+#define cpu_has_inclusive_pcaches	0
+
+#define cpu_dcache_line_size()		32
+#define cpu_icache_line_size()		32
+#endif
-- 
1.7.1.1
