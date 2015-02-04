Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2015 11:36:26 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27011464AbbBDKgY2p0sZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Feb 2015 11:36:24 +0100
Date:   Wed, 4 Feb 2015 10:36:24 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Daniel Sanders <daniel.sanders@imgtec.com>
cc:     Toma Tabacu <toma.tabacu@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Bolle <pebolle@tiscali.nl>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Jim Quinlan <jim2101024@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] MIPS: LLVMLinux: Silence unicode warnings when
 preprocessing assembly.
In-Reply-To: <1422970639-7922-6-git-send-email-daniel.sanders@imgtec.com>
Message-ID: <alpine.LFD.2.11.1502041022150.22715@eddie.linux-mips.org>
References: <1422970639-7922-1-git-send-email-daniel.sanders@imgtec.com> <1422970639-7922-6-git-send-email-daniel.sanders@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45645
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

On Tue, 3 Feb 2015, Daniel Sanders wrote:

> From: Toma Tabacu <toma.tabacu@imgtec.com>
> 
> Differentiate the 'u' GAS .macro argument from the '\u' C preprocessor unicode
> escape sequence by renaming it to '_u'.
> 
> When the 'u' argument is evaluated, we end up writing '\u', which causes
> clang to emit -Wunicode warnings.
> 
> This silences a couple of -Wunicode warnings reported by clang.
> The changed code can be preprocessed without warnings by both gcc and clang.

 I suspect it is a clang preprocessor bug that:

1. It interprets these character pairs as unicode escapes for assembly 
   sources, I think it should be up to the language translator rather 
   than the preprocessor, i.e. the assembler in this case (the notion of 
   unicode escapes for the preprocessor appears to be limited to 
   stringification, and then it is implementation-defined).

2. It considers these character pairs to be unicode escapes in the first 
   place given that they do not follow the syntax required for such 
   escapes, that is `\unnnn', where `n' are hex digits.

Of course it may be reasonable for us to work this bug around as we've 
been doing for years with GCC, but has the issue been reported back to 
clang maintainers?  What was their response?

  Maciej
