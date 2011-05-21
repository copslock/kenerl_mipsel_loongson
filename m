Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 May 2011 09:42:31 +0200 (CEST)
Received: from ozlabs.org ([203.10.76.45]:49237 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491006Ab1EUHmF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 21 May 2011 09:42:05 +0200
Received: by ozlabs.org (Postfix, from userid 1007)
        id E3179B71A7; Sat, 21 May 2011 17:41:58 +1000 (EST)
Date:   Sat, 21 May 2011 16:33:45 +1000
From:   David Gibson <david@gibson.dropbear.id.au>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 1/6] of: Allow scripts/dtc/libfdt to be used from
 kernel code
Message-ID: <20110521063345.GB14828@yookeroo.fritz.box>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
        David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, devicetree-discuss@lists.ozlabs.org,
        grant.likely@secretlab.ca, linux-kernel@vger.kernel.org
References: <1305930343-31259-1-git-send-email-ddaney@caviumnetworks.com>
 <1305930343-31259-2-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1305930343-31259-2-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dgibson@ozlabs.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30121
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david@gibson.dropbear.id.au
Precedence: bulk
X-list: linux-mips

On Fri, May 20, 2011 at 03:25:38PM -0700, David Daney wrote:
> To use it you need to do this in your Kconfig:
> 
> 	select LIBFDT
> 
> And in the Makefile of the code using libfdt something like:
> 
> ccflags-y := -include linux/libfdt_env.h -I$(src)/../../../scripts/dtc/libfdt
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
>  drivers/of/Kconfig          |    3 +++
>  drivers/of/Makefile         |    2 ++
>  drivers/of/libfdt/Makefile  |    3 +++
>  drivers/of/libfdt/fdt.c     |    2 ++
>  drivers/of/libfdt/fdt_ro.c  |    2 ++
>  drivers/of/libfdt/fdt_wip.c |    2 ++

No fdt_sw.c or fdt_rw.c?

>  include/linux/libfdt.h      |    8 ++++++++
>  include/linux/libfdt_env.h  |   13 +++++++++++++
>  8 files changed, 35 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/of/libfdt/Makefile
>  create mode 100644 drivers/of/libfdt/fdt.c
>  create mode 100644 drivers/of/libfdt/fdt_ro.c

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
