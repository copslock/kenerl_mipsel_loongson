Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Feb 2013 17:21:50 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:53623 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825751Ab3BPQVuCH5km (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 16 Feb 2013 17:21:50 +0100
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r1GGLkdP027271
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sat, 16 Feb 2013 11:21:46 -0500
Received: from dhcp-1-237.tlv.redhat.com (dhcp-4-26.tlv.redhat.com [10.35.4.26])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id r1GGLjiB031581;
        Sat, 16 Feb 2013 11:21:46 -0500
Received: by dhcp-1-237.tlv.redhat.com (Postfix, from userid 13519)
        id 5ABA318D479; Sat, 16 Feb 2013 18:21:45 +0200 (IST)
Date:   Sat, 16 Feb 2013 18:21:45 +0200
From:   Gleb Natapov <gleb@redhat.com>
To:     Sanjay Lal <sanjayl@kymasys.com>
Cc:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v2 07/18] KVM/MIPS32: MMU/TLB operations for the Guest.
Message-ID: <20130216162145.GA15961@redhat.com>
References: <1353551656-23579-1-git-send-email-sanjayl@kymasys.com>
 <1353551656-23579-8-git-send-email-sanjayl@kymasys.com>
 <20130206120820.GN23213@redhat.com>
 <69F3ED2A-A9B3-4046-9B40-98125ED5A8FB@kymasys.com>
 <20130215184159.GA16755@redhat.com>
 <15B0FF73-7030-4861-B7BD-834F12CEF5B1@kymasys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15B0FF73-7030-4861-B7BD-834F12CEF5B1@kymasys.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
X-archive-position: 35782
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sat, Feb 16, 2013 at 10:57:22AM -0500, Sanjay Lal wrote:
> 
> On Feb 15, 2013, at 1:41 PM, Gleb Natapov wrote:
> 
> > On Fri, Feb 15, 2013 at 01:19:29PM -0500, Sanjay Lal wrote:
> >> 
> >> On Feb 6, 2013, at 7:08 AM, Gleb Natapov wrote:
> >> 
> >>>> 
> >>>> +static void kvm_mips_map_page(struct kvm *kvm, gfn_t gfn)
> >>>> +{
> >>>> +	pfn_t pfn;
> >>>> +
> >>>> +	if (kvm->arch.guest_pmap[gfn] != KVM_INVALID_PAGE)
> >>>> +		return;
> >>>> +
> >>>> +	pfn =kvm_mips_gfn_to_pfn(kvm, gfn);
> >>> This call should be in srcu read section since it access memory slots which
> >>> are srcu protected. You should test with RCU debug enabled.
> >> 
> >> kvm_mips_gfn_to_pfn just maps to gfn_to_pfn. I don't see an instance where gfn_to_pfn is in a scru read section?
> >> 
> > Where are you looking?  On x86 if vcpu is not in a guest mode it is in
> > srcu read section. The lock is taken immediately after exit and released
> > before entry. This is because x86 access memory slots a lot. Other
> > arches, that do not access memory slots as much, take the lock around
> > each individual access. As far as I see this is the only place in MIPS
> > kvm where this is needed.
> 
> Ah I see what you mean.  I'll wrap the access in a scru read section.
> 
Thanks.

I think there is userspace triggerable panic() in kvm_mips_map_page().
See my original reply. Just making sure you haven't missed it :)

--
			Gleb.
