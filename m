Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 May 2016 21:57:10 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:19151 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028458AbcEIT5ITe-Ly (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 May 2016 21:57:08 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 1035B6632C9F5;
        Mon,  9 May 2016 20:56:58 +0100 (IST)
Received: from [10.20.78.157] (10.20.78.157) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Mon, 9 May 2016
 20:57:01 +0100
Date:   Mon, 9 May 2016 20:56:51 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     James Hogan <james.hogan@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>, Jayachandran C.
        <jchandra@broadcom.com>, Paolo Bonzini <pbonzini@redhat.com>,
        =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH 0/7] MIPS: Add extended ASID support
In-Reply-To: <20160509190442.GC23699@jhogan-linux.le.imgtec.org>
Message-ID: <alpine.DEB.2.00.1605092041200.6794@tp.orcam.me.uk>
References: <1462541784-22128-1-git-send-email-james.hogan@imgtec.com> <20160509132315.GA28818@linux-mips.org> <alpine.DEB.2.00.1605091756520.6794@tp.orcam.me.uk> <20160509190442.GC23699@jhogan-linux.le.imgtec.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.157]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53323
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

On Mon, 9 May 2016, James Hogan wrote:

> > > Already PMC-Sierra's RM9000 / E9000 core had an extended ASID field, of
> > > 12 bits for 4096 ASID contexts.  Afaics this was an extension derived
> > > in-house back in the wild days before everything had to be sanctioned by
> > > the architecture folks, so there is nothing in a config register to test
> > > for it.
> > 
> >  Couldn't you just probe it in EntryHi directly, by writing all-ones, 
> > reading back and seeing how many bits have stuck?
> 
> Note, the tlbinv feature in recent versions of MIPS32/MIPS64 arch has
> EHINV bit in bit 10 (if I remember right) of EntryHi, which marks whole
> tlb entry as invalid, and the small pages feature (for 1k pages) extends
> VPN field downwards to bit 11.

 Yes, but these are not legacy architectures, are they?  Since you've got 
bits set across Config registers you don't need to resort to poking at 
other registers.  Although there are exceptions like PABITS and SEGBITS 
(we ought to handle this one day actually, for correct unaligned access 
emulation -- right now you get a repeated AdEL exception in emulation code 
for what originally was an unaligned out of range kernel XKPHYS access, 
making it a big pain to debug; I've had a hack for this since 2.4 days, 
but it should be done properly).

 In the old days pretty much nothing was recorded in the single Config 
register (very old chips didn't even have that -- you had to size caches 
manually for example), but stuff could often be determined via other 
means, sometimes (like probably here) without detailed checks on PRId.

  Maciej
