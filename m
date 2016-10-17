Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Oct 2016 15:35:01 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:13656 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991759AbcJQNexryokO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Oct 2016 15:34:53 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id 4E699D43B9879;
        Mon, 17 Oct 2016 14:34:44 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 17 Oct 2016
 14:34:47 +0100
Received: from [10.20.78.147] (10.20.78.147) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Mon, 17 Oct 2016
 14:34:46 +0100
Date:   Mon, 17 Oct 2016 14:34:37 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <stable@vger.kernel.org>,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: IP22: Fix build error in IP22 cache code
In-Reply-To: <1476440397-13042-1-git-send-email-matt.redfearn@imgtec.com>
Message-ID: <alpine.DEB.2.00.1610160650120.31859@tp.orcam.me.uk>
References: <1476440397-13042-1-git-send-email-matt.redfearn@imgtec.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.147]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55452
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Fri, 14 Oct 2016, Matt Redfearn wrote:

> Recent MIPS toolchains complain about the use of an immediate larger
> than 32bits when compiling a 32bit kernel, leading to the following
> build failure:
> {standard input}: Assembler messages:
> {standard input}:131: Error: number (0x9000000080000000) larger than 32
> bits
> {standard input}:154: Error: number (0x9000000080000000) larger than 32
> bits
> {standard input}:191: Error: number (0x9000000080000000) larger than 32
> bits
> 
> Fix this by specifying registers are 64bit via the .set gp=64 directive.
> 
> Since IP22 is the default MIPS machine, this is causing allnoconfig
> build failures.
> 
> Fixes: 1da177e4c3f4
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
> 
> Cc: stable@vger.kernel.org
> ---

 This GAS regression introduced with upstream binutils commit 919731affbef 
("Add MIPS .module directive") has been fixed with commit 22522f880a8e 
("MIPS/GAS: Fix an ISA override not lifting ABI restrictions") and release 
2.27 has been subsequently made.

 Moving forward with your workaround may still make sense, although it 
will bump the minimum binutils version to 2.18, which is when `.set gp=64' 
has been added only, from the advertised version 2.12; it may have already 
effectively happened due to changes elsewhere.  If doing so however, 
please be accurate with your commit description in that versions 2.25 and 
2.26 (and their patch releases) only rather than "recent" have been 
affected.

 See also: <http://lkml.iu.edu/hypermail/linux/kernel/1604.2/00187.html> 
and the discussion downthread.  Based on the conclusions made there I'd 
rather ban binutils 2.25 and 2.26 from use with the MIPS/Linux kernel as 
the problem with ISA restoration may lead to bad code generation.  So 
maybe we should really leave this piece unchanged, as a fatal trigger for 
unsupported binutils versions in the affected scenarios.

  Maciej
