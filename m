Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Jun 2005 11:24:07 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:13 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8224987AbVFPKXx>; Thu, 16 Jun 2005 11:23:53 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j5GAKt41014383;
	Thu, 16 Jun 2005 11:20:55 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j5GAKtCT014382;
	Thu, 16 Jun 2005 11:20:55 +0100
Date:	Thu, 16 Jun 2005 11:20:55 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Philippe De Swert <philippedeswert@scarlet.be>
Cc:	tom <tom@voda.cz>, linux-mips <linux-mips@linux-mips.org>
Subject: Re: [Fwd: kernel compilation fails]
Message-ID: <20050616102054.GG5202@linux-mips.org>
References: <II68V7$710BD802DB90EFADDBE27A92E7C5B2C2@scarlet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <II68V7$710BD802DB90EFADDBE27A92E7C5B2C2@scarlet.be>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8102
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 16, 2005 at 10:54:43AM +0100, Philippe De Swert wrote:

> Basically 2.4.18 code is too old to compile as is with gcc 3.3.4. The
> assembler code needs to be inlined with a different syntax. Just look at
> similar files to see how it is done.

Not true.  Gcc 3.3 is probably even is the most commonly used compiler
with 2.4-based systems.  Builds with gcc 3.4 will fail for some 2.4
kernel configurations but at the very least throw loads of warnings.

> As a quick hint here is some code to show how it should look like.
> 
> 
>         __asm__(".set\tmips3\n\t"
>                 "wait\n\t"
>                 ".set\tmips0");
> 
> Notice the \n and \t parts. You are probabely missing those.

Actually more and more code it being formatted using tabs instead of the
\t escape sequence for readability.

  Ralf
