Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Dec 2014 14:53:47 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57101 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008725AbaLSNxpjFQ4o convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Dec 2014 14:53:45 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E62E258CAA40B;
        Fri, 19 Dec 2014 13:53:36 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 19 Dec 2014 13:53:39 +0000
Received: from LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9]) by
 LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9%17]) with mapi id
 14.03.0210.002; Fri, 19 Dec 2014 13:53:37 +0000
From:   Matthew Fortune <Matthew.Fortune@imgtec.com>
To:     Markos Chandras <Markos.Chandras@imgtec.com>,
        David Daney <ddaney.cavm@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH RFC 19/67] MIPS: asm: atomic: Update asm and ISA
 constrains for MIPS R6 support
Thread-Topic: [PATCH RFC 19/67] MIPS: asm: atomic: Update asm and ISA
 constrains for MIPS R6 support
Thread-Index: AQHQGtTxkDb5yATObECe4IHSqw7IUJyVsVCAgAADEICAABwg4IAAGycAgAAA4dCAAMiSgIAAJsuAgAATvsA=
Date:   Fri, 19 Dec 2014 13:53:36 +0000
Message-ID: <6D39441BF12EF246A7ABCE6654B0235320F8B4E6@LEMAIL01.le.imgtec.org>
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com>
 <1418915416-3196-20-git-send-email-markos.chandras@imgtec.com>
 <549321F3.1090704@gmail.com> <20141218190125.GA8221@linux-mips.org>
 <6D39441BF12EF246A7ABCE6654B0235320F8AD08@LEMAIL01.le.imgtec.org>
 <549352E4.7090800@gmail.com>
 <6D39441BF12EF246A7ABCE6654B0235320F8AF3D@LEMAIL01.le.imgtec.org>
 <5493FBE1.7000602@imgtec.com> <54941C6B.90905@imgtec.com>
In-Reply-To: <54941C6B.90905@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.152.76]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Matthew.Fortune@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44844
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Matthew.Fortune@imgtec.com
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

Markos Chandras <Markos.Chandras@imgtec.com> writes:
> On 12/19/2014 10:20 AM, Markos Chandras wrote:
> > On 12/18/2014 10:58 PM, Matthew Fortune wrote:
> >> David Daney <ddaney.cavm@gmail.com> writes:
> >>> On 12/18/2014 01:04 PM, Matthew Fortune wrote:
> >>>>> On Thu, Dec 18, 2014 at 10:50:27AM -0800, David Daney wrote:
> >>>>>
> >>>>>> On 12/18/2014 07:09 AM, Markos Chandras wrote:
> >>>>>>> MIPS R6 changed the opcodes for LL/SC instructions and reduced the
> >>>>>>> offset field to 9-bits. This has some undesired effects with the
> >>> "m"
> >>>>>>> constrain since it implies a 16-bit immediate. As a result of
> >>>>>>> which, add a register ("r") constrain as well to make sure the
> >>>>>>> entire address is loaded to a register before the LL/SC
> operations.
> >>>>>>> Also use macro to set the appropriate ISA for the asm blocks
> >>>>>>>
> >>>>>>
> >>>>>> Has support for MIPS R6 been added to GCC?
> >>>>>>
> >>>>>> If so, that should include a proper constraint to be used with the
> >>>>>> new offset restrictions.  We should probably use that, instead of
> >>>>>> forcing to a "r" constraint.
> >>>>>
> >>>>> In a non-public earlier discussion I've requested the same but
> >>>>> somehow that was ignored.
> >>>>
> >>>> I must have missed that comment or not been on the thread.
> >>>>
> >>>>> We need suitable constraints or the alternatives will be very, very
> >>>>> ugly.
> >>>>
> >>>> We can certainly discuss and investigate such things but there is a
> >>>> general problem of a growing list of different size displacement
> >>>> fields in load/store instructions. Obviously you could just opt to
> >>>> keep things the way they are for uMIPS today and leave the assembler
> >>>> to expand the instruction but my opinion is that magic expanding
> >>>> assembler macros are infuriating. We have however had to put support
> >>>> in binutils for many of them, simply to keep enough software building
> >>> to ease the transition.
> >>>>
> >>>> So, all this patch does is highlight that magic assembler macros have
> >>>> been hiding this issue since micromips was added.
> >>>>
> >>>> >From your experiences will people invest the effort to look at the
> >>>> size of a displacement field for all the memory operations in an
> >>>> inline asm block and then choose an appropriate memory constraint?
> >>>>
> >>>> I'm obviously wary of putting things into GCC that are either only
> >>>> used in a handful of places (or not at all). The alternative to
> >>>> constraints is of course to try and reduce the need for inline asm
> and
> >>>> offer builtins for specific instructions or more complex operations.
> >>>>
> >>>
> >>> Well, GCC directly emits LL/SC as part of its built-in support for
> >>> atomic operations, so the knowledge of the constraints for the
> >>> instructions must be present there.  Since the constraints must be
> >>> present in GCC, using them in the kernel shouldn't be a problem.
> >>
> >> Yes you are right I thought this particular case only had constraints
> >> for the immediate and not the whole memory operand, I'm suffering from
> >> too many tasks and too little time. Several of the memory constraints
> are
> >> marked as internal and I'm not sure if that means they are unsafe to
> use
> >> from inline asm or just not deemed important.
> >>
> >> The memory constraint that LL and SC need is 'ZC'. I don't believe this
> >> is documented so you will have to trust that its meaning will not
> change
> >> but I can give some assurance of that since I will review all MIPS GCC
> >> changes.
> >>
> >> Obviously to use anything other than the 'm' constraint you are going
> >> to need to know when any given constraint was added to GCC.
> >> 'ZC' was only added to GCC in March 2013 r196828 which I believe it is
> a
> >> GCC 4.9 feature so you will have to use it conditionally if you use it
> at
> >> all.
> >>
> >
> > is this something desirable? check the gcc version, initialize a macro
> > and then use that macro as a constrain? i haven't thought this through,
> > but it could be a bit messy.
> >
> btw i tried a quick test to replace +m with +ZC but i have build
> failures since the immediates do not fit.
> 
> {standard input}: Assembler messages:
> {standard input}:436: Error: operand 2 must be constant `ll
> $3,%lo(irq_err_count)($2)'
> {standard input}:438: Error: operand 2 must be constant `sc
> $3,%lo(irq_err_count)($2)'
> 
> Could you provide an example of how you would use the ZC constrain in
> these asm blocks? i could be doing something wrong on my end.

In a follow up post I mentioned that you have essentially found something
missing from the R6 GCC implementation. We have just fixed this in our
internal builds so we will have to provide you with an updated compiler to
use ZC. This will be fixed in Imaginations 2015-01 Codescape SDK and will
be posted to GCC following R6 commit (that is a matter of hours away as it
happens).

The reason this was missed from the R6 implementation in GCC is that the
atomic sync patterns in the compiler actually only allow base registers with
no offset (reason unknown) so we will be fixing that too.

Thanks,
Matthew
