Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Sep 2010 18:32:20 +0200 (CEST)
Received: (from localhost user: 'ralf' uid#500 fake: STDIN
        (ralf@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S1491046Ab0IXQcP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 24 Sep 2010 18:32:15 +0200
Date:   Fri, 24 Sep 2010 17:32:14 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Sergei Shtylyov <sshtylyov@mvista.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] MIPS: Add a platform hook for swiotlb setup.
Message-ID: <20100924163214.GA29252@linux-mips.org>
References: <1285281496-24696-1-git-send-email-ddaney@caviumnetworks.com>
 <1285281496-24696-9-git-send-email-ddaney@caviumnetworks.com>
 <4C9CCD1B.506@mvista.com>
 <4C9CCE42.3030309@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4C9CCE42.3030309@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-archive-position: 27821
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19473

On Fri, Sep 24, 2010 at 09:13:54AM -0700, David Daney wrote:

> >>+#ifdef CONFIG_SWIOTLB
> >>+ plat_swiotlb_setup();
> >>+#endif
> >
> >We should avoid #ifdef's in function bodies. Why not defile an empty
> >'inline' in the header above if CONFIG_SWIOTLB is not defined?
> >
> 
> Good idea.  I will wait several days and collect any more feedback
> and generate a new patch set.

I'd also wait for a few more days so interested parties outside of the MIPS
world will have a chance to comment.

  Ralf
