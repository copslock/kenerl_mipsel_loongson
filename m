Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2008 19:04:43 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:58278 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S23892287AbYKXTEk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 24 Nov 2008 19:04:40 +0000
Date:	Mon, 24 Nov 2008 19:04:40 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Geert Uytterhoeven <geert@linux-m68k.org>,
	David Daney <ddaney@caviumnetworks.com>, gcc@gcc.gnu.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-mips <linux-mips@linux-mips.org>,
	linux-kernel@vger.kernel.org,
	Adam Nemet <anemet@caviumnetworks.com>
Subject: Re: [PATCH] MIPS: Make BUG() __noreturn.
In-Reply-To: <20081121221619.GB28154@linux-mips.org>
Message-ID: <alpine.LFD.1.10.0811241854520.3793@ftp.linux-mips.org>
References: <49260E4C.8080500@caviumnetworks.com> <20081121100035.3f5a640b@lxorguk.ukuu.org.uk> <Pine.LNX.4.64.0811211126420.26004@anakin> <4926E499.4070706@caviumnetworks.com> <Pine.LNX.4.64.0811211940450.29539@anakin>
 <20081121221619.GB28154@linux-mips.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21405
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 21 Nov 2008, Ralf Baechle wrote:

> MIPS ISA newer than MIPS I also have conditional break codes allowing
> something like this:
> 
> #define BUG_ON(condition)                                               \
> do {                                                                    \
>         __asm__ __volatile__("tne $0, %0, %1"                           \
>                              : : "r" (condition), "i" (BRK_BUG));       \
> } while (0)
> 
> that is test of condition and the trap as a single instruction.  Note there
> are break and trap instructions on MIPS and they are basically doing the
> same job ...

 GCC is actually smart enough to combine sequences like:

if (something)
	__builtin_trap();

into appropriate conditional trap instructions on MIPS.  As noted by David 
trap codes other than the default cannot be emitted this way though.

  Maciej
