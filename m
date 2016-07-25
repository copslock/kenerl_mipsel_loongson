Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jul 2016 17:49:24 +0200 (CEST)
Received: from relay1.mentorg.com ([192.94.38.131]:54201 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992170AbcGYPtReZmyE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Jul 2016 17:49:17 +0200
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-FEM-02.mgc.mentorg.com)
        by relay1.mentorg.com with esmtp 
        id 1bRi7x-0000Te-Kc from joseph_myers@mentor.com ; Mon, 25 Jul 2016 08:49:09 -0700
Received: from digraph.polyomino.org.uk (137.202.0.76) by
 SVR-IES-FEM-02.mgc.mentorg.com (137.202.0.106) with Microsoft SMTP Server id
 14.3.224.2; Mon, 25 Jul 2016 16:49:08 +0100
Received: from jsm28 (helo=localhost)   by digraph.polyomino.org.uk with
 local-esmtp (Exim 4.86_2)      (envelope-from <joseph@codesourcery.com>)       id
 1bRi7v-00087v-3y; Mon, 25 Jul 2016 15:49:07 +0000
Date:   Mon, 25 Jul 2016 15:49:07 +0000
From:   Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:     "Maciej W. Rozycki" <macro@imgtec.com>
CC:     Matthew Fortune <Matthew.Fortune@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "binutils@sourceware.org" <binutils@sourceware.org>,
        "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>
Subject: RE: [RFC v2] MIPS ABI Extension for IEEE Std 754 Non-Compliant
 Interlinking
In-Reply-To: <alpine.DEB.2.00.1607121323050.4076@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.20.1607251544340.22934@digraph.polyomino.org.uk>
References: <alpine.DEB.2.00.1605141043120.6794@tp.orcam.me.uk> <6D39441BF12EF246A7ABCE6654B023537E40C27F@hhmail02.hh.imgtec.org> <alpine.DEB.2.00.1607121323050.4076@tp.orcam.me.uk>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-Path: <joseph_myers@mentor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54366
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

On Thu, 14 Jul 2016, Maciej W. Rozycki wrote:

> 2. An idea has been proposed to have objects marked by the assembler to 
>    indicate whether they include an FP hardware instruction or not.  The 
>    latters would automatically become don't-cares as far as NaN encoding
>    is concerned and if all the objects were such in a given static link, 

I don't think presence of FP hardware instructions is much of a guide to 
whether code cares about NaN encodings.  I'd expect most code simply doing 
arithmetic not to care (that is, the same object code would work correctly 
on systems with either NaN encoding - given the right encodings for that 
system as inputs, it would produce the right encodings as outputs), while 
code using a NaN encoding explicitly (typically through __builtin_nan or 
folded 0.0 / 0.0 in a static initializer) cares even if that object does 
not use FP instructions.  (Formally, of course code knowing the ABI can 
creating encodings directly, implement issignaling itself, etc., but that 
should be rare.)

-- 
Joseph S. Myers
joseph@codesourcery.com
