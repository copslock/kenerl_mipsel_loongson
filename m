Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jul 2010 17:42:08 +0200 (CEST)
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39087 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491944Ab0GLPmB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Jul 2010 17:42:01 +0200
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02F60B6D91;
        Mon, 12 Jul 2010 11:42:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
        :date:from:mime-version:to:cc:subject:references:in-reply-to
        :content-type:content-transfer-encoding; s=sasl; bh=263dQAKUE9N3
        zni3Zp0h78S7vCw=; b=XJFRTK2729JEdasHBlRykadEfHO8BlqkYwxChxOqDSQj
        H/VX4Q660wo0+aXCr8G/5f9ED0ODe7KLfHl/YSR/0AQ9ze2MBic08yv/RAHt0j2b
        br1PfCFx8fgSD/nmbnR8f3H+nQLEtXUPrJwAAUeiU4AEP2X2SNIwnfGvovlNgqU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
        :from:mime-version:to:cc:subject:references:in-reply-to
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=HfR17x
        iA3jTssbxXKwAuuM/XCa76jQCubwmxvCRDUMWuEdGgTz4s7purqp10p/hcmL5mne
        t7lxeKH+eQ+I1iUuwou51JTBEK0HowEfrMDMZ3z1Max2g6kMZGVkOhFgVrFV84Br
        Z5YCz6cCj77fXHYHKxy/aTb5GOjAeCRR5Gfyo=
Received: from b-pb-sasl-quonix. (unknown [127.0.0.1])
        by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BED2EB6D8C;
        Mon, 12 Jul 2010 11:41:57 -0400 (EDT)
Received: from [192.168.11.3] (unknown [114.162.174.29]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 84958B6D8B; Mon, 12 Jul
 2010 11:41:53 -0400 (EDT)
Message-ID: <4C3B37BF.2090606@pobox.com>
Date:   Tue, 13 Jul 2010 00:41:51 +0900
From:   Shinya Kuribayashi <skuribay@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.10)
 Gecko/20100527 Thunderbird/3.0.5
MIME-Version: 1.0
To:     David VomLehn <dvomlehn@cisco.com>, ralf@linux-mips.org,
        macro@linux-mips.org
CC:     linux-mips@linux-mips.org
Subject: [PATCH 2/2] MIPS: Enable cpu_has_clo_clz for MIPS Technologies'
 platforms
References: <4C3B36B3.6010800@pobox.com>
In-Reply-To: <4C3B36B3.6010800@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Pobox-Relay-ID: 0135DF2C-8DCC-11DF-B991-DA91016DD5F0-47602734!b-pb-sasl-quonix.pobox.com
Return-Path: <skuribay@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27376
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: skuribay@pobox.com
Precedence: bulk
X-list: linux-mips

Enable cpu_has_clo_clz only when CONFIG_CPU_MIPS32 or CONFIG_CPU_MIPS64
is selected.  This will optimize fls() and __fls() to use CLZ insn, and
eventually ffs() and __ffs() as well.

Malta and MIPSSim are development platforms, and need to take care of
various processor configurations, release rivisions and so on, even
across different MIPS ISAs.  For such platforms we have to be careful,
for instance, with turning on cpu_has_mips{32,64}r[12] features.

As for CLZ, all MIPS32/64 processors support it, regardless of release
revisions.

Signed-off-by: Shinya Kuribayashi <skuribay@pobox.com>
---
 .../include/asm/mach-malta/cpu-feature-overrides.h |    2 ++
 .../asm/mach-mipssim/cpu-feature-overrides.h       |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-malta/cpu-feature-overrides.h b/arch/mips/include/asm/mach-malta/cpu-feature-overrides.h
index 2848cea..37e3583 100644
--- a/arch/mips/include/asm/mach-malta/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-malta/cpu-feature-overrides.h
@@ -32,6 +32,7 @@
 /* #define cpu_has_vtag_icache	? */
 /* #define cpu_has_dc_aliases	? */
 /* #define cpu_has_ic_fills_f_dc ? */
+#define cpu_has_clo_clz		1
 #define cpu_has_nofpuex		0
 /* #define cpu_has_64bits	? */
 /* #define cpu_has_64bit_zero_reg ? */
@@ -58,6 +59,7 @@
 /* #define cpu_has_vtag_icache	? */
 /* #define cpu_has_dc_aliases	? */
 /* #define cpu_has_ic_fills_f_dc ? */
+#define cpu_has_clo_clz		1
 #define cpu_has_nofpuex		0
 /* #define cpu_has_64bits	? */
 /* #define cpu_has_64bit_zero_reg ? */
diff --git a/arch/mips/include/asm/mach-mipssim/cpu-feature-overrides.h b/arch/mips/include/asm/mach-mipssim/cpu-feature-overrides.h
index 779b022..27aaaa5 100644
--- a/arch/mips/include/asm/mach-mipssim/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-mipssim/cpu-feature-overrides.h
@@ -31,6 +31,7 @@
 /* #define cpu_has_vtag_icache	? */
 /* #define cpu_has_dc_aliases	? */
 /* #define cpu_has_ic_fills_f_dc ? */
+#define cpu_has_clo_clz		1
 #define cpu_has_nofpuex		0
 /* #define cpu_has_64bits	? */
 /* #define cpu_has_64bit_zero_reg ? */
@@ -56,6 +57,7 @@
 /* #define cpu_has_vtag_icache	? */
 /* #define cpu_has_dc_aliases	? */
 /* #define cpu_has_ic_fills_f_dc ? */
+#define cpu_has_clo_clz		1
 #define cpu_has_nofpuex		0
 /* #define cpu_has_64bits	? */
 /* #define cpu_has_64bit_zero_reg ? */
-- 
1.7.1.1
