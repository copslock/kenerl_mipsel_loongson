Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Nov 2015 19:25:54 +0100 (CET)
Received: from relay1.mentorg.com ([192.94.38.131]:34795 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006799AbbKTSZw4zfhA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Nov 2015 19:25:52 +0100
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-FEM-01.mgc.mentorg.com)
        by relay1.mentorg.com with esmtp 
        id 1ZzqNV-0005tM-A1 from joseph_myers@mentor.com ; Fri, 20 Nov 2015 10:25:45 -0800
Received: from digraph.polyomino.org.uk (137.202.0.76) by
 SVR-IES-FEM-01.mgc.mentorg.com (137.202.0.104) with Microsoft SMTP Server id
 14.3.224.2; Fri, 20 Nov 2015 18:25:44 +0000
Received: from jsm28 (helo=localhost)   by digraph.polyomino.org.uk with
 local-esmtp (Exim 4.82)        (envelope-from <joseph@codesourcery.com>)       id
 1ZzqNS-0002xC-GQ; Fri, 20 Nov 2015 18:25:42 +0000
Date:   Fri, 20 Nov 2015 18:25:42 +0000
From:   Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:     "Maciej W. Rozycki" <macro@imgtec.com>
CC:     <linux-mips@linux-mips.org>, <libc-alpha@sourceware.org>,
        <binutils@sourceware.org>, <gcc@gcc.gnu.org>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Daniel Sanders <Daniel.Sanders@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [RFC] MIPS ABI Extension for IEEE Std 754 Non-Compliant
 Interlinking
In-Reply-To: <alpine.DEB.2.00.1511201535580.6915@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.10.1511201815230.9012@digraph.polyomino.org.uk>
References: <alpine.DEB.2.00.1511140411050.7097@tp.orcam.me.uk> <alpine.DEB.2.10.1511171503510.14808@digraph.polyomino.org.uk> <alpine.DEB.2.00.1511201535580.6915@tp.orcam.me.uk>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-Path: <joseph_myers@mentor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50005
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joseph@codesourcery.com
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

On Fri, 20 Nov 2015, Maciej W. Rozycki wrote:

>  The target audience for the `-mieee=strict' option is in my idea a 
> non-technical user, say a physicist, who does not necessarily know or is 
> fluent with the guts of computer hardware and who has the need to build 
> and reliably run their software which uses IEEE Std 754 arithmetic.  
> Rather than giving such a user necessarily lengthy explanations as to the 
> complexity of the situation I'd prefer to give them this single option to 
> guarantee (modulo bugs, as noted above) that a piece of software built 
> with this option will either produce correct (as in "standard-compliant") 
> results or refuse to run.

This does not make any sense.  The correspondence between IEEE 754 
operations and source code in C or other languages is extremely 
complicated.  If the user thinks of C as some form of portable assembler 
for IEEE 754 operations, that is not something effectively supportable.

Can we assume that if the user depends on rounding modes, they will use 
the FENV_ACCESS pragma (not implemented, of course) or -frounding-math?  
Can we assume that their dependence on the absence of contraction of 
expressions is in accordance with ISO C rules (again, FP_CONTRACT isn't 
implemented but -ffp-contract=off is)?  Can we assume that they don't 
depend on signaling NaNs?  Can we assume they don't depend on trap 
handlers that count the number of times a given exception occurs, since 
that is explicitly unsupported by ISO C?

An option like that has to be defined in terms of existing C bindings for 
IEEE 754, not in terms of supporting users who don't know what they are 
doing and are unfamiliar with how C source code constructs are mapped to 
IEEE 754 operations and what features the C standard allows non-default 
pragmas or options to be required for.

>  Does this answer address your concerns?

No, the option concept as described seems too irremediably vague.

-- 
Joseph S. Myers
joseph@codesourcery.com
