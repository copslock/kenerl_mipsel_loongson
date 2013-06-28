Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Jun 2013 00:58:54 +0200 (CEST)
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:55859 "EHLO
        filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827443Ab3F1W6wgDX-8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 29 Jun 2013 00:58:52 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri1.pp.htv.fi (Postfix) with ESMTP id F112D21B89C;
        Sat, 29 Jun 2013 01:58:50 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
        with ESMTP id Jvll2CRSzqmy; Sat, 29 Jun 2013 01:58:46 +0300 (EEST)
Received: from musicnaut.iki.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp5.welho.com (Postfix) with SMTP id 1137E5BC002;
        Sat, 29 Jun 2013 01:58:45 +0300 (EEST)
Received: by musicnaut.iki.fi (sSMTP sendmail emulation); Sat, 29 Jun 2013 01:58:42 +0300
Date:   Sat, 29 Jun 2013 01:58:42 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2 1/2] MIPS: cavium-octeon: cvmx-helper-board: print
 unknown board warning only once
Message-ID: <20130628225842.GB3923@blackmetal.musicnaut.iki.fi>
References: <1372023524-17333-1-git-send-email-aaro.koskinen@iki.fi>
 <20130626184727.GJ7171@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130626184727.GJ7171@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37217
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

On Wed, Jun 26, 2013 at 08:47:27PM +0200, Ralf Baechle wrote:
> On Mon, Jun 24, 2013 at 12:38:43AM +0300, Aaro Koskinen wrote:
> > When booting a new board for the first time, the console is flooded with
> > "Unknown board" messages. This is not really helpful. Board type is not
> > going to change after the boot, so it's sufficient to print the warning
> > only once.
> > 
> > Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > ---
> > 
> > 	v2: Adjust indentation.
> > 
> >  arch/mips/cavium-octeon/executive/cvmx-helper-board.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
> > index 7c64977..9838c0e 100644
> > --- a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
> > +++ b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
> > @@ -31,6 +31,8 @@
> >   * network ports from the rest of the cvmx-helper files.
> >   */
> >  
> > +#include <linux/printk.h>
> > +
> >  #include <asm/octeon/octeon.h>
> >  #include <asm/octeon/cvmx-bootinfo.h>
> >  
> > @@ -184,9 +186,8 @@ int cvmx_helper_board_get_mii_address(int ipd_port)
> >  	}
> >  
> >  	/* Some unknown board. Somebody forgot to update this function... */
> > -	cvmx_dprintf
> > -	    ("cvmx_helper_board_get_mii_address: Unknown board type %d\n",
> > -	     cvmx_sysinfo_get()->board_type);
> > +	pr_warn_once("%s: Unknown board type %d\n", __func__,
> > +		     cvmx_sysinfo_get()->board_type);
> 
> David,
> 
> cvmx_dprintf() is a function frequently invoked from the OCTEON code.
> I'm wondering.  Right now it's defined as:
> 
> #if CVMX_ENABLE_DEBUG_PRINTS
> #define cvmx_dprintf        printk
> #else
> #define cvmx_dprintf(...)   {}
> #endif
> 
> That is, there isn't even a severity level being used and the define
> CVMX_ENABLE_DEBUG_PRINTS to control cvmx_dprintf is way to similar to
> what CONFIG_DYNAMIC_DEBUG rsp. a simple #define DEBUG do.  And the
> no-debug variant of cvmx_dprintf isn't correct in presence of side
> effects of arguments.
> 
> So I propose to just replace cvmx_dprintf with pr_debug.  What do you
> think?

There are logs with prefix "WARNING:" and "ERROR:". So those could be
converted to pr_warn/err, and remaining to pr_debug.

A.
