Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5RCJxnC014864
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 27 Jun 2002 05:19:59 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5RCJxkS014863
	for linux-mips-outgoing; Thu, 27 Jun 2002 05:19:59 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5RCJjnC014860;
	Thu, 27 Jun 2002 05:19:46 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA22525;
	Thu, 27 Jun 2002 14:21:31 +0200 (MET DST)
Date: Thu, 27 Jun 2002 14:21:30 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ladislav Michl <ladis@psi.cz>
cc: Guido Guenther <agx@sigxcpu.org>, Ralf Baechle <ralf@oss.sgi.com>,
   linux-mips@oss.sgi.com
Subject: Re: [patch] GIO bus support
In-Reply-To: <20020626205956.GA2079@kopretinka>
Message-ID: <Pine.GSO.3.96.1020627140152.21496C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 26 Jun 2002, Ladislav Michl wrote:

> +int be_ip22_handler(struct pt_regs *regs, int is_fixup)
> +{
> +	save_and_clear_buserr();
> +	if (nofault) {
> +		nofault = 0;
> +		compute_return_epc(regs);
> +		return MIPS_BE_DISCARD;
> +	}
> +	return MIPS_BE_FIXUP;
> +}

 I wouldn't use nofault -- it leads to reentrancy problems and I don't
think you really need it.  You probably need to code it like this:

{
	save_and_clear_buserr();

	return is_fixup ? MIPS_BE_FIXUP : MIPS_BE_FATAL;
}

unless:

1. There is a condition when for is_fixup true you should ignore the fixup
anyway (e.g. what the bus error logic reports is irrelevant to fixups). 
You should choose between MIPS_BE_FATAL and MIPS_BE_DISCARD then. 

2. There is a condition when for is_fixup false, an error is not fatal and
execution should get restarted.  You should return MIPS_BE_DISCARD then.


> +int ip22_baddr(unsigned int *val, unsigned long addr)
> +{
> +	nofault = 1;
> +	*val = *(volatile unsigned int *) addr;
> +	__asm__ __volatile__("nop;nop;nop;nop");
> +	if (nofault) {
> +		nofault = 0;
> +		return 0;
> +	}
> +	return -EFAULT;
> +}

 Why not simply:

{
	int err;

	err = get_dbe(*val, (volatile unsigned int *) addr);

	return err ? -EFAULT : 0;
}

It was designed exactly for this purpose.  You may consider using "u32" 
instead of "unsigned int" for hardware accesses to assure the type will
always be 32-bit.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
