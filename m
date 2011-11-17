Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Nov 2011 19:55:42 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:52113 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1904052Ab1KQSzi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 Nov 2011 19:55:38 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pAHItTBi018081;
        Thu, 17 Nov 2011 18:55:29 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pAHItRoS018075;
        Thu, 17 Nov 2011 18:55:27 GMT
Date:   Thu, 17 Nov 2011 18:55:27 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] MIPS: Octeon: Unconditionally build
 __cvmx_helper_errata_qlm_disable_2nd_order_cdr
Message-ID: <20111117185527.GH26457@linux-mips.org>
References: <1321474228-13726-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1321474228-13726-1-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31743
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14695

On Wed, Nov 16, 2011 at 12:10:28PM -0800, David Daney wrote:

> From: David Daney <david.daney@cavium.com>
> 
> It is needed in !OCTEON_ETHERNET and !PCI too.  Since most people will
> probably have both of these defined in any real configuration, there
> is not really any size bloat from doing this.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  arch/mips/cavium-octeon/Kconfig            |    4 ----
>  arch/mips/cavium-octeon/executive/Makefile |    2 +-
>  2 files changed, 1 insertions(+), 5 deletions(-)

Thanks, folded into "MIPS: Octeon: Move some Ethernet support files out of
staging."

  Ralf
