Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0EEcWf09969
	for linux-mips-outgoing; Mon, 14 Jan 2002 06:38:32 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0EEcJg09965
	for <linux-mips@oss.sgi.com>; Mon, 14 Jan 2002 06:38:21 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA18448;
	Mon, 14 Jan 2002 14:37:22 +0100 (MET)
Date: Mon, 14 Jan 2002 14:37:22 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Kevin D. Kissell" <kevink@mips.com>
cc: Dominic Sweetman <dom@algor.co.uk>, Matthew Dharm <mdharm@momenco.com>,
   linux-mips@oss.sgi.com
Subject: Re: MIPS64 status?
In-Reply-To: <00ee01c19cfa$ab8d3640$0deca8c0@Ulysses>
Message-ID: <Pine.GSO.3.96.1020114140333.16706A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 14 Jan 2002, Kevin D. Kissell wrote:

> Careful, Dom.  As far as user-mode programs are concerned,
> older 64-bit MIPS designs (R4xxxx/R5xxxx/R7xxxx), one cannot
> enable 64-bit arithmetic without enabling 64-bit addressing,
> both of these functions being enabled by the Status.UX bit.
> SGI's IRIX OS allowed an execution model that provided
> 64-bit registers and math, while *simulating* a 32-bit address
> space, based on sign-extending 32-bit addresses to 64-bits.
> The user was spared doubling the footprint of all his pointers,
> but the OS still had to manage the larger page tables.

 Note that there is usually no point in using a 64D/32A mode unless you
have weird toolchain problems.  You may get a 64D/32A user program by
mapping its segments appropriately in the 31-bit address space.  Since the
MIPS user segment always starts at zero such a program won't see a
difference between a 64D/32A and a 64D/64A mode.

 Why would an OS need larger page tables?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
