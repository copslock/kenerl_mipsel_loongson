Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 May 2017 22:55:53 +0200 (CEST)
Received: from mout.web.de ([212.227.15.4]:62083 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23995043AbdEWUz0b0TZv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 May 2017 22:55:26 +0200
Received: from [192.168.1.2] ([78.49.50.198]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MN4K8-1dJtbe3kQi-006gsY; Tue, 23
 May 2017 22:55:07 +0200
Subject: [PATCH 5/5] MIPS: VPE: Adjust 13 checks for null pointers
From:   SF Markus Elfring <elfring@users.sourceforge.net>
To:     linux-mips@linux-mips.org, Ingo Molnar <mingo@kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Kees Cook <keescook@chromium.org>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        =?UTF-8?Q?Ralf_B=c3=a4chle?= <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <e866716c-5ce4-3658-f944-e310007db127@users.sourceforge.net>
Message-ID: <44ff74fa-07c9-3f9c-6cda-050296400c72@users.sourceforge.net>
Date:   Tue, 23 May 2017 22:55:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <e866716c-5ce4-3658-f944-e310007db127@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:yPvDQl6pjUolNxu/dhY1DvynVgKAzWspOWQrYHe38U6No4p6hu2
 WTHgMYxbcAJjycGCGKacyAlhtOqC5pazZSbGNARRHXtzOYTYke6pyaVT6AZr1HaiRGy/GS6
 pVX4p/ulOpgtH2r0ylRLQLGgOM8LN19qwJxiU1/zZBmZWr9T2VXRdBlk15QVzpfMBwv+7eX
 o7XCD9aeDg6XL3eSbt1Cg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZDM7CKNoh8E=:X8rpTJDrStXmpafA5+SFOA
 tkJrJChoNgUWH5gGqCloWe+nethcCqmZiXOQMWlk1e6ptAOkqcRO451aygR3fkMZRfNuodZlp
 1iY5y7t8gOcJu4jDlRuPi6x2pAbhSEhqIoL4Inbdkdi8L9KvkhY1YkyPgi16swSZD+xcNMG4l
 OE89G5O75ntFdZiqpE0Yns5Z8vprBAsMWyW1jpFKBNvVGq6Ne++npt/FyfEE61YVOlgVcHeZA
 BMiZIgWU+BLMxie+Nf48kn496VjZBugQzGPAHVzt6m3fCMPOP2zEDX+Dbq2IlRG8jFkIz1BQD
 busnHm1bU8A8zr3NKvxMvMBCSjVJPDrGWVG0jkvn14/19emItQta/0c2j7IaUDSpGnCqyraxu
 CgIFPyKtr5tAjA9yZK3fCil/kFRNVGpEkcBH9SGto0WvQmMMotXiGGg3CIpBbHe5fnPykMa8H
 8gEPq0Jb8OzvU+1L1ElkyaECW/6VHrXU/hvQWQ3K+sv/w0i3Vvgv1EpTl/bM2fuFglPcAljNR
 T8wpOpV1KZN07ziKO1ufdoPooWeDoxGnaRG+nrTO3i/PejUGYZ68bR61IoiqU7dchNI/cY4c9
 rVvtEkrwgTbiGQml8neXmnCjIUJ/ZtwJIs+W6s7G5huPCsSJMM2rYveZGqKCvrJOWDFW2oOcr
 vcak6DyYvfeugfpaakvaANd2UC+QF+h0juf7HIBUugr69P9/5jmNturJ0eO7RDBxc8qqf70GW
 tQZ/AXj/uV2c6dNtKZ8o2Kkg4a6wZ4NYlo/q4abo9aHJC8xBuwIi3J8GD3qaZLGdNnrvfk2uw
 6YQeBEf
Return-Path: <elfring@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57963
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: elfring@users.sourceforge.net
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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 23 May 2017 22:16:24 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The script “checkpatch.pl” pointed information out like the following.

Comparison to NULL could be written …

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/mips/kernel/vpe.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
index ed019218496b..0ef7654e67e4 100644
--- a/arch/mips/kernel/vpe.c
+++ b/arch/mips/kernel/vpe.c
@@ -97,4 +97,4 @@ struct vpe *alloc_vpe(int minor)
-	if (v == NULL)
+	if (!v)
 		goto out;
 
 	INIT_LIST_HEAD(&v->tc);
@@ -118,4 +118,4 @@ struct tc *alloc_tc(int index)
-	if (tc == NULL)
+	if (!tc)
 		goto out;
 
 	INIT_LIST_HEAD(&tc->tc);
@@ -340,10 +340,9 @@ static int apply_r_mips_lo16(struct module *me, uint32_t *location,
 	/* Sign extend the addend we extract from the lo insn.	*/
 	vallo = ((insnlo & 0xffff) ^ 0x8000) - 0x8000;
 
-	if (mips_hi16_list != NULL) {
-
+	if (mips_hi16_list) {
 		l = mips_hi16_list;
-		while (l != NULL) {
+		while (l) {
 			unsigned long insn;
 
 			/*
@@ -391,7 +390,7 @@ static int apply_r_mips_lo16(struct module *me, uint32_t *location,
 	return 0;
 
 out_free:
-	while (l != NULL) {
+	while (l) {
 		next = l->next;
 		kfree(l);
 		l = next;
@@ -562,7 +561,7 @@ static int find_vpe_symbols(struct vpe *v, Elf_Shdr *sechdrs,
 			v->shared_ptr = (void *)sym[i].st_value;
 	}
 
-	if ((v->__start == 0) || (v->shared_ptr == NULL))
+	if ((v->__start == 0) || !v->shared_ptr)
 		return -1;
 
 	return 0;
@@ -737,7 +736,7 @@ static int vpe_elfload(struct vpe *v)
 			return -ENOEXEC;
 		}
 
-		if (v->shared_ptr == NULL)
+		if (!v->shared_ptr)
 			pr_warn("VPE loader: program does not contain vpe_shared symbol.\n"
 				" Unable to use AMVP (AP/SP) facilities.\n");
 	}
@@ -777,7 +776,7 @@ static int vpe_open(struct inode *inode, struct file *filp)
 	}
 
 	v = get_vpe(aprp_cpu_index());
-	if (v == NULL) {
+	if (!v) {
 		pr_warn("VPE loader: unable to get vpe\n");
 
 		return -ENODEV;
@@ -822,7 +821,7 @@ static int vpe_release(struct inode *inode, struct file *filp)
 	int ret = 0;
 
 	v = get_vpe(aprp_cpu_index());
-	if (v == NULL)
+	if (!v)
 		return -ENODEV;
 
 	hdr = (Elf_Ehdr *) v->pbuffer;
@@ -866,8 +865,7 @@ static ssize_t vpe_write(struct file *file, const char __user *buffer,
 		return -ENODEV;
 
 	v = get_vpe(aprp_cpu_index());
-
-	if (v == NULL)
+	if (!v)
 		return -ENODEV;
 
 	if ((count + v->len) > v->plen) {
@@ -895,7 +893,7 @@ void *vpe_get_shared(int index)
 {
 	struct vpe *v = get_vpe(index);
 
-	if (v == NULL)
+	if (!v)
 		return NULL;
 
 	return v->shared_ptr;
@@ -906,7 +904,7 @@ int vpe_notify(int index, struct vpe_notifications *notify)
 {
 	struct vpe *v = get_vpe(index);
 
-	if (v == NULL)
+	if (!v)
 		return -1;
 
 	list_add(&notify->list, &v->notify);
@@ -918,7 +916,7 @@ char *vpe_getcwd(int index)
 {
 	struct vpe *v = get_vpe(index);
 
-	if (v == NULL)
+	if (!v)
 		return NULL;
 
 	return v->cwd;
-- 
2.13.0
