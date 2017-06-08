Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 17:03:45 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57332 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993865AbdFHPDa3Sja4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jun 2017 17:03:30 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 63A2E488F9E9B;
        Thu,  8 Jun 2017 16:03:21 +0100 (IST)
Received: from [10.20.78.153] (10.20.78.153) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Thu, 8 Jun 2017
 16:03:23 +0100
Date:   Thu, 8 Jun 2017 16:03:14 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH 4/9] MIPS: Send SIGILL for BPOSGE32 in
 `__compute_return_epc_for_insn'
In-Reply-To: <20170608131141.GB8108@linux-mips.org>
Message-ID: <alpine.DEB.2.00.1706081548090.21750@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1706040314270.10864@tp.orcam.me.uk> <alpine.DEB.2.00.1706050258410.10864@tp.orcam.me.uk> <20170608131141.GB8108@linux-mips.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.153]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Thu, 8 Jun 2017, Ralf Baechle wrote:

> >  sigill_dsp:
> > -	printk("%s: DSP branch but not DSP ASE - sending SIGBUS.\n", current->comm);
> > -	force_sig(SIGBUS, current);
> > +	pr_info("%s: DSP branch but not DSP ASE - sending SIGILL.\n",
> > +		current->comm);
> 
> Shouldn't this then maybe be a pr_debug then?  With pr_info the right
> kind of program can produce lots of useless clutter.

 Sure.  Since I'm going to repost anyway to address Greg's concern, I'll 
append an extra patch to the series, to change these all en masse, for 
consistency.

 Eventually I think they will all go as I suspect they cover an impossible 
condition (so BUG_ON will be more appropriate), i.e. you can't get a 
delay-slot exception for a branch that has not been implemented -- you'll 
get a Reserved Instruction exception for the branch itself instead, and 
then there's nothing to emulate.  But I'll have to investigate execution 
paths carefully first, verify that `delay_slot' is called consistently and 
surely split off R2-on-R6 emulation code, before we can consider such a 
change a safe operation.

 Glad to see you back.

  Maciej
