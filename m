Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Apr 2006 09:14:03 +0100 (BST)
Received: from uproxy.gmail.com ([66.249.92.175]:17758 "EHLO uproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8127231AbWDQINv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 17 Apr 2006 09:13:51 +0100
Received: by uproxy.gmail.com with SMTP id u2so360082uge
        for <linux-mips@linux-mips.org>; Mon, 17 Apr 2006 01:26:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XsJOhvzZ+2UaFIE3BGl6tmZNQcYbZ0gMOmNZVhsF3DsVarouTDFdkIA8puoO1ZrnwkWORPIczK+KjlnBxheDVE5drWZJNjLgYzSXLMeqhs+4ly34eZ6Lzcrsc9M/A7S8dUCCAN3T2lDhBXN2iEO37pBa1Ds2eJ2uB1u75HckXd4=
Received: by 10.78.45.13 with SMTP id s13mr128771hus;
        Sun, 16 Apr 2006 11:03:03 -0700 (PDT)
Received: by 10.78.46.14 with HTTP; Sun, 16 Apr 2006 11:03:03 -0700 (PDT)
Message-ID: <12c511ca0604161103l3013f5f1t99c93ee38f102e95@mail.gmail.com>
Date:	Sun, 16 Apr 2006 11:03:03 -0700
From:	"Tony Luck" <tony.luck@intel.com>
To:	"Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
Cc:	"Steven Rostedt" <rostedt@goodmis.org>,
	"Paul Mackerras" <paulus@samba.org>,
	"Nick Piggin" <nickpiggin@yahoo.com.au>,
	LKML <linux-kernel@vger.kernel.org>,
	"Andrew Morton" <akpm@osdl.org>,
	"Linus Torvalds" <torvalds@osdl.org>,
	"Ingo Molnar" <mingo@elte.hu>,
	"Thomas Gleixner" <tglx@linutronix.de>, "Andi Kleen" <ak@suse.de>,
	"Martin Mares" <mj@atrey.karlin.mff.cuni.cz>, bjornw@axis.com,
	schwidefsky@de.ibm.com, benedict.gaster@superh.com,
	lethal@linux-sh.org, "Chris Zankel" <chris@zankel.net>,
	"Marc Gauthier" <marc@tensilica.com>,
	"Joe Taylor" <joe@tensilica.com>,
	"David Mosberger-Tang" <davidm@hpl.hp.com>, rth@twiddle.net,
	spyro@f2s.com, starvik@axis.com, linux-ia64@vger.kernel.org,
	ralf@linux-mips.org, linux-mips@linux-mips.org,
	grundler@parisc-linux.org, parisc-linux@parisc-linux.org,
	linuxppc-dev@ozlabs.org, linux390@de.ibm.com, davem@davemloft.net,
	rusty@rustcorp.com.au
In-Reply-To: <200604161734.20256.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <1145049535.1336.128.camel@localhost.localdomain>
	 <17473.60411.690686.714791@cargo.ozlabs.ibm.com>
	 <1145194804.27407.103.camel@localhost.localdomain>
	 <200604161734.20256.arnd@arndb.de>
Return-Path: <tony.luck@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11121
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tony.luck@intel.com
Precedence: bulk
X-list: linux-mips

On 4/16/06, Arnd Bergmann <arnd@arndb.de> wrote:
> #define PER_CPU_BASE 0xe000000000000000UL /* arch dependant */

On ia64 the percpu area is at 0xffffffffffff0000 so that it can be
addressed without tying up another register (all percpu addresses
are small negative offsets from "r0").  When David Mosberger
chose this address he said that gcc 4 would actually make
ue of this, but I haven't checked the generated code to see
whether it really is doing so.

-Tony
