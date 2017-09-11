Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Sep 2017 07:22:00 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:58091 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990773AbdIKFVuZu7sP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Sep 2017 07:21:50 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 2B1E4F644B6CD;
        Mon, 11 Sep 2017 06:21:41 +0100 (IST)
Received: from [10.20.78.11] (10.20.78.11) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Mon, 11 Sep 2017
 06:21:42 +0100
Date:   Mon, 11 Sep 2017 06:21:34 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Fredrik Noring <noring@nocrew.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Add basic R5900 support
In-Reply-To: <alpine.DEB.2.00.1709091022180.4331@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1709110610290.5244@tp.orcam.me.uk>
References: <20170827132309.GA32166@localhost.localdomain> <alpine.DEB.2.00.1708271511430.17596@tp.orcam.me.uk> <20170902102830.GA2602@localhost.localdomain> <alpine.DEB.2.00.1709091022180.4331@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.11]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59984
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

On Sat, 9 Sep 2017, Maciej W. Rozycki wrote:

>  Can you please try flipping the bits instead then, e.g.:
> 
> 	uint32_t fcsr0, fcsr1;
> 	asm volatile (" cfc1 %0,$31\n"
> 		      " lui  %1,0xfffc\n"

 Actually can you please substitute:

		      " li   %1,0xfffc0003\n"

here, so that we know how RM behaves?

 Again, it is odd to see it set to 1 (towards zero) by default and if it 
is hardwired, then `->fpu_csr31' and `->fpu_msk31' will have to be 
updated, AT_FPUCW exported and glibc adjusted.

  Maciej
