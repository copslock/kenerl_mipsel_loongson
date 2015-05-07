Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 May 2015 14:18:40 +0200 (CEST)
Received: from hofr.at ([212.69.189.236]:43519 "EHLO mail.hofr.at"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012318AbbEGMSj3exF0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 7 May 2015 14:18:39 +0200
Received: by mail.hofr.at (Postfix, from userid 1002)
        id 0EE494F8C0D; Thu,  7 May 2015 14:18:35 +0200 (CEST)
Date:   Thu, 7 May 2015 14:18:35 +0200
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Gleb Natapov <gleb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG ?] MIPS: KVM: condition with no effect
Message-ID: <20150507121835.GA23830@opentech.at>
References: <20150505123438.GA21514@opentech.at> <20150505214205.GD17687@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150505214205.GD17687@jhogan-linux.le.imgtec.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <hofrat@hofr.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47269
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: der.herr@hofr.at
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

On Tue, 05 May 2015, James Hogan wrote:

> Hi,
> 
> On Tue, May 05, 2015 at 02:34:38PM +0200, Nicholas Mc Guire wrote:
> > 
> > Hi !
> > 
> >  Not sure if this is a bug or maybe a placeholder for
> >  something... so patch - but maybe someone that knows this code can
> >  give it a look.
> > 
> > arch/mips/kvm/emulate.c:emulation_result kvm_mips_complete_mmio_load()    
> > <snip>
> > 2414         case 2:
> > 2415                 if (vcpu->mmio_needed == 2)
> > 2416                         *gpr = *(int16_t *) run->mmio.data;                
> > 2417                 else
> > 2418                         *gpr = *(int16_t *) run->mmio.data;
> > 2419 
> > 2420                 break;
> > <snip>
> > 
> >  either the if/else is not needed or one of the branches is wrong
> >  or it is a place-holder for somethign that did not get
> >  done - in which case a few lines explaining this would be 
> >  nice (e.g. like in arch/sh/kernel/traps_64.c line 59)
> > 
> >  line numbers refer to 4.1-rc2 
> 
> mmio_needed encodes whether the MMIO load is a signed (2) or unsigned
> (1) load. E.g. the len == 1 case just below casts the pointer to u8 vs
> int8_t to control sign extension. So it appears the else branch (line
> 2418 in your quote) should be uint16_t (or u16) to prevent the MMIO
> value loaded by a lhu (load halfword unsigned) being sign extended to
> the full width of the registers. Nice catch!
>
thanks for the clarification - will send the patch out shortly.

This was found by a trivial coccinelle scanner

<snip>
virtual context
virtual org
virtual report

@cond@
position p;
statement S1;
@@

<+...
* if@p (...) S1 else S1
...+>

@script:python@
p << cond.p;
@@

print "%s:%s WARNING: condition with no effect (if branch == else)" % (p[0].file,p[0].line)                                                                     
<snip>
