Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 23:53:23 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:33757 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012169AbaJVVxViFOSZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Oct 2014 23:53:21 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id BBF29C96E2F64;
        Wed, 22 Oct 2014 22:53:10 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 22 Oct
 2014 22:53:14 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 22 Oct 2014 22:53:14 +0100
Received: from localhost (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 22 Oct
 2014 22:53:13 +0100
Date:   Wed, 22 Oct 2014 22:53:13 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>,
        <linux-mips@linux-mips.org>, Ben Hutchings <ben@decadent.org.uk>
Subject: Re: Single MIPS kernel
Message-ID: <20141022215313.GC12296@jhogan-linux.le.imgtec.org>
References: <20141022083437.GB18581@linux-mips.org>
 <5447EFB5.4090009@gmail.com>
 <20141022190515.GC12502@linux-mips.org>
 <alpine.LFD.2.11.1410222010280.21390@eddie.linux-mips.org>
 <20141022204209.GE12502@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20141022204209.GE12502@linux-mips.org>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43506
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Hi,

On Wed, Oct 22, 2014 at 10:42:09PM +0200, Ralf Baechle wrote:
> On Wed, Oct 22, 2014 at 08:19:07PM +0100, Maciej W. Rozycki wrote:
> >  Wouldn't it make sense to make a unified kernel virtually mapped?  That 
> > would avoid the issue with RAM being present at different locations across 
> > systems and also if big pages were used, that I believe are available 
> > almost universally across the MIPS family, any performance hit would be 
> > minimal.  There would be hardly any increase in the binary image size too.  
> > Run-time mappings such as `kmalloc' or `ioremap' could continue using 
> > unmapped segments.

> Otoh the mapped kernel certainly would have the lowest size overhead.
> I have faint memories of restrictions for TLB instructions or was it
> TLB exception handlers into mapped space, would have to do some rtfming
> on that topic.

Yeh, KVM puts all tlb handling in arch/mips/kvm/tlb.c, which is built
statically rather than being included in the kvm kernel module, exactly
for this reason, so that it resides in unmapped memory space.

You'd have to guarantee not to get a TLB exception while the TLB
registers contain important values, since they'll get clobbered by the
taking of the exception itself (e.g. EntryHi gets set to failing
address, EntryLo* undefined), or the TLB entry pointed to by CP0_Index
may be replaced.

There's always CP0_Wired - its use in the kernel is a bit of a mess atm
IIRC.

Cheers
James
