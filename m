Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Nov 2015 16:07:55 +0100 (CET)
Received: from relay1.mentorg.com ([192.94.38.131]:43593 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012553AbbKQPHuMQFpP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Nov 2015 16:07:50 +0100
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-FEM-01.mgc.mentorg.com)
        by relay1.mentorg.com with esmtp 
        id 1ZyhrC-0003s6-WC from joseph_myers@mentor.com ; Tue, 17 Nov 2015 07:07:43 -0800
Received: from digraph.polyomino.org.uk (137.202.0.76) by
 SVR-IES-FEM-01.mgc.mentorg.com (137.202.0.104) with Microsoft SMTP Server id
 14.3.224.2; Tue, 17 Nov 2015 15:07:41 +0000
Received: from jsm28 (helo=localhost)   by digraph.polyomino.org.uk with
 local-esmtp (Exim 4.82)        (envelope-from <joseph@codesourcery.com>)       id
 1ZyhrA-0004f7-9h; Tue, 17 Nov 2015 15:07:40 +0000
Date:   Tue, 17 Nov 2015 15:07:40 +0000
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
In-Reply-To: <alpine.DEB.2.00.1511140411050.7097@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.10.1511171503510.14808@digraph.polyomino.org.uk>
References: <alpine.DEB.2.00.1511140411050.7097@tp.orcam.me.uk>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-Path: <joseph_myers@mentor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49967
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

On Sat, 14 Nov 2015, Maciej W. Rozycki wrote:

>  Any or all of these options may have effects beyond propagating the IEEE
> Std 754 compliance mode down to the assembler and the linker.  In
> particular `-mieee=strict' is expected to guarantee code generated to
> fully comply to IEEE Std 754 rather than only as far as NaN representation
> is concerned.

"guarantee" seems rather strong given the various known issues with (lack 
of) Annex F support in GCC.  Do you have any actual configuration in mind 
it would affect, MIPS-specific or otherwise?  For 
non-architecture-specific things, -std= options for C standards 
conformance are meant to enable whatever options are required (e.g. they 
disable the default -ffp-contract=fast), without affecting things not 
required by the standards by default (so they don't enable -frounding-math 
or -fsignaling-nans, for example).

-- 
Joseph S. Myers
joseph@codesourcery.com
