Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Feb 2015 18:37:41 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:20436 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011381AbbBKRhjTtLX8 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Feb 2015 18:37:39 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 3367DB0F71559;
        Wed, 11 Feb 2015 17:37:30 +0000 (GMT)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 11 Feb
 2015 17:37:33 +0000
Received: from hhmail02.hh.imgtec.org ([::1]) by hhmail02.hh.imgtec.org
 ([::1]) with mapi id 14.03.0224.002; Wed, 11 Feb 2015 17:37:32 +0000
From:   Daniel Sanders <Daniel.Sanders@imgtec.com>
To:     =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Toma Tabacu <Toma.Tabacu@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <Paul.Burton@imgtec.com>,
        Paul Bolle <pebolle@tiscali.nl>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 5/5] MIPS: LLVMLinux: Silence unicode warnings when
 preprocessing assembly.
Thread-Topic: [PATCH 5/5] MIPS: LLVMLinux: Silence unicode warnings when
 preprocessing assembly.
Thread-Index: AQHQQUMYnhfPfdCa2E2pvrqiDdNSz5zrgd1Q
Date:   Wed, 11 Feb 2015 17:37:31 +0000
Message-ID: <E484D272A3A61B4880CDF2E712E9279F459260F9@hhmail02.hh.imgtec.org>
References: <1422970639-7922-1-git-send-email-daniel.sanders@imgtec.com>
        <1422970639-7922-6-git-send-email-daniel.sanders@imgtec.com>
        <alpine.LFD.2.11.1502041022150.22715@eddie.linux-mips.org>
        <A614194ED15B4844BC4C9FB7F21FCD9201347BAE@hhmail02.hh.imgtec.org>
        <alpine.LFD.2.11.1502051107150.22715@eddie.linux-mips.org>
 <yw1xh9v0a55p.fsf@unicorn.mansr.com>
In-Reply-To: <yw1xh9v0a55p.fsf@unicorn.mansr.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.14.109]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Daniel.Sanders@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45802
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Daniel.Sanders@imgtec.com
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

Apologies for the slow reply.

> -----Original Message-----
> From: Måns Rullgård [mailto:mans@mansr.com]
> Sent: 05 February 2015 12:56
> To: Maciej W. Rozycki
> Cc: Toma Tabacu; Daniel Sanders; Ralf Baechle; Paul Burton; Paul Bolle;
> Steven J. Hill; Manuel Lauss; Jim Quinlan; linux-mips@linux-mips.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH 5/5] MIPS: LLVMLinux: Silence unicode warnings when
> preprocessing assembly.
> 
> "Maciej W. Rozycki" <macro@linux-mips.org> writes:
> 
> > On Thu, 5 Feb 2015, Toma Tabacu wrote:
> >
> >> > 2. It considers these character pairs to be unicode escapes in the first
> >> >    place given that they do not follow the syntax required for such
> >> >    escapes, that is `\unnnn', where `n' are hex digits.
> >> >
> >>
> >> It doesn't actually treat them as unicode escapes, but it still warns
> >> the user, in case they were meant to be unicode escapes. Here's the
> >> warning message:
> >>
> >> arch/mips/include/asm/asmmacro.h:197:51: warning: \u used with no
> following hex digits; treating as '\' followed by identifier [-Wunicode]
> >>          .word  0x41000000 | (\rt << 16) | (\rd << 11) | (\u << 5) | (\sel)
> >>                                                           ^
> >> I'll add it to the summary in v2.
> >
> >  Thanks, that makes things clearer.  It always makes sense to include the
> > exact error message produced where applicable or otherwise people do not
> > necessarily know what the matter is.
> >
> >> > Of course it may be reasonable for us to work this bug around as we've
> >> > been doing for years with GCC, but has the issue been reported back to
> >> > clang maintainers?  What was their response?
> >> >
> >>
> >> It hasn't been reported, but I don't think they would agree with removing
> >> unicode escape sequences from the assembler-with-cpp mode because it is
> >> currently being used for other languages as well, not just assembly.
> >
> >  First, preprocessing rules surely have to be language specific.  The C
> > language standard does not specify what the preprocessor is meant to do
> > (if anything) for other languages.  GCC or clang -- that's no different.
> > 
> >  The assembly language has a different syntax and `\u' has a different
> > meaning in the context of assembly macro expansion than it would have in a
> > name of a symbol, where such a Unicode escape sequence might indeed be
> > interpreted as such and character encoded propagated to the symbol
> > produced.  But that's up to the assembler -- GAS for example does not
> > AFAIK support Unicode escape sequences in symbol names right now, but I
> > suppose such a feature could be added if desired.

Pre-processed assembly is somewhat unusual in that it has traditionally been
pre-processed with a pre-processor designed for the C language. It's certainly
possible to have assembly specific tweaks (GCC has a couple) but it is still a C
pre-processor at heart. It doesn't know anything about the assembly language,
it just happens to be similar enough to be usable.

From the pre-processors point of view, '\u' is two pre-processor tokens '\' and
the identifier 'u'. However, with following hex digits it would have been an identifier
starting with a universal character name. Clang's warning is effectively saying that
the former is more likely to be the intention. That's probably not as true for
pre-processed assembly as it is for C/C++.

> >  Which prompts another question of course: how does the clang C compiler
> > represent Unicode characters in identifiers in its assembly output?

They're emitted as multi-byte characters.

> >  I have looked into the C language standard and it appears to me like the
> > translation phase to interpret universal character names at has not been
> > defined.  This is probably why the standard does specify the result of
> > pasting preprocessor tokens together as undefined if a universal character
> > name is produced this way.
> 
> That is my interpretation as well.

It's my understanding that they should be interpreted when pre-processing tokens
are formed. This is based on the fact that the universal character names are included in
the grammar for identifiers and are not discussed in a separate translation phase.
I agree that it doesn't explicitly state that though.

> >  Consequently I think an important question in this context is: does
> > clang's preprocessor actually convert these sequences anyhow before
> > passing them down to the compiler?  How for example does C output from a
> > trivial example that contains such Unicode escape sequences look like
> > then?

Clang is converting them to multibyte characters during pre-processing.

> >> One such language is Haskell (ghc, to be more specific), for which
> >> the clang developers had to actually stop the preprocessor from
> >> enforcing the C universal character name restrictions in
> >> assembler-with-cpp mode, which suggests that ghc wants the
> >> preprocessor to check for unicode escape sequences.
> >>
> >> At the moment, we can either disable -Wunicode for asmmacro.h or
> >> refrain from using '\u' as an identifier.
> >
> >  To be clear: it's `u' here that is the identifier, the leading `\' is
> > merely how assembly syntax has been specified for references to macro
> > arguments.  And TBH I find banning any macro arguments starting with `u'
> > rather silly.
> 
> Agreed.

That's the crux of the issue. Had it been followed by some hex-digits,
it would be an identifier '\u1234' and not a '\' followed by the identifier 'u'.
Clang currently thinks the former is more likely and warns.

I do agree that warning about all macro arguments beginning with 'u' is silly though.
Perhaps for assembler-with-cpp mode the warning should be suppressed when
it's the first character of an identifier.

> > I'm leaning towards considering having -Wunicode disabled for all
> > assembly sources, or maybe even for the whole Linux compilation, the
> > right solution.  It's not like we have a need for Unicode identifiers.
> 
> It might be an idea to disable -Wunicode and have checkpatch warn about
> Unicode escapes instead if people are worried about this.  Personally, I
> doubt there's much cause for concern here.
> 
> --
> Måns Rullgård
> mans@mansr.com

I'm fine with disabling -Wunicode if that's our preferred solution.
