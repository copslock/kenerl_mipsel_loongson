Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 May 2004 15:32:08 +0100 (BST)
Received: from c2ce9fba.adsl.oleane.fr ([IPv6:::ffff:194.206.159.186]:23196
	"EHLO avalon.france.sdesigns.com") by linux-mips.org with ESMTP
	id <S8225779AbUE0Obz>; Thu, 27 May 2004 15:31:55 +0100
Received: from avalon.france.sdesigns.com (localhost.localdomain [127.0.0.1])
	by avalon.france.sdesigns.com (8.12.8/8.12.8) with ESMTP id i4REVssL007934;
	Thu, 27 May 2004 16:31:54 +0200
Received: (from michon@localhost)
	by avalon.france.sdesigns.com (8.12.8/8.12.8/Submit) id i4REVsam007932;
	Thu, 27 May 2004 16:31:54 +0200
X-Authentication-Warning: avalon.france.sdesigns.com: michon set sender to em@realmagic.fr using -f
Subject: Re: down_trylock() implementation for MIPS 4KEc CPU implies 64bit
	arithmetics?
From: Emmanuel Michon <em@realmagic.fr>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
In-Reply-To: <20040526203346.GA8430@linux-mips.org>
References: <1085589315.2306.49.camel@avalon.france.sdesigns.com>
	 <20040526203346.GA8430@linux-mips.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: REALmagic France SAS
Message-Id: <1085668313.20233.1249.camel@avalon.france.sdesigns.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 27 May 2004 16:31:53 +0200
Return-Path: <em@realmagic.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5203
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: em@realmagic.fr
Precedence: bulk
X-list: linux-mips

On Wed, 2004-05-26 at 22:33, Ralf Baechle wrote:
> On Wed, May 26, 2004 at 06:35:16PM +0200, Emmanuel Michon wrote:
> 
> Semaphores can be implemented using just a single 32-bit variable which
> would mean the same code could be used for 32-bit and 64-bit processors
> as long as only they support ll/sc.  Maybe somebody has the time at his
> hands, *hint*, *hint* :-)
> 
>   Ralf

On 64bit you substract 1ULL<<32

Substracting 1 is enough for it to be algorithmically correct even on
64bit

Do you accept a patch with the version for CONFIG_LLSC = y using a
substraction by 1?

Sincerely yours,

E.M.
