Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Mar 2015 19:22:16 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:35273 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007049AbbCDSWNgCn5Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Mar 2015 19:22:13 +0100
Received: from localhost (unknown [104.135.0.216])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 03A63A5B;
        Wed,  4 Mar 2015 18:22:06 +0000 (UTC)
Date:   Wed, 4 Mar 2015 10:22:06 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sanjay Lal <sanjayl@kymasys.com>,
        Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 3.14 58/73] KVM: MIPS: Dont leak FPU/DSP to guest
Message-ID: <20150304182206.GG13218@kroah.com>
References: <20150304055332.344462103@linuxfoundation.org>
 <20150304055342.084533773@linuxfoundation.org>
 <20150304081040.GA28401@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150304081040.GA28401@jhogan-linux.le.imgtec.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46147
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

On Wed, Mar 04, 2015 at 08:10:40AM +0000, James Hogan wrote:
> Hi Greg,
> 
> On Tue, Mar 03, 2015 at 10:13:26PM -0800, Greg Kroah-Hartman wrote:
> > 3.14-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: James Hogan <james.hogan@imgtec.com>
> > 
> > commit f798217dfd038af981a18bbe4bc57027a08bb182 upstream.
> > 
> > The FPU and DSP are enabled via the CP0 Status CU1 and MX bits by
> > kvm_mips_set_c0_status() on a guest exit, presumably in case there is
> > active state that needs saving if pre-emption occurs. However neither of
> > these bits are cleared again when returning to the guest.
> > 
> > This effectively gives the guest access to the FPU/DSP hardware after
> > the first guest exit even though it is not aware of its presence,
> > allowing FP instructions in guest user code to intermittently actually
> > execute instead of trapping into the guest OS for emulation. It will
> > then read & manipulate the hardware FP registers which technically
> > belong to the user process (e.g. QEMU), or are stale from another user
> > process. It can also crash the guest OS by causing an FP exception, for
> > which a guest exception handler won't have been registered.
> > 
> > First lets save and disable the FPU (and MSA) state with lose_fpu(1)
> > before entering the guest. This simplifies the problem, especially for
> > when guest FPU/MSA support is added in the future, and prevents FR=1 FPU
> > state being live when the FR bit gets cleared for the guest, which
> > according to the architecture causes the contents of the FPU and vector
> > registers to become UNPREDICTABLE.
> > 
> > We can then safely remove the enabling of the FPU in
> > kvm_mips_set_c0_status(), since there should never be any active FPU or
> > MSA state to save at pre-emption, which should plug the FPU leak.
> > 
> > DSP state is always live rather than being lazily restored, so for that
> > it is simpler to just clear the MX bit again when re-entering the guest.
> > 
> > Signed-off-by: James Hogan <james.hogan@imgtec.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Sanjay Lal <sanjayl@kymasys.com>
> > Cc: Gleb Natapov <gleb@kernel.org>
> > Cc: kvm@vger.kernel.org
> > Cc: linux-mips@linux-mips.org
> > Cc: <stable@vger.kernel.org> # v3.10+: 044f0f03eca0: MIPS: KVM: Deliver guest interrupts
> 
> The original 3.10 and 3.12/3.14 backports had this added:
> Cc: <stable@vger.kernel.org> # v3.10+: 3ce465e04bfd: MIPS: Export FP functions used by lose_fpu(1) for KVM                                         
> Which I can't see included in the v3.10 stable queue or branch. It fixes
> a build error with MIPS malta_kvm_defconfig (MIPS=y, KVM=m) after this
> patch is applied.
> 
> Same applies to the 3.14 queue too I think.

Odd, I remember having problems in this area and thought I had queued
this up.  It's now applied to both trees, thanks.

greg k-h
