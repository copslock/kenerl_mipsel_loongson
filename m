Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2013 18:59:11 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:47120 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861468Ab3IQQ7JYpa2m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Sep 2013 18:59:09 +0200
Date:   Tue, 17 Sep 2013 17:59:09 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: Re: [MIPS] CP0 PRId and CP1 FPIR register access masks
In-Reply-To: <20130917161957.GH22468@linux-mips.org>
Message-ID: <alpine.LFD.2.03.1309171752430.5967@linux-mips.org>
References: <alpine.LFD.2.03.1309171641260.5967@linux-mips.org> <20130917161957.GH22468@linux-mips.org>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37837
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Tue, 17 Sep 2013, Ralf Baechle wrote:

> But while it's cleaner, I think the idiom read_c0_prid() & some_MASK is
> so common that maybe something like
> 
>   #define read_c0_prid_imp()	(read_c0_prid() & PRID_IMP_MASK)
>   #define read_c0_prid_rev()	(read_c0_prid() & PRID_REV_MASK)
>   #define read_c0_prid_comp()	(read_c0_prid() & PRID_COMP_MASK)
> 
> should be introduced as a next step.

 In some places maybe.  Other need several parts of PRId examined and 
using these accessors would be a pessimisation (GCC cannot combine 
multiple read_c0_prid() calls into one).  Some further places should 
probably use current_cpu_data.processor_id instead.  Maybe even most 
should.  Overall I'm not sure how much use these macros would get after 
all.

  Maciej
