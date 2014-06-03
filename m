Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jun 2014 13:18:48 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:44523 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6843095AbaFCLSnVjjrm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Jun 2014 13:18:43 +0200
Date:   Tue, 3 Jun 2014 12:18:43 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Kconfig: microMIPS and SmartMIPS are mutually
 exclusive
In-Reply-To: <20140603093434.GQ17197@linux-mips.org>
Message-ID: <alpine.LFD.2.11.1406031214390.18344@eddie.linux-mips.org>
References: <1401785177-7904-1-git-send-email-markos.chandras@imgtec.com> <20140603093434.GQ17197@linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Tue, 3 Jun 2014, Ralf Baechle wrote:

> > Warning: the 32-bit microMIPS architecture does not support the `smartmips'
> > extension
> > arch/mips/kernel/entry.S:90: Error: unrecognized opcode `mtlhx $24'
> > [...]
> > arch/mips/kernel/entry.S:109: Error: unrecognized opcode `mtlhx $24'
> > 
> > Link: https://dmz-portal.mips.com/bugz/show_bug.cgi?id=1021
> > Reviewed-by: Steven J. Hill <Steven.Hill@imgtec.com>
> > Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> > ---
> >  arch/mips/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > index 2fe8e60..ffde3d6 100644
> > --- a/arch/mips/Kconfig
> > +++ b/arch/mips/Kconfig
> > @@ -2063,7 +2063,7 @@ config ARCH_PHYS_ADDR_T_64BIT
> >         def_bool 64BIT_PHYS_ADDR
> >  
> >  config CPU_HAS_SMARTMIPS
> > -	depends on SYS_SUPPORTS_SMARTMIPS
> > +	depends on SYS_SUPPORTS_SMARTMIPS && !CPU_MICROMIPS
> >  	bool "Support for the SmartMIPS ASE"
> >  	help
> >  	  SmartMIPS is a extension of the MIPS32 architecture aimed at
> 
> >From a user's perspective that's a bit quirky; a user has to first
> disable CPU_MICROMIPS before he can enable CPU_HAS_SMARTMIPS.  So I
> think this should become a choice statement.

 Do we need this CPU_HAS_SMARTMIPS setting at all?  Can't we just 
save/restore this SmartMIPS ACX register on context switches where 
available (straightforward to detect at the run time) and have the 
relevant pieces of code excluded (#ifdef-ed out or suchlike) on 
non-supported configurations such as microMIPS or MIPS64?

  Maciej
