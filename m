Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 May 2013 08:02:31 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:54574 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6818472Ab3ETGC2L9-9H (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 20 May 2013 08:02:28 +0200
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4K62G3i024976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 20 May 2013 02:02:16 -0400
Received: from dhcp-1-237.tlv.redhat.com (dhcp-4-26.tlv.redhat.com [10.35.4.26])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id r4K62EbQ013581;
        Mon, 20 May 2013 02:02:14 -0400
Received: by dhcp-1-237.tlv.redhat.com (Postfix, from userid 13519)
        id 9AE1A18D3DE; Mon, 20 May 2013 09:02:13 +0300 (IDT)
Date:   Mon, 20 May 2013 09:02:13 +0300
From:   Gleb Natapov <gleb@redhat.com>
To:     David Daney <david.s.daney@gmail.com>
Cc:     Sanjay Lal <sanjayl@kymasys.com>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org, ralf@linux-mips.org, mtosatti@redhat.com,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 4/4] KVM/MIPS32: Bring in patch from David Daney with new
 64 bit compatible ABI.
Message-ID: <20130520060213.GN4725@redhat.com>
References: <n>
 <1368885266-8619-1-git-send-email-sanjayl@kymasys.com>
 <1368885266-8619-5-git-send-email-sanjayl@kymasys.com>
 <20130519141712.GL4725@redhat.com>
 <5199416D.1010200@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5199416D.1010200@gmail.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Return-Path: <gleb@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36480
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gleb@redhat.com
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

On Sun, May 19, 2013 at 02:17:33PM -0700, David Daney wrote:
> On 05/19/2013 07:17 AM, Gleb Natapov wrote:
> >On Sat, May 18, 2013 at 06:54:26AM -0700, Sanjay Lal wrote:
> >>From: David Daney <david.daney@cavium.com>
> >>
> >>There are several parts to this:
> >>
> >>o All registers are 64-bits wide, 32-bit guests use the least
> >>   significant portion of the register storage fields.
> >>
> >>o FPU register formats are defined.
> >>
> >>o CP0 Registers are manipulated via the KVM_GET_MSRS/KVM_SET_MSRS
> >>   mechanism.
> >>
> >>The vcpu_ioctl_get_regs and vcpu_ioctl_set_regs function pointers
> >>become unused so they were removed.
> >>
> >>Some IOCTL functions were moved to kvm_trap_emul because the
> >>implementations are only for that flavor of KVM host.  In the future, if
> >>hardware based virtualization is added, they can be hidden behind
> >>function pointers as appropriate.
> >>
> >David, can you please divide this one big patch to smaller patches
> >with each one having only one of the changes listed above?
> 
> Expanding the registers to 64 bits changes only four lines. Defining
> the FPU registers is an additional seven lines.  The rest really has
> to be an atomic change.
> 
It does not matter. If you have 10 logically unrelated one-liners (even
if they are all part of one big goal) I expect to get 10 patches.

> The point here is that we change the ABI.  Any userspace tools have
> to change too.  So is it better to have a multi-part patch set where
> the interface is unusable in the intermediate patches?  Or is it
> preferable to do an 'atomic' switch?
Are "The vcpu_ioctl_get_regs and vcpu_ioctl_set_regs function pointers
become unused so they were removed." and "Some IOCTL functions were
moved to kvm_trap_emul..." also changes ABI? Unlikely, and then I expect
to have two series: first one only have patches that change ABI and
another rearrange the code. First one will go into 3.10 second in 3.11.

> 
> It wasn't out of laziness that I chose to do it this way, it was
> because I thought it was cleaner.
> 
> So to directly answer your question:  I prefer not to split this up,
> and would want to have a better reason than an orthodox
> interpretation of SubmittingPatches sec. 3.
> 
It may seams orthodox interpretation if you are on a sender side, from
a reviewer point of view it is the interpretation that saves a lot of
time. I did looked into the patch before asking for split, not just
asked for it based on the description. And, in addition, in this case,
I want to have minimal set of changes that will go into 3.10.

--
			Gleb.
