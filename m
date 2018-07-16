Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jul 2018 07:45:14 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:35470 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991162AbeGPFpHaHU6D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Jul 2018 07:45:07 +0200
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx1.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Mon, 16 Jul 2018 05:44:35 +0000
Received: from [10.20.78.133] (10.20.78.133) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Sun, 15
 Jul 2018 22:44:42 -0700
Date:   Mon, 16 Jul 2018 06:44:23 +0100
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Paul Burton <paul.burton@mips.com>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 1/3] binfmt_elf: Respect error return from
 `regset->active'
In-Reply-To: <20180629171330.4giikc5x2cbxxuyc@pburton-laptop>
Message-ID: <alpine.DEB.2.00.1807151824230.30992@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1804301557320.11756@tp.orcam.me.uk> <alpine.DEB.2.00.1805102009380.10896@tp.orcam.me.uk> <20180629171330.4giikc5x2cbxxuyc@pburton-laptop>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.133]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1531719874-298552-23289-155744-1
X-BESS-VER: 2018.9-r1807111811
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Envelope-From: maciej.rozycki@uk.mips.com
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.195800
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender Domain Matches Recipient Domain 
X-BESS-Outbound-Spam-Status: SCORE=0.01 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_SA_TO_FROM_DOMAIN_MATCH
X-BESS-Orig-Rcpt: viro@zeniv.linux.org.uk,jhogan@kernel.org,ralf@linux-mips.org,linux-fsdevel@vger.kernel.org,linux-mips@linux-mips.org,linux-kernel@vger.kernel.org,stable@vger.kernel.org
X-BESS-BRTS-Status: 1
Return-Path: <maciej.rozycki@uk.mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64839
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

Hi Paul,

> > --- linux-jhogan-test.orig/fs/binfmt_elf.c	2018-03-21 17:14:55.000000000 +0000
> > +++ linux-jhogan-test/fs/binfmt_elf.c	2018-05-09 23:25:50.742255000 +0100
> > @@ -1739,7 +1739,7 @@ static int fill_thread_core_info(struct 
> >  		const struct user_regset *regset = &view->regsets[i];
> >  		do_thread_regset_writeback(t->task, regset);
> >  		if (regset->core_note_type && regset->get &&
> > -		    (!regset->active || regset->active(t->task, regset))) {
> > +		    (!regset->active || regset->active(t->task, regset) > 0)) {
> >  			int ret;
> >  			size_t size = regset_size(t->task, regset);
> >  			void *data = kmalloc(size, GFP_KERNEL);
> > 
> 
> This looks obviously right to me, although I don't think it affects
> anything until commit 25847fb195ae ("powerpc/ptrace: Enable support for
> NT_PPC_CGPR") in v4.8-rc1 & even then not in a harmful way so I'd drop
> the stable tag.

 I'm fine with dropping the tag FWIW.  Thanks for taking care of my patch.

  Maciej
