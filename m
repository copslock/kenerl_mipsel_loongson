Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 May 2013 19:34:25 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:60229 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827528Ab3EORcB5MqVQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 May 2013 19:32:01 +0200
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4FHUgqO032445
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Wed, 15 May 2013 13:30:42 -0400
Received: from dhcp-1-237.tlv.redhat.com (dhcp-4-26.tlv.redhat.com [10.35.4.26])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id r4FHUeOR014940;
        Wed, 15 May 2013 13:30:40 -0400
Received: by dhcp-1-237.tlv.redhat.com (Postfix, from userid 13519)
        id DEF2F1336CE; Wed, 15 May 2013 20:30:39 +0300 (IDT)
Date:   Wed, 15 May 2013 20:30:39 +0300
From:   Gleb Natapov <gleb@redhat.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Sanjay Lal <sanjayl@kymasys.com>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, mtosatti@redhat.com, ralf@linux-mips.org
Subject: Re: [PATCH 2/2] KVM/MIPS32: Wrap calls to gfn_to_pfn() with
 srcu_read_lock/unlock()
Message-ID: <20130515173039.GC24814@redhat.com>
References: <n>
 <1368476500-20031-1-git-send-email-sanjayl@kymasys.com>
 <1368476500-20031-3-git-send-email-sanjayl@kymasys.com>
 <20130514092705.GD20995@redhat.com>
 <63B7D172-E75E-4AB4-8515-9A18360B66A2@kymasys.com>
 <5193BDC0.6090103@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5193BDC0.6090103@gmail.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Return-Path: <gleb@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36408
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

On Wed, May 15, 2013 at 09:54:24AM -0700, David Daney wrote:
> On 05/15/2013 08:54 AM, Sanjay Lal wrote:
> >
> >On May 14, 2013, at 2:27 AM, Gleb Natapov wrote:
> >
> >>>
> >>>
> >>>+EXPORT_SYMBOL(min_low_pfn);     /* defined by bootmem.c, but not exported by generic code */
> >>>+
> >>What you need this for? It is not used anywhere in this patch and by
> >>mips/kvm code in general.
> >
> >I did some digging around myself, since the linker keeps complaining that it can't find min_low_pfn when compiling the KVM module.  It seems that it is indirectly pulled in by the cache management functions.
> >
> 
> If it is really needed, then the export should probably be done at
> the site of the min_low_pfn definition, not in some random
> architecture file.
> 
Definitely. We cannot snick it here like that. Please drop it from this
patch.

> An alternative is to fix the cache management functions so they
> don't require the export.
> 
> David Daney
> 
> >
> >Regards
> >Sanjay
> >
> >
> >
> >
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
			Gleb.
