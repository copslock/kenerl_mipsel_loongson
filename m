Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAQForr08541
	for linux-mips-outgoing; Mon, 26 Nov 2001 07:50:53 -0800
Received: from holomorphy (mail@holomorphy.com [216.36.33.161])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAQFono08536
	for <linux-mips@oss.sgi.com>; Mon, 26 Nov 2001 07:50:49 -0800
Received: from wli by holomorphy with local (Exim 3.31 #1 (Debian))
	id 168N41-0000Nw-00; Mon, 26 Nov 2001 06:48:53 -0800
Date: Mon, 26 Nov 2001 06:48:53 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@oss.sgi.com
Subject: Re: FPU interrupt handler
Message-ID: <20011126064853.K1048@holomorphy.com>
References: <20011125002352.G1048@holomorphy.com> <Pine.GSO.3.96.1011126124533.21598D-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.GSO.3.96.1011126124533.21598D-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Nov 26, 2001 at 12:57:23PM +0100
Organization: The Domain of Holomorphy
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Nov 26, 2001 at 12:57:23PM +0100, Maciej W. Rozycki wrote:
>  Nope, R3k DECstations used to use the FPU emulator unconditionally. :-(
> This would have never got triggered.  An FPU interrupt-to-exception glue
> was non-existent.

Okay, that is at least some relief.

On Mon, Nov 26, 2001 at 12:57:23PM +0100, Maciej W. Rozycki wrote:
>  No need to do anything -- I happened to work on the FPU a bit recently
> and I sent a patch here on Friday that adds the glue, enables the FPU and
> rips the broken code off.  Ralf has already applied the patch. 

Excellent! I'll apply it as well.

On Mon, Nov 26, 2001 at 12:57:23PM +0100, Maciej W. Rozycki wrote:
>  I would *really* appreciate any feedback on DECstation patches I'm
> sending here -- for quite some time I have a feeling I'm the last one to
> run Linux on a DECstation... :-(

Well, I'm a more than willing tester, and perhaps I can even bring some
code to the table in my spare time at some point for the drivers my
system needs help with.


Cheers,
Bill
