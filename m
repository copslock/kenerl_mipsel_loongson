Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Feb 2016 15:37:07 +0100 (CET)
Received: from mailout2.w1.samsung.com ([210.118.77.12]:32637 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011838AbcBOOgtMAgDJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Feb 2016 15:36:49 +0100
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O2L007AZF950C40@mailout2.w1.samsung.com>; Mon,
 15 Feb 2016 14:36:41 +0000 (GMT)
X-AuditID: cbfec7f5-f79b16d000005389-c3-56c1e279f95b
Received: from eusync3.samsung.com ( [203.254.199.213])
        by eucpsbgm2.samsung.com (EUCPMTA) with SMTP id 55.7D.21385.972E1C65; Mon,
 15 Feb 2016 14:36:41 +0000 (GMT)
Received: from AMDC1061.digital.local ([106.116.147.88])
 by eusync3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0O2L005QPF94GF00@eusync3.samsung.com>; Mon,
 15 Feb 2016 14:36:41 +0000 (GMT)
From:   Andrzej Hajda <a.hajda@samsung.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 2/7] MIPS: module: fix incorrect IS_ERR_VALUE macro usages
Date:   Mon, 15 Feb 2016 15:35:20 +0100
Message-id: <1455546925-22119-3-git-send-email-a.hajda@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1455546925-22119-1-git-send-email-a.hajda@samsung.com>
References: <1455546925-22119-1-git-send-email-a.hajda@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkluLIzCtJLcpLzFFi42I5/e/4Vd3KRwfDDPaeMbe4te4cq8XGGetZ
        LS7vmsNmMWHqJHaLtUfusltc2qPiwOZxdOVaJo++LasYPT5vkgtgjuKySUnNySxLLdK3S+DK
        mLfvMXvBK56K1ccuszQwXufqYuTkkBAwkfjVsIUJwhaTuHBvPRuILSSwlFHiwnwhCLuJSWJf
        cwWIzSagKfF3802wGhEBBYnNvc9Yuxi5OJgFzjNKbHz7mxEkISzgJfFg/RIWEJtFQFViyrfP
        7F2MHBy8As4Sh2dpQOySkzh5bDIrSJhTwEViwd4CiFXOEvt3b2OawMi7gJFhFaNoamlyQXFS
        eq6RXnFibnFpXrpecn7uJkZIwHzdwbj0mNUhRgEORiUe3ogzB8KEWBPLiitzDzFKcDArifBa
        nD4YJsSbklhZlVqUH19UmpNafIhRmoNFSZx35q73IUIC6YklqdmpqQWpRTBZJg5OqQbGiKSV
        ssvWPd4QMDV/U90Zn2nNt4KOqb368TGb68mEPTJrPxTcO3O+7OwHiyWTFYIKJ+nq+HmdfWpz
        yW5DUP7p9b+8zKxydH2FvV1+KgXOibQ33CBX6ORQHBQ7d5fRa1Wf7MfL3/xznvhqeQBH4N24
        BUqiQpd9vgkubl9l4TXrdOq7pi1TZt9hVWIpzkg01GIuKk4EADxuafgUAgAA
Return-Path: <a.hajda@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52060
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.hajda@samsung.com
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

IS_ERR_VALUE macro should be used only with unsigned long type.
Specifically it works incorrectly with longer types.

The patch follows conclusion from discussion on LKML [1][2].

[1]: http://permalink.gmane.org/gmane.linux.kernel/2120927
[2]: http://permalink.gmane.org/gmane.linux.kernel/2150581

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 arch/mips/kernel/module-rela.c | 2 +-
 arch/mips/kernel/module.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/module-rela.c b/arch/mips/kernel/module-rela.c
index 2b70723..08100dc 100644
--- a/arch/mips/kernel/module-rela.c
+++ b/arch/mips/kernel/module-rela.c
@@ -125,7 +125,7 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 		/* This is the symbol it is referring to */
 		sym = (Elf_Sym *)sechdrs[symindex].sh_addr
 			+ ELF_MIPS_R_SYM(rel[i]);
-		if (IS_ERR_VALUE(sym->st_value)) {
+		if (sym->st_value >= -MAX_ERRNO) {
 			/* Ignore unresolved weak symbol */
 			if (ELF_ST_BIND(sym->st_info) == STB_WEAK)
 				continue;
diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
index 1833f51..2ba73bf4 100644
--- a/arch/mips/kernel/module.c
+++ b/arch/mips/kernel/module.c
@@ -214,7 +214,7 @@ int apply_relocate(Elf_Shdr *sechdrs, const char *strtab,
 		/* This is the symbol it is referring to */
 		sym = (Elf_Sym *)sechdrs[symindex].sh_addr
 			+ ELF_MIPS_R_SYM(rel[i]);
-		if (IS_ERR_VALUE(sym->st_value)) {
+		if (sym->st_value >= -MAX_ERRNO) {
 			/* Ignore unresolved weak symbol */
 			if (ELF_ST_BIND(sym->st_info) == STB_WEAK)
 				continue;
-- 
1.9.1
