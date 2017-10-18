Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Oct 2017 07:16:40 +0200 (CEST)
Received: from kirsty.vergenet.net ([202.4.237.240]:37355 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991957AbdJRFQaNk-31 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Oct 2017 07:16:30 +0200
Received: from penelope.horms.nl (52D9BC73.cm-11-1c.dynamic.ziggo.nl [82.217.188.115])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 364D625B810;
        Wed, 18 Oct 2017 16:16:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1508303783; bh=1fqwsosXMVEzZlvyCmzMhHQAFIYHRujPM+7e9Mtww8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UXmclyXzLCY3xsqqIH1MrvG5LAtb0ebAd63Ks0hnidOZdqU/6YFWOjwQapYHDok34
         BdZrsSnR2MS/Do35fDdbEBXmeh1KFTQSrhYWmk2mGjOh+JkhBKEIbvWTSfoRaQTqkU
         hS0eNago58ywD0Mrs1gOzZSRPgnLNT7zjr+QYNc4=
Received: by penelope.horms.nl (Postfix, from userid 7100)
        id EBDECE20907; Wed, 18 Oct 2017 07:16:03 +0200 (CEST)
Date:   Wed, 18 Oct 2017 07:16:03 +0200
From:   Simon Horman <horms@verge.net.au>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org,
        kexec@lists.infradead.org
Subject: Re: [PATCH 1/4] kexec-tools: mips: Merge adjacent memory ranges.
Message-ID: <20171018051603.f7o2lgr7tiux5r6b@verge.net.au>
References: <20171012210228.7353-1-david.daney@cavium.com>
 <20171012210228.7353-2-david.daney@cavium.com>
 <20171016065313.g5va4jel5si2udbm@verge.net.au>
 <8a440fe8-0633-32e1-d142-44765b41c47b@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a440fe8-0633-32e1-d142-44765b41c47b@caviumnetworks.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <horms@verge.net.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60437
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: horms@verge.net.au
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

On Mon, Oct 16, 2017 at 09:13:30AM -0700, David Daney wrote:
> On 10/15/2017 11:53 PM, Simon Horman wrote:
> > On Thu, Oct 12, 2017 at 02:02:25PM -0700, David Daney wrote:
> > > Some kernel versions running on MIPS split the System RAM memory
> > > regions reported in /proc/iomem.  This may cause loading of the kexec
> > > kernel to fail if it crosses one of the splits.
> > > 
> > > Fix by merging adjacent memory ranges that have the same type.
> > > 
> > > Signed-off-by: David Daney <david.daney@cavium.com>
> > > ---
> > >   kexec/arch/mips/kexec-mips.c | 14 ++++++++++----
> > >   1 file changed, 10 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/kexec/arch/mips/kexec-mips.c b/kexec/arch/mips/kexec-mips.c
> > > index 2e5b700..415c2ed 100644
> > > --- a/kexec/arch/mips/kexec-mips.c
> > > +++ b/kexec/arch/mips/kexec-mips.c
> > > @@ -60,10 +60,16 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
> > >   		} else {
> > >   			continue;
> > >   		}
> > > -		memory_range[memory_ranges].start = start;
> > > -		memory_range[memory_ranges].end = end;
> > > -		memory_range[memory_ranges].type = type;
> > > -		memory_ranges++;
> > > +		if (memory_ranges > 0 &&
> > 
> > It seems that this will never merge the first memory range
> > with subsequent ones. Is that intentional?
> 
> 
> With the first range (index 0), no other range yet exists to merge with.  We
> can only test for merging with the second and subsequent ranges (indices 1
> and above).  To do otherwise would cause us to read things from *before* the
> beginning of the array ...

Yes, of course. I see that now.

I've applied this patch.

> > 
> > 
> > > +		    memory_range[memory_ranges - 1].end == start &&
> 
> ... here.
> 
> > > +		    memory_range[memory_ranges - 1].type == type) {
> > > +			memory_range[memory_ranges - 1].end = end;
> > > +		} else {
> > > +			memory_range[memory_ranges].start = start;
> > > +			memory_range[memory_ranges].end = end;
> > > +			memory_range[memory_ranges].type = type;
> > > +			memory_ranges++;
> > > +		}
> > >   	}
> > >   	fclose(fp);
> > >   	*range = memory_range;
> > > -- 
> > > 2.9.5
> > > 
> > > 
> > > _______________________________________________
> > > kexec mailing list
> > > kexec@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/kexec
> > > 
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 
