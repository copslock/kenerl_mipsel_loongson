Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2016 12:33:10 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:40528 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993049AbcKJLdD4Thga (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Nov 2016 12:33:03 +0100
Received: from localhost (pes75-3-78-192-101-3.fbxo.proxad.net [78.192.101.3])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 24513720;
        Thu, 10 Nov 2016 11:32:56 +0000 (UTC)
Date:   Thu, 10 Nov 2016 07:08:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Jiri Slaby <jslaby@suse.cz>, stable@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org
Subject: Re: [BACKPORT PATCH 3.10..3.16] KVM: MIPS: Drop other CPU ASIDs on
 guest MMU changes
Message-ID: <20161110060843.GA28639@kroah.com>
References: <20161109144624.16683-1-james.hogan@imgtec.com>
 <6066667d-e62d-bfec-ca3e-f16f8bef912d@suse.cz>
 <20161109220043.GA7075@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20161109220043.GA7075@jhogan-linux.le.imgtec.org>
User-Agent: Mutt/1.7.1 (2016-10-04)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55769
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

On Wed, Nov 09, 2016 at 10:00:43PM +0000, James Hogan wrote:
> On Wed, Nov 09, 2016 at 10:22:01PM +0100, Jiri Slaby wrote:
> > On 11/09/2016, 03:46 PM, James Hogan wrote:
> > > commit 91e4f1b6073dd680d86cdb7e42d7cccca9db39d8 upstream.
> > > 
> > > When a guest TLB entry is replaced by TLBWI or TLBWR, we only invalidate
> > > TLB entries on the local CPU. This doesn't work correctly on an SMP host
> > > when the guest is migrated to a different physical CPU, as it could pick
> > > up stale TLB mappings from the last time the vCPU ran on that physical
> > > CPU.
> > > 
> > > Therefore invalidate both user and kernel host ASIDs on other CPUs,
> > > which will cause new ASIDs to be generated when it next runs on those
> > > CPUs.
> > > 
> > > We're careful only to do this if the TLB entry was already valid, and
> > > only for the kernel ASID where the virtual address it mapped is outside
> > > of the guest user address range.
> > > 
> > > Signed-off-by: James Hogan <james.hogan@imgtec.com>
> > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > Cc: "Radim Krčmář" <rkrcmar@redhat.com>
> > > Cc: Ralf Baechle <ralf@linux-mips.org>
> > > Cc: linux-mips@linux-mips.org
> > > Cc: kvm@vger.kernel.org
> > > Cc: <stable@vger.kernel.org> # 3.10.x-
> > > Cc: Jiri Slaby <jslaby@suse.cz>
> > > [james.hogan@imgtec.com: Backport to 3.10..3.16]
> > > Signed-off-by: James Hogan <james.hogan@imgtec.com>
> > > ---
> > > Unfortunately the original commit went in to v3.12.65 as commit
> > > 168e5ebbd63e, without fixing up the references to tlb_lo[0/1] to
> > > tlb_lo0/1 which broke the MIPS KVM build, and I didn't twig that I
> > > already had a correct backport outstanding (sorry!). That commit should
> > > be reverted before applying this backport to 3.12.
> > 
> > Thanks, reverted and applied. I wonder the builders didn't break given 4
> > mips configurations are tested. I indeed could reproduce locally.
> 
> I'm guessing malta_kvm_defconfig isn't one of those defconfigs (and the
> imgtec buildbots don't yet test stable branches). Which builders do you
> use?

I use 0-day for these types of things, and it is not showing up any
errors for the 4.4-stable kernel.  Can you get these configurations
added to it so that we can ensure it doesn't regress?

thanks,

greg k-h
