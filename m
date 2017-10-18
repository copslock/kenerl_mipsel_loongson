Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Oct 2017 07:17:21 +0200 (CEST)
Received: from kirsty.vergenet.net ([202.4.237.240]:37364 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991672AbdJRFRNoz5J1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Oct 2017 07:17:13 +0200
Received: from penelope.horms.nl (52D9BC73.cm-11-1c.dynamic.ziggo.nl [82.217.188.115])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 09B9C25B810;
        Wed, 18 Oct 2017 16:17:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1508303831; bh=+Mp4V1a4Gr5Sigh1Yt3s+/AyZDHfuxBmC6VnYb8l9l0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QE5A6TPufVOzIV13pEAax/mqkdOQFz+2/xEeqF7zG4UH2yHqqem4P382h27ooN3Ox
         wR89hfYmXDBC3iYsaf4fFJApqxjXD49XB3DE8iaaWHEz+XqHHO+OjqIg0RzbX46o0x
         iI0qDj8X/XVksAWJQ17ySKq9qzm1Fiv2AV3O07YA=
Received: by penelope.horms.nl (Postfix, from userid 7100)
        id 69CC0E20907; Wed, 18 Oct 2017 07:16:53 +0200 (CEST)
Date:   Wed, 18 Oct 2017 07:16:53 +0200
From:   Simon Horman <horms@verge.net.au>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     David Daney <david.daney@cavium.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kexec@lists.infradead.org
Subject: Re: [PATCH 3/4] kexec-tools: mips: Use proper page_offset for OCTEON
 CPUs.
Message-ID: <20171018051653.anvogntf3ijw7fta@verge.net.au>
References: <20171012210228.7353-1-david.daney@cavium.com>
 <20171012210228.7353-4-david.daney@cavium.com>
 <20171016065636.wxm3nrzq7lkn4lw6@verge.net.au>
 <901800ab-a86a-6513-3bdd-2d2567105ac4@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <901800ab-a86a-6513-3bdd-2d2567105ac4@caviumnetworks.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <horms@verge.net.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60438
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

On Mon, Oct 16, 2017 at 09:05:22AM -0700, David Daney wrote:
> On 10/15/2017 11:56 PM, Simon Horman wrote:
> > On Thu, Oct 12, 2017 at 02:02:27PM -0700, David Daney wrote:
> > > The OCTEON family of MIPS64 CPUs uses a PAGE_OFFSET of
> > > 0x8000000000000000ULL, which is differs from other CPUs.
> > > 
> > > Scan /proc/cpuinfo to see if the current system is "Octeon", if so,
> > > patch the page_offset so that usable kdump core files are produced.
> > > 
> > > Signed-off-by: David Daney <david.daney@cavium.com>
> > 
> > Is it possible to read this offset from the system rather than
> > checking for an Octeon CPU? It seems that such an approach, if possible,
> > would be somewhat more general.
> > 
> 
> Before implementing this scanning of /proc/cpuinfo, I thought long and hard
> about this, and couldn't think of how the PAGE_OFFSET could be derived from
> information available in userspace.
> 
> Ralf (MIPS maintainer) may have an idea, but these address bits don't show
> up in /proc/kallsyms or any other file in /proc or /sys that I am aware of.

Thanks for the explanation. I've applied this patch pending any further
progress in this area.
