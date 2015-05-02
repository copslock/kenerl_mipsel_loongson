Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 May 2015 21:13:47 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:43957 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012350AbbEBTNngFl08 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 2 May 2015 21:13:43 +0200
Received: from localhost (unknown [87.213.45.130])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 61FEB9F2;
        Sat,  2 May 2015 19:13:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.0 040/220] MIPS: unaligned: Surround load/store macros in do {} while statements
Date:   Sat,  2 May 2015 20:59:15 +0200
Message-Id: <20150502185856.111992670@linuxfoundation.org>
X-Mailer: git-send-email 2.3.7
In-Reply-To: <20150502185854.333748961@linuxfoundation.org>
References: <20150502185854.333748961@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47208
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Markos Chandras <markos.chandras@imgtec.com>

commit 3563c32d6532ece53c9dd8905a8e41983ef9952f upstream.

It's best to surround such complex macros with do {} while statements
so they can appear as independent logical blocks when used within other
control blocks.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9502/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/unaligned.c |  116 +++++++++++++++++++++++++++++++++----------
 1 file changed, 90 insertions(+), 26 deletions(-)

--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -110,6 +110,7 @@ extern void show_registers(struct pt_reg
 
 #ifdef __BIG_ENDIAN
 #define     _LoadHW(addr, value, res, type)  \
+do {                                                        \
 		__asm__ __volatile__ (".set\tnoat\n"        \
 			"1:\t"type##_lb("%0", "0(%2)")"\n"  \
 			"2:\t"type##_lbu("$1", "1(%2)")"\n\t"\
@@ -127,10 +128,12 @@ extern void show_registers(struct pt_reg
 			STR(PTR)"\t2b, 4b\n\t"              \
 			".previous"                         \
 			: "=&r" (value), "=r" (res)         \
-			: "r" (addr), "i" (-EFAULT));
+			: "r" (addr), "i" (-EFAULT));       \
+} while(0)
 
 #ifndef CONFIG_CPU_MIPSR6
 #define     _LoadW(addr, value, res, type)   \
+do {                                                        \
 		__asm__ __volatile__ (                      \
 			"1:\t"type##_lwl("%0", "(%2)")"\n"   \
 			"2:\t"type##_lwr("%0", "3(%2)")"\n\t"\
@@ -146,10 +149,13 @@ extern void show_registers(struct pt_reg
 			STR(PTR)"\t2b, 4b\n\t"              \
 			".previous"                         \
 			: "=&r" (value), "=r" (res)         \
-			: "r" (addr), "i" (-EFAULT));
+			: "r" (addr), "i" (-EFAULT));       \
+} while(0)
+
 #else
 /* MIPSR6 has no lwl instruction */
 #define     _LoadW(addr, value, res, type) \
+do {                                                        \
 		__asm__ __volatile__ (			    \
 			".set\tpush\n"			    \
 			".set\tnoat\n\t"		    \
@@ -178,10 +184,13 @@ extern void show_registers(struct pt_reg
 			STR(PTR)"\t4b, 11b\n\t"		    \
 			".previous"			    \
 			: "=&r" (value), "=r" (res)	    \
-			: "r" (addr), "i" (-EFAULT));
+			: "r" (addr), "i" (-EFAULT));       \
+} while(0)
+
 #endif /* CONFIG_CPU_MIPSR6 */
 
 #define     _LoadHWU(addr, value, res, type) \
+do {                                                        \
 		__asm__ __volatile__ (                      \
 			".set\tnoat\n"                      \
 			"1:\t"type##_lbu("%0", "0(%2)")"\n" \
@@ -201,10 +210,12 @@ extern void show_registers(struct pt_reg
 			STR(PTR)"\t2b, 4b\n\t"              \
 			".previous"                         \
 			: "=&r" (value), "=r" (res)         \
-			: "r" (addr), "i" (-EFAULT));
+			: "r" (addr), "i" (-EFAULT));       \
+} while(0)
 
 #ifndef CONFIG_CPU_MIPSR6
 #define     _LoadWU(addr, value, res, type)  \
+do {                                                        \
 		__asm__ __volatile__ (                      \
 			"1:\t"type##_lwl("%0", "(%2)")"\n"  \
 			"2:\t"type##_lwr("%0", "3(%2)")"\n\t"\
@@ -222,9 +233,11 @@ extern void show_registers(struct pt_reg
 			STR(PTR)"\t2b, 4b\n\t"              \
 			".previous"                         \
 			: "=&r" (value), "=r" (res)         \
-			: "r" (addr), "i" (-EFAULT));
+			: "r" (addr), "i" (-EFAULT));       \
+} while(0)
 
 #define     _LoadDW(addr, value, res)  \
+do {                                                        \
 		__asm__ __volatile__ (                      \
 			"1:\tldl\t%0, (%2)\n"               \
 			"2:\tldr\t%0, 7(%2)\n\t"            \
@@ -240,10 +253,13 @@ extern void show_registers(struct pt_reg
 			STR(PTR)"\t2b, 4b\n\t"              \
 			".previous"                         \
 			: "=&r" (value), "=r" (res)         \
-			: "r" (addr), "i" (-EFAULT));
+			: "r" (addr), "i" (-EFAULT));       \
+} while(0)
+
 #else
 /* MIPSR6 has not lwl and ldl instructions */
 #define	    _LoadWU(addr, value, res, type) \
+do {                                                        \
 		__asm__ __volatile__ (			    \
 			".set\tpush\n\t"		    \
 			".set\tnoat\n\t"		    \
@@ -272,9 +288,11 @@ extern void show_registers(struct pt_reg
 			STR(PTR)"\t4b, 11b\n\t"		    \
 			".previous"			    \
 			: "=&r" (value), "=r" (res)	    \
-			: "r" (addr), "i" (-EFAULT));
+			: "r" (addr), "i" (-EFAULT));       \
+} while(0)
 
 #define     _LoadDW(addr, value, res)  \
+do {                                                        \
 		__asm__ __volatile__ (			    \
 			".set\tpush\n\t"		    \
 			".set\tnoat\n\t"		    \
@@ -319,11 +337,14 @@ extern void show_registers(struct pt_reg
 			STR(PTR)"\t8b, 11b\n\t"		    \
 			".previous"			    \
 			: "=&r" (value), "=r" (res)	    \
-			: "r" (addr), "i" (-EFAULT));
+			: "r" (addr), "i" (-EFAULT));       \
+} while(0)
+
 #endif /* CONFIG_CPU_MIPSR6 */
 
 
 #define     _StoreHW(addr, value, res, type) \
+do {                                                        \
 		__asm__ __volatile__ (                      \
 			".set\tnoat\n"                      \
 			"1:\t"type##_sb("%1", "1(%2)")"\n"  \
@@ -342,10 +363,12 @@ extern void show_registers(struct pt_reg
 			STR(PTR)"\t2b, 4b\n\t"              \
 			".previous"                         \
 			: "=r" (res)                        \
-			: "r" (value), "r" (addr), "i" (-EFAULT));
+			: "r" (value), "r" (addr), "i" (-EFAULT));\
+} while(0)
 
 #ifndef CONFIG_CPU_MIPSR6
 #define     _StoreW(addr, value, res, type)  \
+do {                                                        \
 		__asm__ __volatile__ (                      \
 			"1:\t"type##_swl("%1", "(%2)")"\n"  \
 			"2:\t"type##_swr("%1", "3(%2)")"\n\t"\
@@ -361,9 +384,11 @@ extern void show_registers(struct pt_reg
 			STR(PTR)"\t2b, 4b\n\t"              \
 			".previous"                         \
 		: "=r" (res)                                \
-		: "r" (value), "r" (addr), "i" (-EFAULT));
+		: "r" (value), "r" (addr), "i" (-EFAULT));  \
+} while(0)
 
 #define     _StoreDW(addr, value, res) \
+do {                                                        \
 		__asm__ __volatile__ (                      \
 			"1:\tsdl\t%1,(%2)\n"                \
 			"2:\tsdr\t%1, 7(%2)\n\t"            \
@@ -379,10 +404,13 @@ extern void show_registers(struct pt_reg
 			STR(PTR)"\t2b, 4b\n\t"              \
 			".previous"                         \
 		: "=r" (res)                                \
-		: "r" (value), "r" (addr), "i" (-EFAULT));
+		: "r" (value), "r" (addr), "i" (-EFAULT));  \
+} while(0)
+
 #else
 /* MIPSR6 has no swl and sdl instructions */
 #define     _StoreW(addr, value, res, type)  \
+do {                                                        \
 		__asm__ __volatile__ (                      \
 			".set\tpush\n\t"		    \
 			".set\tnoat\n\t"		    \
@@ -409,9 +437,11 @@ extern void show_registers(struct pt_reg
 			".previous"			    \
 		: "=&r" (res)			    	    \
 		: "r" (value), "r" (addr), "i" (-EFAULT)    \
-		: "memory");
+		: "memory");                                \
+} while(0)
 
 #define     StoreDW(addr, value, res) \
+do {                                                        \
 		__asm__ __volatile__ (                      \
 			".set\tpush\n\t"		    \
 			".set\tnoat\n\t"		    \
@@ -451,12 +481,15 @@ extern void show_registers(struct pt_reg
 			".previous"			    \
 		: "=&r" (res)			    	    \
 		: "r" (value), "r" (addr), "i" (-EFAULT)    \
-		: "memory");
+		: "memory");                                \
+} while(0)
+
 #endif /* CONFIG_CPU_MIPSR6 */
 
 #else /* __BIG_ENDIAN */
 
 #define     _LoadHW(addr, value, res, type)  \
+do {                                                        \
 		__asm__ __volatile__ (".set\tnoat\n"        \
 			"1:\t"type##_lb("%0", "1(%2)")"\n"  \
 			"2:\t"type##_lbu("$1", "0(%2)")"\n\t"\
@@ -474,10 +507,12 @@ extern void show_registers(struct pt_reg
 			STR(PTR)"\t2b, 4b\n\t"              \
 			".previous"                         \
 			: "=&r" (value), "=r" (res)         \
-			: "r" (addr), "i" (-EFAULT));
+			: "r" (addr), "i" (-EFAULT));       \
+} while(0)
 
 #ifndef CONFIG_CPU_MIPSR6
 #define     _LoadW(addr, value, res, type)   \
+do {                                                        \
 		__asm__ __volatile__ (                      \
 			"1:\t"type##_lwl("%0", "3(%2)")"\n" \
 			"2:\t"type##_lwr("%0", "(%2)")"\n\t"\
@@ -493,10 +528,13 @@ extern void show_registers(struct pt_reg
 			STR(PTR)"\t2b, 4b\n\t"              \
 			".previous"                         \
 			: "=&r" (value), "=r" (res)         \
-			: "r" (addr), "i" (-EFAULT));
+			: "r" (addr), "i" (-EFAULT));       \
+} while(0)
+
 #else
 /* MIPSR6 has no lwl instruction */
 #define     _LoadW(addr, value, res, type) \
+do {                                                        \
 		__asm__ __volatile__ (			    \
 			".set\tpush\n"			    \
 			".set\tnoat\n\t"		    \
@@ -525,11 +563,14 @@ extern void show_registers(struct pt_reg
 			STR(PTR)"\t4b, 11b\n\t"		    \
 			".previous"			    \
 			: "=&r" (value), "=r" (res)	    \
-			: "r" (addr), "i" (-EFAULT));
+			: "r" (addr), "i" (-EFAULT));       \
+} while(0)
+
 #endif /* CONFIG_CPU_MIPSR6 */
 
 
 #define     _LoadHWU(addr, value, res, type) \
+do {                                                        \
 		__asm__ __volatile__ (                      \
 			".set\tnoat\n"                      \
 			"1:\t"type##_lbu("%0", "1(%2)")"\n" \
@@ -549,10 +590,12 @@ extern void show_registers(struct pt_reg
 			STR(PTR)"\t2b, 4b\n\t"              \
 			".previous"                         \
 			: "=&r" (value), "=r" (res)         \
-			: "r" (addr), "i" (-EFAULT));
+			: "r" (addr), "i" (-EFAULT));       \
+} while(0)
 
 #ifndef CONFIG_CPU_MIPSR6
 #define     _LoadWU(addr, value, res, type)  \
+do {                                                        \
 		__asm__ __volatile__ (                      \
 			"1:\t"type##_lwl("%0", "3(%2)")"\n" \
 			"2:\t"type##_lwr("%0", "(%2)")"\n\t"\
@@ -570,9 +613,11 @@ extern void show_registers(struct pt_reg
 			STR(PTR)"\t2b, 4b\n\t"              \
 			".previous"                         \
 			: "=&r" (value), "=r" (res)         \
-			: "r" (addr), "i" (-EFAULT));
+			: "r" (addr), "i" (-EFAULT));       \
+} while(0)
 
 #define     _LoadDW(addr, value, res)  \
+do {                                                        \
 		__asm__ __volatile__ (                      \
 			"1:\tldl\t%0, 7(%2)\n"              \
 			"2:\tldr\t%0, (%2)\n\t"             \
@@ -588,10 +633,13 @@ extern void show_registers(struct pt_reg
 			STR(PTR)"\t2b, 4b\n\t"              \
 			".previous"                         \
 			: "=&r" (value), "=r" (res)         \
-			: "r" (addr), "i" (-EFAULT));
+			: "r" (addr), "i" (-EFAULT));       \
+} while(0)
+
 #else
 /* MIPSR6 has not lwl and ldl instructions */
 #define	    _LoadWU(addr, value, res, type) \
+do {                                                        \
 		__asm__ __volatile__ (			    \
 			".set\tpush\n\t"		    \
 			".set\tnoat\n\t"		    \
@@ -620,9 +668,11 @@ extern void show_registers(struct pt_reg
 			STR(PTR)"\t4b, 11b\n\t"		    \
 			".previous"			    \
 			: "=&r" (value), "=r" (res)	    \
-			: "r" (addr), "i" (-EFAULT));
+			: "r" (addr), "i" (-EFAULT));       \
+} while(0)
 
 #define     _LoadDW(addr, value, res)  \
+do {                                                        \
 		__asm__ __volatile__ (			    \
 			".set\tpush\n\t"		    \
 			".set\tnoat\n\t"		    \
@@ -667,10 +717,12 @@ extern void show_registers(struct pt_reg
 			STR(PTR)"\t8b, 11b\n\t"		    \
 			".previous"			    \
 			: "=&r" (value), "=r" (res)	    \
-			: "r" (addr), "i" (-EFAULT));
+			: "r" (addr), "i" (-EFAULT));       \
+} while(0)
 #endif /* CONFIG_CPU_MIPSR6 */
 
 #define     _StoreHW(addr, value, res, type) \
+do {                                                        \
 		__asm__ __volatile__ (                      \
 			".set\tnoat\n"                      \
 			"1:\t"type##_sb("%1", "0(%2)")"\n"  \
@@ -689,9 +741,12 @@ extern void show_registers(struct pt_reg
 			STR(PTR)"\t2b, 4b\n\t"              \
 			".previous"                         \
 			: "=r" (res)                        \
-			: "r" (value), "r" (addr), "i" (-EFAULT));
+			: "r" (value), "r" (addr), "i" (-EFAULT));\
+} while(0)
+
 #ifndef CONFIG_CPU_MIPSR6
 #define     _StoreW(addr, value, res, type)  \
+do {                                                        \
 		__asm__ __volatile__ (                      \
 			"1:\t"type##_swl("%1", "3(%2)")"\n" \
 			"2:\t"type##_swr("%1", "(%2)")"\n\t"\
@@ -707,9 +762,11 @@ extern void show_registers(struct pt_reg
 			STR(PTR)"\t2b, 4b\n\t"              \
 			".previous"                         \
 		: "=r" (res)                                \
-		: "r" (value), "r" (addr), "i" (-EFAULT));
+		: "r" (value), "r" (addr), "i" (-EFAULT));  \
+} while(0)
 
 #define     _StoreDW(addr, value, res) \
+do {                                                        \
 		__asm__ __volatile__ (                      \
 			"1:\tsdl\t%1, 7(%2)\n"              \
 			"2:\tsdr\t%1, (%2)\n\t"             \
@@ -725,10 +782,13 @@ extern void show_registers(struct pt_reg
 			STR(PTR)"\t2b, 4b\n\t"              \
 			".previous"                         \
 		: "=r" (res)                                \
-		: "r" (value), "r" (addr), "i" (-EFAULT));
+		: "r" (value), "r" (addr), "i" (-EFAULT));  \
+} while(0)
+
 #else
 /* MIPSR6 has no swl and sdl instructions */
 #define     _StoreW(addr, value, res, type)  \
+do {                                                        \
 		__asm__ __volatile__ (                      \
 			".set\tpush\n\t"		    \
 			".set\tnoat\n\t"		    \
@@ -755,9 +815,11 @@ extern void show_registers(struct pt_reg
 			".previous"			    \
 		: "=&r" (res)			    	    \
 		: "r" (value), "r" (addr), "i" (-EFAULT)    \
-		: "memory");
+		: "memory");                                \
+} while(0)
 
 #define     _StoreDW(addr, value, res) \
+do {                                                        \
 		__asm__ __volatile__ (                      \
 			".set\tpush\n\t"		    \
 			".set\tnoat\n\t"		    \
@@ -797,7 +859,9 @@ extern void show_registers(struct pt_reg
 			".previous"			    \
 		: "=&r" (res)			    	    \
 		: "r" (value), "r" (addr), "i" (-EFAULT)    \
-		: "memory");
+		: "memory");                                \
+} while(0)
+
 #endif /* CONFIG_CPU_MIPSR6 */
 #endif
 
