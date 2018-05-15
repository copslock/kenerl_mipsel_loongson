Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 May 2018 00:44:32 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:53635 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992841AbeEOWoWMYqbS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 May 2018 00:44:22 +0200
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx4.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Tue, 15 May 2018 22:43:51 +0000
Received: from [10.20.78.107] (10.20.78.107) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Tue, 15
 May 2018 15:33:23 -0700
Date:   Tue, 15 May 2018 23:32:45 +0100
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        James Hogan <jhogan@kernel.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH 1/3] binfmt_elf: Respect error return from `regset->active'
In-Reply-To: <alpine.DEB.2.00.1804301557320.11756@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1805102009380.10896@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1804301557320.11756@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.107]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1526424196-298555-22307-24440-2
X-BESS-VER: 2018.6-r1805102334
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.193020
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Maciej.Rozycki@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63971
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
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

The regset API documented in <linux/regset.h> defines -ENODEV as the 
result of the `->active' handler to be used where the feature requested 
is not available on the hardware found.  However code handling core file 
note generation in `fill_thread_core_info' interpretes any non-zero 
result from the `->active' handler as the regset requested being active. 
Consequently processing continues (and hopefully gracefully fails later 
on) rather than being abandoned right away for the regset requested.

Fix the problem then by making the code proceed only if a positive 
result is returned from the `->active' handler.

Cc: stable@vger.kernel.org # 2.6.25+
Fixes: 4206d3aa1978 ("elf core dump: notes user_regset")
Signed-off-by: Maciej W. Rozycki <macro@mips.com>
---
Hi,

 Overall we could also use the count returned by ->active to limit the 
size of data requested, i.e. something along the lines of:

	ssize_t size;

	if (regset->active)
		size = regset->active(t->task, regset);
	else
		size = regset_size(t->task, regset);
	if (size > 0) {
		...	

however that would be an optimisation that belongs to a separate change, 
which (due to the need to unload stuff I have in progress already) I am 
not going to make at this point.  Perhaps someone else would be willing 
to pick up the idea.

 Anyway, please apply.

  Maciej
---
 fs/binfmt_elf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

linux-elf-core-regset-active.diff
Index: linux-jhogan-test/fs/binfmt_elf.c
===================================================================
--- linux-jhogan-test.orig/fs/binfmt_elf.c	2018-03-21 17:14:55.000000000 +0000
+++ linux-jhogan-test/fs/binfmt_elf.c	2018-05-09 23:25:50.742255000 +0100
@@ -1739,7 +1739,7 @@ static int fill_thread_core_info(struct 
 		const struct user_regset *regset = &view->regsets[i];
 		do_thread_regset_writeback(t->task, regset);
 		if (regset->core_note_type && regset->get &&
-		    (!regset->active || regset->active(t->task, regset))) {
+		    (!regset->active || regset->active(t->task, regset) > 0)) {
 			int ret;
 			size_t size = regset_size(t->task, regset);
 			void *data = kmalloc(size, GFP_KERNEL);
