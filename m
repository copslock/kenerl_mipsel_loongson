Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Sep 2002 17:20:30 +0200 (CEST)
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:3761 "EHLO
	rwcrmhc53.attbi.com") by linux-mips.org with ESMTP
	id <S1123795AbSI2PUa>; Sun, 29 Sep 2002 17:20:30 +0200
Received: from lucon.org ([12.234.88.146]) by rwcrmhc53.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020929152022.QUEC15492.rwcrmhc53.attbi.com@lucon.org>;
          Sun, 29 Sep 2002 15:20:22 +0000
Received: by lucon.org (Postfix, from userid 1000)
	id 1889A2C59B; Sun, 29 Sep 2002 08:20:21 -0700 (PDT)
Date: Sun, 29 Sep 2002 08:20:21 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: binutils@sources.redhat.com, linux-mips@linux-mips.org
Subject: Re: The current binutils in CVS is broken on Linux/mips
Message-ID: <20020929082021.A11843@lucon.org>
References: <20020928161704.A9102@lucon.org> <20020929021316.GA6731@nevyn.them.org> <20020928191653.A2384@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020928191653.A2384@lucon.org>; from hjl@lucon.org on Sat, Sep 28, 2002 at 07:16:53PM -0700
Return-Path: <hjl@lucon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 310
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hjl@lucon.org
Precedence: bulk
X-list: linux-mips

On Sat, Sep 28, 2002 at 07:16:53PM -0700, H. J. Lu wrote:
> On Sat, Sep 28, 2002 at 10:13:17PM -0400, Daniel Jacobowitz wrote:
> > On Sat, Sep 28, 2002 at 04:17:04PM -0700, H. J. Lu wrote:
> > > I recompiled my mipsel kernel with binutils in CVS as of 20020928. The
> > >  resulting kernel doesn't work. I got
> > > 
> > > Unhandled kernel unaligned access in unaligned.c::emulate_load_store_insn,
> > > line:
> > > $0 : 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000    
> > > $8 : 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000    
> > > $16: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000    
> > > $24: 00000000 00000000                   00000000 00000000 00000000 00000000    
> > > Hi : 00000000                                                                   
> > > Lo : 00000000                                                                   
> > > epc  : 00000000    Not tainted                                                  
> > > Status: 00000000                                                                
> > > Cause : 00000000                                                                
> > > Process sleep (pid: 16, stackpage=87e8c000)                                     
> > 
> > Could you try with the 2.13.1-branch - I believe it should be fine but
> > I haven't tested MIPS in a few merges.
> > 
> 
> I don't have resources to try 2.13.1. The Linux binutils 2.13.90.0.4
> based on 20020814 CVS is ok. I will try to fix CVS.
> 

Linker seems ok. It is as which is broken.


H.J.
