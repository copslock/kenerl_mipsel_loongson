Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2017 15:39:59 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:62674 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993874AbdAYOjwSw9Sy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jan 2017 15:39:52 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id AAD3836AD826D;
        Wed, 25 Jan 2017 14:39:42 +0000 (GMT)
Received: from [10.20.78.25] (10.20.78.25) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Wed, 25 Jan 2017
 14:39:44 +0000
Date:   Wed, 25 Jan 2017 14:39:36 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     James Hogan <james.hogan@imgtec.com>
CC:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2 1/2] MIPS: ptrace: disallow setting watchpoints in
 kernel address space
In-Reply-To: <alpine.DEB.2.00.1701242229480.13564@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1701251427190.13564@tp.orcam.me.uk>
References: <1485163113-21780-1-git-send-email-marcin.nowakowski@imgtec.com> <alpine.DEB.2.00.1701232258380.13564@tp.orcam.me.uk> <20170124185452.GL29015@jhogan-linux.le.imgtec.org> <alpine.DEB.2.00.1701241909540.13564@tp.orcam.me.uk>
 <20170124220554.GM29015@jhogan-linux.le.imgtec.org> <alpine.DEB.2.00.1701242229480.13564@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.25]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56488
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

On Tue, 24 Jan 2017, Maciej W. Rozycki wrote:

> However if we can prove that we won't need the IP[1:0] bits in scenarios 
> that involve a TLB refill, then we could just quickly do a short sequence, 
> say:
> 
> 	lui	$k0, 1 << 23

 Umm, thinko here, this obviously has to be:

	li	$k0, 1 << 23

or alternatively:

	lui	$k0, 1 << (23 - 16)

(GAS will emit a single LUI instruction in either case).

> 	mtc0	$13, $k0
> 	eret
> 
> Otherwise we'll have to do a full RMW sequence; fortunately a single INS 
> from $0 will do here again to clear CP0.Cause.WP and keep the remaining 
> bits.  Maybe we could do just the same in the regular exception epilogue 
> to avoid the dependency on a hazard (and consequently an issue with QEMU).

 Of course a similar hazard is still there, so the same precautions apply.  

 Also I think we do need to clear CP0.Cause.WP in all cases before ERET, 
including the various exception fast paths, such as in the TLBL/TLBS/TLBM 
handlers, which also means we don't have to fiddle with CP0.EntryHi.ASID 
in handler execution paths that run at EXL entirely to completion.

  Maciej
