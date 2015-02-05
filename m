Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Feb 2015 11:25:23 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46592 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012053AbbBEKZVy0GVq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Feb 2015 11:25:21 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C9780B628BB70;
        Thu,  5 Feb 2015 10:25:13 +0000 (GMT)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 5 Feb
 2015 10:25:16 +0000
Received: from hhmail02.hh.imgtec.org ([::1]) by hhmail02.hh.imgtec.org
 ([::1]) with mapi id 14.03.0224.002; Thu, 5 Feb 2015 10:25:15 +0000
From:   Toma Tabacu <Toma.Tabacu@imgtec.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Daniel Sanders <Daniel.Sanders@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
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
Thread-Index: AQHQP7ajKQVJ2AEG9063KpjdfAGJ6ZzgTWsAgAGO+TA=
Date:   Thu, 5 Feb 2015 10:25:14 +0000
Message-ID: <A614194ED15B4844BC4C9FB7F21FCD9201347BAE@hhmail02.hh.imgtec.org>
References: <1422970639-7922-1-git-send-email-daniel.sanders@imgtec.com>
 <1422970639-7922-6-git-send-email-daniel.sanders@imgtec.com>
 <alpine.LFD.2.11.1502041022150.22715@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1502041022150.22715@eddie.linux-mips.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.14.150]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Toma.Tabacu@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45719
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Toma.Tabacu@imgtec.com
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

On Wed, 4 Feb 2015, Maciej W. Rozycki wrote:
> 2. It considers these character pairs to be unicode escapes in the first 
>    place given that they do not follow the syntax required for such 
>    escapes, that is `\unnnn', where `n' are hex digits.
> 

It doesn't actually treat them as unicode escapes, but it still warns the user,
in case they were meant to be unicode escapes. Here's the warning message:

arch/mips/include/asm/asmmacro.h:197:51: warning: \u used with no following hex digits; treating as '\' followed by identifier [-Wunicode]
         .word  0x41000000 | (\rt << 16) | (\rd << 11) | (\u << 5) | (\sel)
                                                          ^
I'll add it to the summary in v2.

> Of course it may be reasonable for us to work this bug around as we've 
> been doing for years with GCC, but has the issue been reported back to 
> clang maintainers?  What was their response?
> 

It hasn't been reported, but I don't think they would agree with removing
unicode escape sequences from the assembler-with-cpp mode because it is
currently being used for other languages as well, not just assembly.

One such language is Haskell (ghc, to be more specific), for which the clang
developers had to actually stop the preprocessor from enforcing the C universal
character name restrictions in assembler-with-cpp mode, which suggests that ghc
wants the preprocessor to check for unicode escape sequences.

At the moment, we can either disable -Wunicode for asmmacro.h or refrain from
using '\u' as an identifier.
