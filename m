Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Aug 2012 15:04:58 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:56999 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903755Ab2HHNEy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Aug 2012 15:04:54 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q78D4pAv016354;
        Wed, 8 Aug 2012 15:04:51 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q78D4nG3016351;
        Wed, 8 Aug 2012 15:04:49 +0200
Date:   Wed, 8 Aug 2012 15:04:49 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Akhilesh Kumar <akhilesh.lxr@gmail.com>
Cc:     paul.gortmaker@windriver.com, linux-mips@linux-mips.org
Subject: Re: [Memory leak]: memory leak in apply_r_mips_lo16_rel
Message-ID: <20120808130449.GA11037@linux-mips.org>
References: <CADArhcAOaYLVk2MU3aExBNumgKeUTC7WKHKSL3kZ-O82028vAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADArhcAOaYLVk2MU3aExBNumgKeUTC7WKHKSL3kZ-O82028vAw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34070
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sat, Aug 04, 2012 at 03:59:50AM +0530, Akhilesh Kumar wrote:

> 
> I found some memory leak in
> arch/mips/kernel/module.c file
> 
> Please review below patch and share your review comments,
> 
> Thanks,
> Akhilesh
> 
> 
> >From 77b8cae374a95000a1fd7e75bcda6694b8180fe9 Mon Sep 17 00:00:00 2001
> From: Akhilesh Kumar <akhilesh.lxr@gmail.com>
> Date: Sat, 4 Aug 2012 03:34:06 +0530
> Subject:  [Memory leak]: memory leak in  apply_r_mips_lo16_rel
>  module.c
> 
> if (v != l->value)
>              goto out_danger ;
> out_danger:
>   pr_err("module %s: dangerous R_MIPS_LO16 REL relocation\n", me->name);
>   return -ENOEXEC;
> 
> in case goto_out_danger kfree(l) is missing
> 
> Signed-off-by: Akhilesh Kumar <akhilesh.lxr@gmail.com>
> ---
>  arch/mips/kernel/module.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
> index a5066b1..b1dce44 100644
> --- a/arch/mips/kernel/module.c
> +++ b/arch/mips/kernel/module.c
> @@ -202,7 +202,7 @@ static int apply_r_mips_lo16_rel(struct module *me, u32
> *location, Elf_Addr v)
> 
>  out_danger:
>   pr_err("module %s: dangerous R_MIPS_LO16 REL relocation\n", me->name);
> -
> + kfree(l);

The variable l isn't declared at this point.  You obviously haven't tried
to compile this.

>   return -ENOEXEC;

Well spotted - this bug has been around for ages.  The fix is incorrect
though.  L is pointing to a linked list and we need to free the entire
linked list, not just the element currently being processed.

I noticed the same issue in VPE loader in arch/mips/kernel/vpe.c, function
apply_r_mips_lo16() and fixed it in 477c4b07406357ad93d0e32788dbf3ee814eadaa
/ 6f5d2e970452b5c86906adcb8e7ad246f535ba39 [MIPS: VPE: Free relocation chain
on error.] but back then almost exactly 3 years ago I did not notice the
same issue to exist in the module loader as well.

Also reviewing the HI16/LO16 processing I noticed that there is a race
condition if multiple modules are being loaded in parallel - but that's a
different problem.

  Ralf

>From 3ae0244ccd4cd56293fd5764aaf30127882a0170 Mon Sep 17 00:00:00 2001
From: Ralf Baechle <ralf@linux-mips.org>
Date: Wed, 8 Aug 2012 14:57:03 +0200
Subject: [PATCH] MIPS: Fix memory leak in error path of HI16/LO16 relocation
 handling.

Commit 6f5d2e970452b5c86906adcb8e7ad246f535ba39 (lmo) /
477c4b07406357ad93d0e32788dbf3ee814eadaa (kernel.org) [[MIPS: VPE: Free
relocation chain on error.] fixed the same issue in the vpe loader in 2009
but back then the same bug in module.c went unfixed.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Reported-by: Akhilesh Kumar <akhilesh.lxr@gmail.com>
---
 arch/mips/kernel/module.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
index a5066b1..e5f2f56 100644
--- a/arch/mips/kernel/module.c
+++ b/arch/mips/kernel/module.c
@@ -146,16 +146,15 @@ static int apply_r_mips_lo16_rel(struct module *me, u32 *location, Elf_Addr v)
 {
 	unsigned long insnlo = *location;
 	Elf_Addr val, vallo;
+	struct mips_hi16 *l, *next;
 
 	/* Sign extend the addend we extract from the lo insn.  */
 	vallo = ((insnlo & 0xffff) ^ 0x8000) - 0x8000;
 
 	if (mips_hi16_list != NULL) {
-		struct mips_hi16 *l;
 
 		l = mips_hi16_list;
 		while (l != NULL) {
-			struct mips_hi16 *next;
 			unsigned long insn;
 
 			/*
@@ -201,6 +200,12 @@ static int apply_r_mips_lo16_rel(struct module *me, u32 *location, Elf_Addr v)
 	return 0;
 
 out_danger:
+	while (l) {
+		next = l->next;
+		kfree(l);
+		l = next;
+	}
+
 	pr_err("module %s: dangerous R_MIPS_LO16 REL relocation\n", me->name);
 
 	return -ENOEXEC;
