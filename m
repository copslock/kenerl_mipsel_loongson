Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2017 16:22:54 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.130]:64228 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993899AbdAQPVItyf8d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Jan 2017 16:21:08 +0100
Received: from wuerfel.lan ([78.43.21.235]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPA (Nemesis) id
 0M1NdZ-1cjOm81Tgn-00tS56; Tue, 17 Jan 2017 16:20:09 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>,
        John Crispin <john@phrozen.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 06/13] MIPS: Lantiq: Fix another request_mem_region() return code check
Date:   Tue, 17 Jan 2017 16:18:40 +0100
Message-Id: <20170117151911.4109452-6-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20170117151911.4109452-1-arnd@arndb.de>
References: <20170117151911.4109452-1-arnd@arndb.de>
X-Provags-ID: V03:K0:OsHhyDoTCAGhUU7aveDp1m0aJcha8PErVgmCF0kFOHi9nEC1Pp8
 qkBRBsP+3tNQuJlnxU2lrxpj7NXBij1hGm3ZKSoOIutnQI0HQFnOqJdhNnj+fStiaANdMFx
 QjuaT+MGCGWoU/XuiPn1sMushD5E+7g5BFU2Px4UvV6Fb8+UjTishvoC2CaW2iMNQBOJ/ZS
 7+fTJ96cLomZghrrNcsAA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yCtX25rni3A=:xJqk11DANAg5SRyNHHj1wt
 UsEz9CXQmonY0Ud2CFc4kUe9SA34MCyhsrMxR7bOoYISzKcLSG2RHyEC0qhvWCmpHgqMqoZlU
 mE6CcbcLT2zAsFSNiCuNKQ7BM2JVRuOiHLYnvpviLl3ZRM0/KZzSKH/3kSX4ljtzg1Jp3kCPI
 a/oeFlkBXF7o8yhklf18jgT++9ZNkdPo9eNVyYxfdIiEi9CF1Ce25/LYxkBk66wlUgki5bDXU
 RMj1gQR1PDevvX49NuFK0S+AGEjVKKbPheA599OS2Qi0/GokZNDPqotYZt2dILJreNC0BiYiQ
 MOZcfE5QM9uC/mHzHAm5P/psq4g83f4jfJT/aiaF1urt4ckGn9SNUNcxbXXtUuqvxlDtuhq/B
 HPyTHCWGA7y4wU/DHx0gpDEoDZN51Z24AOOCPXCgs+4sD+2Bmr+imDskHK/rJ/jh70tbsllPA
 uvB8vhAaRIrHE/JeXLJRrFFShQn7vc87/zEh4JGRcZ/IGkrPe4jDQ//eEwZ25LItu390MELqM
 xSVoyrJ2EWnryD+wDYU7RQ/sJWV95ZlbzKkDPswPSoiJRVY5z5IpOJu5RqZQFBPiQkGIxjfHQ
 dTDBpfGphkGW2B9NKNcaRXyhSXNkskqdmWNvux4wlgU0PZE81MeuVnVWM3GESzG7KEj5yKNKl
 PbGm9xQZWITrcBC2hpUiZ1VP605XwM7G+Hcaqf6uokI4+qyTbiBFFCAvWIZ6jMqsCKf8=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56349
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

Hauke already fixed a couple of them, but one instance remains
that checks for a negative integer when it should check
for a NULL pointer:

arch/mips/lantiq/xway/sysctrl.c: In function 'ltq_soc_init':
arch/mips/lantiq/xway/sysctrl.c:473:19: error: ordered comparison of pointer with integer zero [-Werror=extra]

Fixes: 6e807852676a ("MIPS: Lantiq: Fix check for return value of request_mem_region()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/lantiq/xway/sysctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
index 236193b5210b..ba9f358fa21b 100644
--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -469,8 +469,8 @@ void __init ltq_soc_init(void)
 			panic("Failed to load xbar nodes from devicetree");
 		if (of_address_to_resource(np_pmu, 0, &res_xbar))
 			panic("Failed to get xbar resources");
-		if (request_mem_region(res_xbar.start, resource_size(&res_xbar),
-			res_xbar.name) < 0)
+		if (!request_mem_region(res_xbar.start, resource_size(&res_xbar),
+			res_xbar.name))
 			panic("Failed to get xbar resources");
 
 		ltq_xbar_membase = ioremap_nocache(res_xbar.start,
-- 
2.9.0
