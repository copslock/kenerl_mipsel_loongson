Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Feb 2011 00:44:43 +0100 (CET)
Received: from ozlabs.org ([203.10.76.45]:44976 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491836Ab1BXXoU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 25 Feb 2011 00:44:20 +0100
Received: by ozlabs.org (Postfix, from userid 1007)
        id 7CFE1B711C; Fri, 25 Feb 2011 10:44:15 +1100 (EST)
Date:   Fri, 25 Feb 2011 10:19:23 +1100
From:   David Gibson <david@gibson.dropbear.id.au>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 02/10] MIPS: Octeon: Add device tree source files.
Message-ID: <20110224231923.GB18233@yookeroo>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
        David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, devicetree-discuss@lists.ozlabs.org,
        grant.likely@secretlab.ca, linux-kernel@vger.kernel.org
References: <1298408274-20856-1-git-send-email-ddaney@caviumnetworks.com>
 <1298408274-20856-3-git-send-email-ddaney@caviumnetworks.com>
 <20110223000759.GA26300@yookeroo>
 <4D653CF1.30009@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D653CF1.30009@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <dgibson@ozlabs.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29287
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david@gibson.dropbear.id.au
Precedence: bulk
X-list: linux-mips

On Wed, Feb 23, 2011 at 08:59:29AM -0800, David Daney wrote:
> On 02/22/2011 04:07 PM, David Gibson wrote:
> >On Tue, Feb 22, 2011 at 12:57:46PM -0800, David Daney wrote:
> >>Signed-off-by: David Daney<ddaney@caviumnetworks.com>
> >>---
> >>  arch/mips/cavium-octeon/.gitignore      |    2 +
> >>  arch/mips/cavium-octeon/Makefile        |   13 ++
> >>  arch/mips/cavium-octeon/octeon_3xxx.dts |  314 +++++++++++++++++++++++++++++++
> >>  arch/mips/cavium-octeon/octeon_68xx.dts |   99 ++++++++++
> >>  4 files changed, 428 insertions(+), 0 deletions(-)
> >>  create mode 100644 arch/mips/cavium-octeon/.gitignore
> >>  create mode 100644 arch/mips/cavium-octeon/octeon_3xxx.dts
> >>  create mode 100644 arch/mips/cavium-octeon/octeon_68xx.dts
> >>
> [...]
> 
> >>+    };
> >>+  };
> >
> >Uh.. where are the CPUs?
> >
> 
> The number and type of CPUs can be (and is) probed.  There is an
> existing mechanism for the bootloader to communicate which CPUs
> should be used.

Hrm, ok.

Grant,

We've seen this now on both MIPS and ARM - dts files with no cpus, on
the grounds that those can be runtime probed.  I guess it makes sense,
although a dts without cpus looks very, very odd to me.  What are your
thoughts on this?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
