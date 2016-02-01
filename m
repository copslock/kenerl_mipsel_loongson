Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2016 17:07:13 +0100 (CET)
Received: from mail.bmw-carit.de ([62.245.222.98]:43380 "EHLO
        mail.bmw-carit.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011951AbcBAQHLUZ9JN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2016 17:07:11 +0100
Received: from exchange2010.bmw-carit.intra ([192.168.100.28]:27945 helo=mail.bmw-carit.de)
        by mail.bmw-carit.de with esmtps (TLSv1:AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <Daniel.Wagner@bmw-carit.de>)
        id 1aQH0O-0005Sm-32; Mon, 01 Feb 2016 17:07:09 +0100
Received: from handman.bmw-carit.intra (10.242.2.82) by
 Exchange2010.bmw-carit.intra (192.168.100.28) with Microsoft SMTP Server
 (TLS) id 14.3.123.3; Mon, 1 Feb 2016 17:07:08 +0100
X-CTCH-RefID: str=0001.0A0C0202.56AF82AD.0004,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Subject: Re: [PATCH] MIPS: Differentiate between 32 and 64 bit ELF header
To:     "Maciej W. Rozycki" <macro@imgtec.com>
References: <1453992270-4688-1-git-send-email-daniel.wagner@bmw-carit.de>
 <1454074137-16334-1-git-send-email-daniel.wagner@bmw-carit.de>
 <alpine.DEB.2.00.1602010038230.5958@tp.orcam.me.uk>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
From:   Daniel Wagner <daniel.wagner@bmw-carit.de>
Message-ID: <56AF82AB.5010502@bmw-carit.de>
Date:   Mon, 1 Feb 2016 17:07:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.00.1602010038230.5958@tp.orcam.me.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-Path: <daniel.wagner@bmw-carit.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51591
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.wagner@bmw-carit.de
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

On 02/01/2016 01:52 AM, Maciej W. Rozycki wrote:
> On Fri, 29 Jan 2016, Daniel Wagner wrote:
> 
>> Depending on the configuration either the 32 or 64 bit version of
>> elf_check_arch() is defined. parse_crash_elf32_headers() does
>> some basic verification of the ELF header via elf_check_arch().
>> parse_crash_elf64_headers() does it via vmcore_elf64_check_arch()
>> which expands to the same elf_check_check().
>>
>>    In file included from include/linux/elf.h:4:0,
>>                     from fs/proc/vmcore.c:13:
>>    fs/proc/vmcore.c: In function 'parse_crash_elf64_headers':
>>>> arch/mips/include/asm/elf.h:228:23: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
>>      struct elfhdr *__h = (hdr);     \
>>                           ^
>>    include/linux/crash_dump.h:41:37: note: in expansion of macro 'elf_check_arch'
>>     #define vmcore_elf64_check_arch(x) (elf_check_arch(x) || vmcore_elf_check_arch_cross(x))
>>                                         ^
>>    fs/proc/vmcore.c:1015:4: note: in expansion of macro 'vmcore_elf64_check_arch'
>>       !vmcore_elf64_check_arch(&ehdr) ||
>>        ^
>>
>> Since the MIPS ELF header for 32 bit and 64 bit differ we need
>> to check accordingly.
> 
>  I fail to see how it can work as it stands given that `elf_check_arch' is 
> called from the same source file both on a pointer to `Elf32_Ehdr' and one 
> to `Elf64_Ehdr'.  However the MIPS implementations of `elf_check_arch' 
> only use an auxiliary variable to avoid multiple evaluation of a macro 
> argument and therefore instead I recommend the use of the usual approach
> taken in such a situation within a statement expression, that is to 
> declare the variable with `typeof' rather than an explicit type.  As an
> upside this will minimise code disruption as well.

Good point on the type for hdr. Thought elf_check_arch() implementation
differ on 32 bit and 64 bit implementation. I played a bit around and the
simplest version I found was this here:


diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index b01a6ff..8c88238 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -205,8 +205,6 @@ struct mips_elf_abiflags_v0 {
 #define MIPS_ABI_FP_64		6	/* -mips32r2 -mfp64 */
 #define MIPS_ABI_FP_64A		7	/* -mips32r2 -mfp64 -mno-odd-spreg */
 
-#ifdef CONFIG_32BIT
-
 /*
  * In order to be sure that we don't attempt to execute an O32 binary which
  * requires 64 bit FP (FR=1) on a system which does not support it we refuse
@@ -225,23 +223,30 @@ struct mips_elf_abiflags_v0 {
 #define elf_check_arch(hdr)						\
 ({									\
 	int __res = 1;							\
-	struct elfhdr *__h = (hdr);					\
+	typeof(*(hdr)) *__h = (hdr);					\
 									\
 	if (__h->e_machine != EM_MIPS)					\
 		__res = 0;						\
-	if (__h->e_ident[EI_CLASS] != ELFCLASS32)			\
-		__res = 0;						\
-	if ((__h->e_flags & EF_MIPS_ABI2) != 0)				\
-		__res = 0;						\
-	if (((__h->e_flags & EF_MIPS_ABI) != 0) &&			\
-	    ((__h->e_flags & EF_MIPS_ABI) != EF_MIPS_ABI_O32))		\
-		__res = 0;						\
-	if (__h->e_flags & __MIPS_O32_FP64_MUST_BE_ZERO)		\
-		__res = 0;						\
+	if (__same_type(hdr, Elf32_Ehdr *)) {				\
+		if (__h->e_ident[EI_CLASS] != ELFCLASS32)		\
+			__res = 0;					\
+		if ((__h->e_flags & EF_MIPS_ABI2) != 0)			\
+			__res = 0;					\
+		if (((__h->e_flags & EF_MIPS_ABI) != 0) &&		\
+			((__h->e_flags & EF_MIPS_ABI) != EF_MIPS_ABI_O32)) \
+			__res = 0;					\
+		if (__h->e_flags & __MIPS_O32_FP64_MUST_BE_ZERO)	\
+			__res = 0;					\
+	} else if (__same_type(hdr, Elf64_Ehdr *)) {			\
+		if (__h->e_ident[EI_CLASS] != ELFCLASS64)		\
+			__res = 0;					\
+	}								\
 									\
 	__res;								\
 })
 
+#ifdef CONFIG_32BIT
+
 /*
  * These are used to set parameters in the core dumps.
  */
@@ -250,21 +255,6 @@ struct mips_elf_abiflags_v0 {
 #endif /* CONFIG_32BIT */
 
 #ifdef CONFIG_64BIT
-/*
- * This is used to ensure we don't load something for the wrong architecture.
- */
-#define elf_check_arch(hdr)						\
-({									\
-	int __res = 1;							\
-	struct elfhdr *__h = (hdr);					\
-									\
-	if (__h->e_machine != EM_MIPS)					\
-		__res = 0;						\
-	if (__h->e_ident[EI_CLASS] != ELFCLASS64)			\
-		__res = 0;						\
-									\
-	__res;								\
-})
 
 /*
  * These are used to set parameters in the core dumps.


Not sure if that is what you had in mind.

cheers,
daniel
