Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6EB5Df10558
	for linux-mips-outgoing; Sat, 14 Jul 2001 04:05:13 -0700
Received: from dea.waldorf-gmbh.de (u-121-21.karlsruhe.ipdial.viaginterkom.de [62.180.21.121])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6EB59V10555
	for <linux-mips@oss.sgi.com>; Sat, 14 Jul 2001 04:05:10 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6EB4mr06127;
	Sat, 14 Jul 2001 13:04:48 +0200
Date: Sat, 14 Jul 2001 13:04:48 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>, linux-mips@oss.sgi.com
Subject: Re: sti() does not work.
Message-ID: <20010714130448.C6713@bacchus.dhis.org>
References: <20010713133517.C1378@bacchus.dhis.org> <Pine.GSO.3.96.1010713151359.3193D-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010713151359.3193D-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Jul 13, 2001 at 04:01:29PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Jul 13, 2001 at 04:01:29PM +0200, Maciej W. Rozycki wrote:

>  Sure, but sometimes ".set reorder" allows you to achieve better
> optimization across various ISAs without a need to resort to the
> preprocessor.  Consider the following code: 
> 
> 	lw	$1,($2)
> 	addu	$3,$1
> 
> You need an instruction between the two for a MIPS I CPU but MIPS II+ CPUs
> interlock here if no instruction is placed.  Assuming no real instruction
> can be reordered here, a nop must be inserted if the code gets compiled
> for a MIPS I CPU but no instruction is preferred otherwise.  The assembler
> does it automatically if the ".set reorder" directive is active, but you
> need to decide yourself if it is not.
> 
>  Actually with mfc0 there is no problem -- you need a nop in the case like
> the above one as coprocessor transfers never interlock; at least docs
> state so.  But who believes docs without a grain of salt, so please
> correct me if I am wrong (I don't have appropriate hardware to perform a
> test). 

Real wild pig hackers on R3000 were writing code which knows that in the
load delay slot they still have the old register value available.  So you
can implement var1++; var2++ as:

	.set	noreorder
	lw	$reg, var1($gp)
	nop
	addiu	$reg, $reg, 1
	lw	$reg, var2($gp)
	sw	$reg, var1($gp)
	addiu	$reg, $reg, 1
	sw	$reg, var2($gp)

	.common	var1, 4, 4
	.common	var2, 4, 4

Of course only safe with interrupts disabled.  So in a sense introducing
the load interlock broke semantics of MIPS machine code ;-)

  Ralf
