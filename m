Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Feb 2015 14:46:42 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27012582AbbBENqiODr0q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Feb 2015 14:46:38 +0100
Date:   Thu, 5 Feb 2015 13:46:38 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
cc:     Ralf Baechle <ralf@linux-mips.org>,
        Joshua Kinard <kumba@gentoo.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Display CPU byteorder in /proc/cpuinfo
In-Reply-To: <54C7ED94.6070507@gmail.com>
Message-ID: <alpine.LFD.2.11.1501272231190.28301@eddie.linux-mips.org>
References: <54BCC827.3020806@gentoo.org> <54BEDF3C.6040105@gmail.com> <54BF12B9.8000507@gentoo.org> <alpine.LFD.2.11.1501210347180.28301@eddie.linux-mips.org> <20150126131621.GB31322@linux-mips.org> <alpine.LFD.2.11.1501261358540.28301@eddie.linux-mips.org>
 <54C68429.4030701@gmail.com> <alpine.LFD.2.11.1501261904310.28301@eddie.linux-mips.org> <54C69FCE.80002@gmail.com> <alpine.LFD.2.11.1501262345320.28301@eddie.linux-mips.org> <54C7ED94.6070507@gmail.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45724
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

On Tue, 27 Jan 2015, David Daney wrote:

> > > It is bizarre, and perhaps almost mind bending, but that seems to be how
> > > it is
> > > specified.  Certainly the OCTEON implementation works this way.
> >
> >   Well, I think this observation:
> >
> > "2.2.2.2 Memory Operation Functions
> >
> > "Regardless of byte ordering (big- or little-endian), the address of a
> > halfword, word, or doubleword is the smallest byte address of the bytes
> > that form the object.  For big-endian ordering this is the
> > most-significant byte; for a little-endian ordering this is the
> > least-significant byte."
> >
> > contradicts your claim [...]
> 
> One can argue about the meaning of the text in the reference manual. But in
> the end, the behavior of real processors is what we are forced to deal with.
> 
> In the case of all existing OCTEON processors, there is no Status[RE] bit, but
> you can switch the endianess of the entire CPU under software control.  I am
> really making statements based on how they actually work, not assertions about
> the meaning of the specification.  However, I do believe that this is what is
> specified.
> 
> If you have access to processors with a working Status[RE] bit, you could
> empirically determine how they work.

 Well, I do actually, I have a working machine driven by an R4000 
processor.  It was the original implementation of the Status.RE feature 
and therefore it can be used as the reference.  I don't feel tempted to 
use my time to actually make any checks though.

 What I did instead, I checked the R4000 manual and the descriptions there 
are exactly the same as in the current MIPS architecture manual, down to 
using the same names like `BigEndianMem' or `StoreMemory'.  Given that 
this is documentation that has been purposely prepared for a specific 
piece of silicon I have no reasons to believe it is inaccurate here.

 Furthermore, from your description, assuming that I understand it 
correctly, I infer that the reverse-endian mode as implemented by Octeon 
processors is completely useless and therefore a waste of silicon.  Given 
the circumstances if I was a processor architecture implementer and was 
feaced with a useless optional feature, I would have either omitted it 
entirely or implemented it in a different, useful manner, as a vendor 
extension.

 Given that as you say you don't wire it to Status.RE anyway, as the 
architecture standard mandates, this is already a vendor extension so I 
fail to see a reason to avoid doing it correctly from the usability point 
of view, and then reporting observations back to architecture maintainers 
so that they can be taken into account in a future revision of the 
architecture standard.

 The conclusion is if we ever decide to implement it for Linux, then we'll 
probably have to include a small run-time check that upon the bootstrap 
makes the kernel switch into the reverse-endian user mode temporarily, 
executes a small piece there that stores some immediate data to memory, 
then traps back into the kernel to verify the byte order of stored data is 
sane and decides if to make the feature available to user software, before 
moving on.

  Maciej
