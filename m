Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2003 18:22:08 +0100 (BST)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:60850 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225425AbTIRRWE>;
	Thu, 18 Sep 2003 18:22:04 +0100
Received: from drow by nevyn.them.org with local (Exim 4.22 #1 (Debian))
	id 1A02Tj-00062f-ME; Thu, 18 Sep 2003 13:22:03 -0400
Date: Thu, 18 Sep 2003 13:22:03 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: ddb5477 fixes for 2.6
Message-ID: <20030918172203.GA23194@nevyn.them.org>
References: <20030918170642.GA22753@nevyn.them.org> <Pine.GSO.3.96.1030918191604.20533C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030918191604.20533C-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3211
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 18, 2003 at 07:19:21PM +0200, Maciej W. Rozycki wrote:
> On Thu, 18 Sep 2003, Daniel Jacobowitz wrote:
> 
> > >  Is it OK for other PCI systems?
> > 
> > Yes, I think so.  Those two functions seem to have migrated in from
> > pci-hplj.c; they can't possibly compile, since they use constants only
> > defined in that file.
> 
>  Then the snippet should probably get removed altogether.
> 
> > >  Why do you want these suffixes?  They don't work for assembly sources.
> > 
> > Because otherwise uses of XKPHYS in a 32-bit kernel generate noisy
> > warnings.  I don't remember where it was offhand.  Wrap it in
> > __ASSEMBLY__ if you like.
> 
>  Hmm, but is there any use for XKPHYS, etc. in a 32-bit kernel at all? 
> The address cannot effectively be used anyway. 

That patch is a total hack/slash job.  You're probably right on both
counts.

Take a look at __ioremap_mode which probably needs some #ifdefs for
32-bit kernels.  It uses cpu_has_64bit_addresses, which means at
runtime it's OK, but we get a lot of warnings.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
