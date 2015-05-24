Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 May 2015 16:25:38 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27006775AbbEXOZfvnAnC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 May 2015 16:25:35 +0200
Date:   Sun, 24 May 2015 15:25:35 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>,
        Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: Re: IP30: SMP, Almost there?
In-Reply-To: <556104B7.8070504@gentoo.org>
Message-ID: <alpine.LFD.2.11.1505240105050.11225@eddie.linux-mips.org>
References: <55597B21.4010704@gentoo.org> <5559D483.905@gentoo.org> <555C1A53.9010803@gentoo.org> <555D7469.7090806@gentoo.org> <alpine.LFD.2.11.1505220341220.4923@eddie.linux-mips.org> <20150522171113.GC6467@linux-mips.org> <556104B7.8070504@gentoo.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47597
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

On Sat, 23 May 2015, Joshua Kinard wrote:

> > Some of IP27's reactions are a bit unobvious though.  First, the uncached
> > addres space (CCA 2) works differently that one might think.  IP27 uses
> > the R10000's uncached attribute feature which subdivides the CPUs
> > uncached XKPHYS address space into four addres spaces with the highest
> > address byte being 0x90, 0x92, 0x94 or 0x96.  The classic uncached
> > memory access happens with UC=3, that is the top address byte being
> > 0x96.

 Interesting.  For the record, this is noted in Section 6.23 "Support for 
Uncached Attribute" of the R10k manual, though the interpretation of the 
attributes is itself system-specific.

 And it looks we do handle the attributes correctly in `ioremap', via 
IO_BASE.  However it also looks to me like a corresponding update to 
`pte_to_entrylo' is needed so that we don't attempt an uncached virtual 
mapping with the wrong attribute (e.g. with an O_DSYNC mmap(2) of 
/dev/mem).  Ralf, WDYT?

> I was reading the IRIX Device Driver Programming Guide (007-0911-210), Chapter
> 1, and saw the explanation for this.  Also the bit on how the memory addresses
> are coded so that a reference to the specific node number can be encoded as
> well to assist the CPUs in accessing the memory closest to them.  Definitely
> interesting, but apparently Octane doesn't appear to use any of this.  As far
> as I can tell, it's main UNCAC_BASE and IO_BASE is classic 0x9000000000000000,
> CAC_BASE is 0xa800000000000000, and MAP_BASE is 0xc000000000000000.  These are
> all the defaults in mach-generic/spaces.h, so IP30 has never had to define a
> local spaces.h override.
> 
> It DOES look like I need to hardcode the 'cca=5' bit, somewhere, though.
> Whatever the Octane is booting up with does not work for SMP.

 Hmm, `coherency_setup' normally does the sane thing, Config.K0 should 
have been correctly set up by the firmware.  If not (what is it then?), 
then it looks to me like a quirk to resolve in platform code; IMHO just 
rewrite Config.K0 with the right value early on, before `coherency_setup' 
is called.

> > Do not use that.  EVER.  It entirely bypasses the CPU's cache coherency
> > logic.  Due to all the consistency checking between the directory
> > caches and other involved agents the memory controller might detect the
> > inconsistency between cache and memory and send guess what, a bus
> > error.

 OK, that does sound like plausible explanation for the bus error to me.

  Maciej
