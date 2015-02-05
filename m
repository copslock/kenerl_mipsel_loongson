Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Feb 2015 17:12:38 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27012590AbbBEQMgb8Wyg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Feb 2015 17:12:36 +0100
Date:   Thu, 5 Feb 2015 16:12:36 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     =?ISO-8859-15?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
cc:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Joshua Kinard <kumba@gentoo.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Display CPU byteorder in /proc/cpuinfo
In-Reply-To: <yw1xd25o9y3k.fsf@unicorn.mansr.com>
Message-ID: <alpine.LFD.2.11.1502051546540.22715@eddie.linux-mips.org>
References: <54BCC827.3020806@gentoo.org> <54BEDF3C.6040105@gmail.com>        <54BF12B9.8000507@gentoo.org>        <alpine.LFD.2.11.1501210347180.28301@eddie.linux-mips.org>        <20150126131621.GB31322@linux-mips.org>       
 <alpine.LFD.2.11.1501261358540.28301@eddie.linux-mips.org>        <54C68429.4030701@gmail.com>        <alpine.LFD.2.11.1501261904310.28301@eddie.linux-mips.org>        <54C69FCE.80002@gmail.com>        <alpine.LFD.2.11.1501262345320.28301@eddie.linux-mips.org>
        <54C7ED94.6070507@gmail.com>        <alpine.LFD.2.11.1501272231190.28301@eddie.linux-mips.org> <yw1xd25o9y3k.fsf@unicorn.mansr.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45727
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

On Thu, 5 Feb 2015, Måns Rullgård wrote:

> >> If you have access to processors with a working Status[RE] bit, you could
> >> empirically determine how they work.
> >
> >  Well, I do actually, I have a working machine driven by an R4000 
> > processor.  It was the original implementation of the Status.RE feature 
> > and therefore it can be used as the reference.  I don't feel tempted to 
> > use my time to actually make any checks though.
> 
> Is it reasonably easy to test this on an R10000 (SGI Octane) running
> IRIX 6.5?

 I doubt it.  I think the easiest way to experiment with this feature is 
to modify Linux so as to run its userland with CP0.Status.CU0 set to one 
(paying attention to the current use of the bit in the kernel) and then 
make the user program flip CP0.Status.RE itself.  According to the R10000 
manual a 0->1 transition is allowed for this bit in the user mode [1]:

"The Reverse-Endian (RE) bit, bit 25, reverses the endianness of the
machine.  The processor can be configured as either little-endian or
big-endian at system reset; reverse-endian selection is available in
Kernel and Supervisor modes, and in the User mode when the RE bit
is 0.  Setting the RE bit to 1 inverts the User mode endianness."

The same note is present in the R4000 manual too [2].  It's unclear to me 
from it if the reverse transition is allowed in the user mode, although 
I'd find it strange if it was not.

 Once you've got the bit flipped you can experiment, though beware of a 
COP0 hazard likely present here, the effect may not be immediate.  You can 
then safely call exit(2) to terminate the process as only registers have 
to be set appropriately to make this call and for registers endianness 
does not apply.

 HTH,

  Maciej

References:

[1] "MIPS R10000 Microprocessor User's Manual", Version 2.0, MIPS 
    Technologies, Inc., January 29, 1997, p. 247

[2] Joe Heinrich: "MIPS R4000 Microprocessor User's Manual", Second 
    Edition, MIPS Technologies, Inc., April 1, 1994, p. 105

  Maciej
