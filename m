Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 May 2013 07:53:35 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:53504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6815753Ab3EPFx3kkVY2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 May 2013 07:53:29 +0200
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4G5rG6C018817
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 16 May 2013 01:53:16 -0400
Received: from dhcp-1-237.tlv.redhat.com (dhcp-4-26.tlv.redhat.com [10.35.4.26])
        by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id r4G5rFZk017523;
        Thu, 16 May 2013 01:53:16 -0400
Received: by dhcp-1-237.tlv.redhat.com (Postfix, from userid 13519)
        id DD18B18D3DE; Thu, 16 May 2013 08:53:14 +0300 (IDT)
Date:   Thu, 16 May 2013 08:53:14 +0300
From:   Gleb Natapov <gleb@redhat.com>
To:     Sanjay Lal <sanjayl@kymasys.com>
Cc:     David Daney <ddaney.cavm@gmail.com>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, Marcelo Tosatti <mtosatti@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Tony Luck <tony.luck@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 2/2] KVM/MIPS32: Wrap calls to gfn_to_pfn() with
 srcu_read_lock/unlock()
Message-ID: <20130516055314.GD26453@redhat.com>
References: <n>
 <1368476500-20031-1-git-send-email-sanjayl@kymasys.com>
 <1368476500-20031-3-git-send-email-sanjayl@kymasys.com>
 <20130514092705.GD20995@redhat.com>
 <63B7D172-E75E-4AB4-8515-9A18360B66A2@kymasys.com>
 <5193BDC0.6090103@gmail.com>
 <20130515173039.GC24814@redhat.com>
 <057877F0-D213-4D46-963D-9600735844A4@kymasys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <057877F0-D213-4D46-963D-9600735844A4@kymasys.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Return-Path: <gleb@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36416
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

On Wed, May 15, 2013 at 11:36:02AM -0700, Sanjay Lal wrote:
> 
> On May 15, 2013, at 10:30 AM, Gleb Natapov wrote:
> 
> > On Wed, May 15, 2013 at 09:54:24AM -0700, David Daney wrote:
> >> On 05/15/2013 08:54 AM, Sanjay Lal wrote:
> >>> 
> >>> On May 14, 2013, at 2:27 AM, Gleb Natapov wrote:
> >>> 
> >>>>> 
> >>>>> 
> >>>>> +EXPORT_SYMBOL(min_low_pfn);     /* defined by bootmem.c, but not exported by generic code */
> >>>>> +
> >>>> What you need this for? It is not used anywhere in this patch and by
> >>>> mips/kvm code in general.
> >>> 
> >>> I did some digging around myself, since the linker keeps complaining that it can't find min_low_pfn when compiling the KVM module.  It seems that it is indirectly pulled in by the cache management functions.
> >>> 
> >> 
> >> If it is really needed, then the export should probably be done at
> >> the site of the min_low_pfn definition, not in some random
> >> architecture file.
> >> 
> > Definitely. We cannot snick it here like that. Please drop it from this
> > patch.
> > 
> 
> I did export min_low_pfn where it was defined (in .../mm/bootmem.c) as part of the original patch set. It conflicted with the ia64/metag ports.  min_low_pfn is exported in arch/ia64/kernel/ia64_ksyms.c and in arch/metag/kernel/metag_ksyms.c.
> 
> There was some chatter about this when the KVM/MIPS code ended up in linux-next.  From what I can gather, the maintainers for the other architectures agreed that exporting this symbol in bootmem.c was fine and should flow from the MIPS tree.  I'll do that as part of v2 of the patch set.
> 
Make it a separate patch and send it to linux-kernel and
linux-mm@kvack.org and affected arch maintainers. Or you can add export
to arch/mips/kernel/mips_ksyms.c and ask Ralf to take it. I can take it
via kvm tree with Ralf's ack too. In the commit message have a good
explanation why it is needed please.

--
			Gleb.
