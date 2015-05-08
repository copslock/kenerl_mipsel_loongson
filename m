Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 May 2015 17:39:44 +0200 (CEST)
Received: from hofr.at ([212.69.189.236]:52041 "EHLO mail.hofr.at"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27026569AbbEHPjl43yjK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 8 May 2015 17:39:41 +0200
Received: by mail.hofr.at (Postfix, from userid 1002)
        id B3B204F8C2E; Fri,  8 May 2015 17:39:43 +0200 (CEST)
Date:   Fri, 8 May 2015 17:39:43 +0200
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Gleb Natapov <gleb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] MIPS: KVM: role back pc in case of EMULATE_FAIL
Message-ID: <20150508153943.GE20045@opentech.at>
References: <1431003091-30161-1-git-send-email-hofrat@osadl.org> <554CCB3B.90504@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <554CCB3B.90504@imgtec.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <hofrat@hofr.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47287
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

On Fri, 08 May 2015, James Hogan wrote:

> On 07/05/15 13:51, Nicholas Mc Guire wrote:
> > Currently if kvm_mips_complete_mmio_load() fails with EMULATE_FAIL it will
> > not role back the pc nor will the caller handle this failure.
> > 
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > ---
> >  arch/mips/kvm/emulate.c |    4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > kvm_mips_complete_mmio_load is called only in arch/mips/kvm/mips.c without
> > checking the return value to signal EMULATE_FAIL:
> >  383         if (vcpu->mmio_needed) {
> >  384                 if (!vcpu->mmio_is_write)
> >  385                         kvm_mips_complete_mmio_load(vcpu, run);
> >  386                 vcpu->mmio_needed = 0;
> >  387         }
> > 
> > so maybe kvm_mips_complete_mmio_load should role back in case of failure 
> > at arch/mips/kvm/emuilate.c:kvm_mips_complete_mmio_load()
> > 2406         if (er == EMULATE_FAIL) {
> > 2408                 return er;
> > 
> > something like the below patch - only based no looking at how EMULATE_FAIL
> > is handled at other locations - not sure if this is appropriate here.
> > 
> > Patch was only compile tested msp71xx_defconfig + CONFIG_KVM=m
> > 
> > Patch is against 4.1-rc2 (localversion-next is -next-20150506)
> > 
> > diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
> > index 2f0fc60..b58596b 100644
> > --- a/arch/mips/kvm/emulate.c
> > +++ b/arch/mips/kvm/emulate.c
> > @@ -2403,8 +2403,10 @@ enum emulation_result kvm_mips_complete_mmio_load(struct kvm_vcpu *vcpu,
> >  	 */
> >  	curr_pc = vcpu->arch.pc;
> >  	er = update_pc(vcpu, vcpu->arch.pending_load_cause);
> > -	if (er == EMULATE_FAIL)
> > +	if (er == EMULATE_FAIL) {
> > +		vcpu->arch.pc = curr_pc;
> 
> If update_pc returns EMULATE_FAIL then vcpu->arch.pc won't have been
> modified, so putting it back to the old value is redundant.
> 
> Actually, curr_pc can be dropped from this function since nothing else
> can go wrong that would cause the PC to need rolling back. Effectively
> kvm_mips_emulate_load() has omitted to update the PC since it'll only
> return to userland to handle the MMIO and get the load data, so by the
> time it gets back to kvm_mips_complete_mmio_load(), it already has
> everything it needs to guarantee success.
>
ok - got it - the comment then was really missleading as it suggested that 
a roleback was actually needed - so in that case the curr_pc; is really an
unused variable and can be tossed out - patch in a minute.

thx!
hofrat 
