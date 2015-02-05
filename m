Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Feb 2015 13:56:10 +0100 (CET)
Received: from unicorn.mansr.com ([81.2.72.234]:57380 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012224AbbBEM4ID5Jf9 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Feb 2015 13:56:08 +0100
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 659351538A; Thu,  5 Feb 2015 12:56:02 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Toma Tabacu <Toma.Tabacu@imgtec.com>,
        Daniel Sanders <Daniel.Sanders@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <Paul.Burton@imgtec.com>,
        Paul Bolle <pebolle@tiscali.nl>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        "linux-mips\@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] MIPS: LLVMLinux: Silence unicode warnings when preprocessing assembly.
References: <1422970639-7922-1-git-send-email-daniel.sanders@imgtec.com>
        <1422970639-7922-6-git-send-email-daniel.sanders@imgtec.com>
        <alpine.LFD.2.11.1502041022150.22715@eddie.linux-mips.org>
        <A614194ED15B4844BC4C9FB7F21FCD9201347BAE@hhmail02.hh.imgtec.org>
        <alpine.LFD.2.11.1502051107150.22715@eddie.linux-mips.org>
Date:   Thu, 05 Feb 2015 12:56:02 +0000
In-Reply-To: <alpine.LFD.2.11.1502051107150.22715@eddie.linux-mips.org>
        (Maciej W. Rozycki's message of "Thu, 5 Feb 2015 12:35:42 +0000
        (GMT)")
Message-ID: <yw1xh9v0a55p.fsf@unicorn.mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <mru@mansr.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45722
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mans@mansr.com
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

"Maciej W. Rozycki" <macro@linux-mips.org> writes:

> On Thu, 5 Feb 2015, Toma Tabacu wrote:
>
>> > 2. It considers these character pairs to be unicode escapes in the first 
>> >    place given that they do not follow the syntax required for such 
>> >    escapes, that is `\unnnn', where `n' are hex digits.
>> > 
>> 
>> It doesn't actually treat them as unicode escapes, but it still warns
>> the user, in case they were meant to be unicode escapes. Here's the
>> warning message:
>> 
>> arch/mips/include/asm/asmmacro.h:197:51: warning: \u used with no following hex digits; treating as '\' followed by identifier [-Wunicode]
>>          .word  0x41000000 | (\rt << 16) | (\rd << 11) | (\u << 5) | (\sel)
>>                                                           ^
>> I'll add it to the summary in v2.
>
>  Thanks, that makes things clearer.  It always makes sense to include the 
> exact error message produced where applicable or otherwise people do not 
> necessarily know what the matter is.
>
>> > Of course it may be reasonable for us to work this bug around as we've 
>> > been doing for years with GCC, but has the issue been reported back to 
>> > clang maintainers?  What was their response?
>> > 
>> 
>> It hasn't been reported, but I don't think they would agree with removing
>> unicode escape sequences from the assembler-with-cpp mode because it is
>> currently being used for other languages as well, not just assembly.
>
>  First, preprocessing rules surely have to be language specific.  The C 
> language standard does not specify what the preprocessor is meant to do 
> (if anything) for other languages.  GCC or clang -- that's no different.  
>
>  The assembly language has a different syntax and `\u' has a different 
> meaning in the context of assembly macro expansion than it would have in a 
> name of a symbol, where such a Unicode escape sequence might indeed be 
> interpreted as such and character encoded propagated to the symbol 
> produced.  But that's up to the assembler -- GAS for example does not 
> AFAIK support Unicode escape sequences in symbol names right now, but I 
> suppose such a feature could be added if desired.
>
>  Which prompts another question of course: how does the clang C compiler 
> represent Unicode characters in identifiers in its assembly output?
>
>  I have looked into the C language standard and it appears to me like the 
> translation phase to interpret universal character names at has not been 
> defined.  This is probably why the standard does specify the result of 
> pasting preprocessor tokens together as undefined if a universal character 
> name is produced this way.

That is my interpretation as well.

>  Consequently I think an important question in this context is: does 
> clang's preprocessor actually convert these sequences anyhow before 
> passing them down to the compiler?  How for example does C output from a 
> trivial example that contains such Unicode escape sequences look like 
> then?
>
>> One such language is Haskell (ghc, to be more specific), for which
>> the clang developers had to actually stop the preprocessor from
>> enforcing the C universal character name restrictions in
>> assembler-with-cpp mode, which suggests that ghc wants the
>> preprocessor to check for unicode escape sequences.
>> 
>> At the moment, we can either disable -Wunicode for asmmacro.h or
>> refrain from using '\u' as an identifier.
>
>  To be clear: it's `u' here that is the identifier, the leading `\' is 
> merely how assembly syntax has been specified for references to macro 
> arguments.  And TBH I find banning any macro arguments starting with `u' 
> rather silly.

Agreed.

> I'm leaning towards considering having -Wunicode disabled for all
> assembly sources, or maybe even for the whole Linux compilation, the
> right solution.  It's not like we have a need for Unicode identifiers.

It might be an idea to disable -Wunicode and have checkpatch warn about
Unicode escapes instead if people are worried about this.  Personally, I
doubt there's much cause for concern here.

-- 
M�ns Rullg�rd
mans@mansr.com
