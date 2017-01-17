Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2017 16:21:07 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.134]:57567 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993889AbdAQPUf3820d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Jan 2017 16:20:35 +0100
Received: from wuerfel.lan ([78.43.21.235]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LfKWX-1cnfrH1g8f-00p6Sy; Tue, 17 Jan 2017 16:19:22 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/13] MIPS: VDSO: avoid duplicate CAC_BASE definition
Date:   Tue, 17 Jan 2017 16:18:36 +0100
Message-Id: <20170117151911.4109452-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20170117151911.4109452-1-arnd@arndb.de>
References: <20170117151911.4109452-1-arnd@arndb.de>
X-Provags-ID: V03:K0:VX1v0OsZWCt148dFLOvpKocBdKHM73qSWnPzksuf19eZLzgtQ6Z
 XjCzqh6tajZ39nW9mp5mNZfI5OtCBtA6HzeUiYWWw/bk5Kvu+0wK2mvdpHFmHCFfyLnls3j
 cTQOUdilQN5c+UliRla07rmFbf8BhBXabk5YeVjWiLwileJrQSj5R/RRs2JHqcGo95AjN+Q
 LOz20mSbiB6+9CFSNN3IQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:N3pG2muPFFY=:qz9W2U45bVQm48uNE83jGo
 IwOCqUuMOb3h2XOhX64JXTbuAhsiuRNRovNkcxJn7ftl5JT6IVAunRHtUPb6Yl9RR7lcvP3Vv
 4RuBm6UoQWtfxKcB72DuJbv4OXaTJdK59jOwBpie3YjcvbkSy9Clntb3EIf9z5iWr3JPXv4Un
 LiLO57TBzoAa9W16yJuad2HGYk3R0fcOA+nOceTmz1yx90GayDCkBmCf15KVjRDXQxDJ5WUzW
 LO09kyU8cCljMdEED2ToMIEsx8LTvVcbN4gc6jAn/q0b0Q+lOzLQfF5wQ/3KC1+YO1TtqWXRg
 Og7NYvWRotvCD5qxwgc8guw0n90tSQV8pozh/8YkuvjG67csmE1Ur230UqrBiIfkb+Zr6n3Dx
 yZM5j2RNAKc/o2rgvN32gIq1JIm/FEMbysuR0nZ9sIJvxJAIXzAJULLYidq3nVlNu0GNUscpk
 SGFr3tcUAEWTWhdDdxN/LsAMTB2r+QVNH0dz8Sx8ZDyjTgd+Y9yvUEuZAnCoQMpW/Gmfbb05l
 8R7wVRddXXOwLOw0re/qU+RNZcSHY3QfLtZhTaIlewN2rZY2vLd3JGzQV7cLwVJyTDzvVfRWT
 7+5A2WgDHivXKqhOCp94bksdFQhYmIThLHos3HSzPRZTl1mYHnEgHyBVHH3yWJLYwlspIftEO
 iV9hJNJ480dOxJV8qtpOKG/XOo4unMaDy06MGfA3x6SQVEYghwbtK5PWxZMB+DqNrS8k=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56345
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

vdso.h includes <spaces.h> implicitly after defining CONFIG_32BITS.
This defeats the override in mach-ip27/spaces.h, leading to
a build error that shows up in kernelci.org:

In file included from arch/mips/include/asm/mach-ip27/spaces.h:29:0,
                 from arch/mips/include/asm/page.h:12,
                 from arch/mips/vdso/vdso.h:26,
                 from arch/mips/vdso/gettimeofday.c:11:
arch/mips/include/asm/mach-generic/spaces.h:28:0: error: "CAC_BASE" redefined [-Werror]
 #define CAC_BASE  _AC(0x80000000, UL)

An earlier patch tried to make the second definition conditional,
but that patch had the #ifdef in the wrong place, and would lead
to another warning:

arch/mips/include/asm/io.h: In function 'phys_to_virt':
arch/mips/include/asm/io.h:138:9: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]

For all I can tell, there is no other reason than vdso32 to ever
include this file with CONFIG_32BITS set, and the vdso itself should
never refer to the base addresses as it is running in user space,
so adding an #ifdef here is safe.

Link: https://patchwork.kernel.org/patch/9418187/
Fixes: 3ffc17d8768b ("MIPS: Adjust MIPS64 CAC_BASE to reflect Config.K0")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/include/asm/mach-ip27/spaces.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mach-ip27/spaces.h b/arch/mips/include/asm/mach-ip27/spaces.h
index 4775a1136a5b..24d5e31bcfa6 100644
--- a/arch/mips/include/asm/mach-ip27/spaces.h
+++ b/arch/mips/include/asm/mach-ip27/spaces.h
@@ -12,14 +12,16 @@
 
 /*
  * IP27 uses the R10000's uncached attribute feature.  Attribute 3 selects
- * uncached memory addressing.
+ * uncached memory addressing. Hide the definitions on 32-bit compilation
+ * of the compat-vdso code.
  */
-
+#ifdef CONFIG_64BIT
 #define HSPEC_BASE		0x9000000000000000
 #define IO_BASE			0x9200000000000000
 #define MSPEC_BASE		0x9400000000000000
 #define UNCAC_BASE		0x9600000000000000
 #define CAC_BASE		0xa800000000000000
+#endif
 
 #define TO_MSPEC(x)		(MSPEC_BASE | ((x) & TO_PHYS_MASK))
 #define TO_HSPEC(x)		(HSPEC_BASE | ((x) & TO_PHYS_MASK))
-- 
2.9.0
