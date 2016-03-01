Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Mar 2016 00:55:55 +0100 (CET)
Received: from mail333.us4.mandrillapp.com ([205.201.137.77]:58633 "EHLO
        mail333.us4.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27024642AbcCAXyl4WaGJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Mar 2016 00:54:41 +0100
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=mandrill; d=linuxfoundation.org;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=gregkh@linuxfoundation.org;
 bh=DKgjdRvFrqen2oNmz+gOBIXmZm0=;
 b=gMjzd0Sn6NzeKvwFtNUU7GuNCJ6Dpfo3V5uTIpRotUYRM3lONJ1GYgHEjG94vdxp1Ucu4jTLQKze
   VUboordVGivfSuJLrZMkta6KRc4KJYuJF9zuZexUkdndyreAiCbHMOgE3wptk5oZPSfNIVedMOqL
   xyJVoFsKvXCEVoAUf/4=
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=mandrill; d=linuxfoundation.org;
 b=R1cHVpfJ6HLxHKN94bFdE3QxuPKYfcL8/sOIczhWkBrRvad/daAUl9sPrH9QZnltjYmh7an2BRrH
   yscF43u4KF7ODh1cXvW37oNN2W/fCrUdNdPL8PotONHeui787b4i/QxZ7+mGCIu//VGlYYtZjvfR
   UeZ1m6Q7AJAZF1kE6UU=;
Received: from pmta03.dal05.mailchimp.com (127.0.0.1) by mail333.us4.mandrillapp.com id hqols2174nol for <linux-mips@linux-mips.org>; Tue, 1 Mar 2016 23:54:36 +0000 (envelope-from <bounce-md_30481620.56d62bbc.v1-dd98e1dcd21e4d748cac6204cc74067c@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1456876476; h=From : 
 Subject : To : Cc : Message-Id : In-Reply-To : References : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=CD0YTsGjbGE7MiWg8Wmwogdel/YU3WpuxrWE1/7mFP8=; 
 b=MQF5XIMTsbz0ucfFLs8sqoP6aTFwFVWwiO/s6SHW1Q6p3xYHkXDIwUm+VJ5bRYznBBYwXp
 RS8dSIdyUxU5tFlCnwglSecbAB2rKAjAAf6iFBZ84tMtFeHjDtbsWl3phEvYunOBvPBsu1gD
 NXzNdSbR3mh47cMtayuNULlFVaX/E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.4 157/342] MIPS: Fix some missing CONFIG_CPU_MIPSR6 #ifdefs
Received: from [50.170.35.168] by mandrillapp.com id dd98e1dcd21e4d748cac6204cc74067c; Tue, 01 Mar 2016 23:54:36 +0000
X-Mailer: git-send-email 2.7.2
To:     <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <stable@vger.kernel.org>, Huacai Chen <chenhc@lemote.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Message-Id: <20160301234533.043363729@linuxfoundation.org>
In-Reply-To: <20160301234527.990448862@linuxfoundation.org>
References: <20160301234527.990448862@linuxfoundation.org>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=30481620.dd98e1dcd21e4d748cac6204cc74067c
X-Mandrill-User: md_30481620
Date:   Tue, 01 Mar 2016 23:54:36 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <bounce-md_30481620.56d62bbc.v1-dd98e1dcd21e4d748cac6204cc74067c@mandrillapp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52405
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhc@lemote.com>

commit 4f33f6c522948fffc345261896042b58dea23754 upstream.

Commit be0c37c985eddc4 (MIPS: Rearrange PTE bits into fixed positions.)
defines fixed PTE bits for MIPS R2. Then, commit d7b631419b3d230a4d383
(MIPS: pgtable-bits: Fix XPA damage to R6 definitions.) adds the MIPS
R6 definitions in the same way as MIPS R2. But some R6 #ifdefs in the
later commit are missing, so in this patch I fix that.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/12164/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/pgtable.h |    4 ++--
 arch/mips/mm/tlbex.c            |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -353,7 +353,7 @@ static inline pte_t pte_mkdirty(pte_t pt
 static inline pte_t pte_mkyoung(pte_t pte)
 {
 	pte_val(pte) |= _PAGE_ACCESSED;
-#ifdef CONFIG_CPU_MIPSR2
+#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
 	if (!(pte_val(pte) & _PAGE_NO_READ))
 		pte_val(pte) |= _PAGE_SILENT_READ;
 	else
@@ -560,7 +560,7 @@ static inline pmd_t pmd_mkyoung(pmd_t pm
 {
 	pmd_val(pmd) |= _PAGE_ACCESSED;
 
-#ifdef CONFIG_CPU_MIPSR2
+#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
 	if (!(pmd_val(pmd) & _PAGE_NO_READ))
 		pmd_val(pmd) |= _PAGE_SILENT_READ;
 	else
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -242,7 +242,7 @@ static void output_pgtable_bits_defines(
 	pr_define("_PAGE_HUGE_SHIFT %d\n", _PAGE_HUGE_SHIFT);
 	pr_define("_PAGE_SPLITTING_SHIFT %d\n", _PAGE_SPLITTING_SHIFT);
 #endif
-#ifdef CONFIG_CPU_MIPSR2
+#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
 	if (cpu_has_rixi) {
 #ifdef _PAGE_NO_EXEC_SHIFT
 		pr_define("_PAGE_NO_EXEC_SHIFT %d\n", _PAGE_NO_EXEC_SHIFT);
