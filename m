Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 May 2016 10:55:52 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39552 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028590AbcEJIzrAs6P- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 May 2016 10:55:47 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 325A8B7758190;
        Tue, 10 May 2016 09:55:38 +0100 (IST)
Received: from [10.20.78.166] (10.20.78.166) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Tue, 10 May 2016
 09:55:40 +0100
Date:   Tue, 10 May 2016 09:55:26 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, Paul Burton
        <paul.burton@imgtec.com>, Manuel Lauss <manuel.lauss@gmail.com>, Jayachandran
 C. <jchandra@broadcom.com>, Paolo Bonzini <pbonzini@redhat.com>,
        =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH 0/7] MIPS: Add extended ASID support
In-Reply-To: <20160510073444.GA16402@linux-mips.org>
Message-ID: <alpine.DEB.2.00.1605100946330.6794@tp.orcam.me.uk>
References: <1462541784-22128-1-git-send-email-james.hogan@imgtec.com> <20160509132315.GA28818@linux-mips.org> <alpine.DEB.2.00.1605091756520.6794@tp.orcam.me.uk> <20160509190442.GC23699@jhogan-linux.le.imgtec.org> <alpine.DEB.2.00.1605092041200.6794@tp.orcam.me.uk>
 <20160510073444.GA16402@linux-mips.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.166]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53339
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

On Tue, 10 May 2016, Ralf Baechle wrote:

> > (we ought to handle this one day actually, for correct unaligned access 
> > emulation -- right now you get a repeated AdEL exception in emulation code 
> > for what originally was an unaligned out of range kernel XKPHYS access, 
> > making it a big pain to debug; I've had a hack for this since 2.4 days, 
> > but it should be done properly).
> 
> Yeah, it's simply an implementation guided by the SISO principle.  Shit in,
> shit out.  The issue you're having rarely hurts and if a simple hack can
> solve it I'm in principle open to consider it for merging.

 The problem with my hack is it is only correct for the R4000/R4400 as I 
just hardwired the bits I needed to debug the issues I had.  Well, maybe 
for a couple of other processors as well, but I'd say it's not upstream 
quality.

> >  In the old days pretty much nothing was recorded in the single Config 
> > register (very old chips didn't even have that -- you had to size caches 
> > manually for example), but stuff could often be determined via other 
> > means, sometimes (like probably here) without detailed checks on PRId.
> 
> Sizing the R4000/R4400 second level cache for example.  I'd call that
> taking the RISC design principle to the edge :-)

 Or the corresponding R2000/R3000 stuff.  I'm still rather sceptical about 
our results of cache line size probing, they seem too different from what 
relevant documentation says.  To say nothing of the fill vs invalidation 
line size difference (I think we just report the latter while we're more 
interested in and the algorithm is supposed to report the former).

  Maciej
