Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5E4ThQ20151
	for linux-mips-outgoing; Wed, 13 Jun 2001 21:29:43 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5E4TfP20147
	for <linux-mips@oss.sgi.com>; Wed, 13 Jun 2001 21:29:41 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id B690F125BA; Wed, 13 Jun 2001 21:29:40 -0700 (PDT)
Date: Wed, 13 Jun 2001 21:29:40 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: gcc@gcc.gnu.org, binutils@sourceware.cygnus.com, linux-mips@oss.sgi.com
Subject: DWARF2 exception doesn't work with gcc and gas on MIPS.
Message-ID: <20010613212940.A22683@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

In the MIPS gas, there is

    case M_JAL_A:
      if (mips_pic == NO_PIC)
	macro_build ((char *) NULL, &icnt, &offset_expr, "jal", "a");
      else if (mips_pic == SVR4_PIC)
	{
	  /* If this is a reference to an external symbol, and we are
	     using a small GOT, we want
	       lw	$25,<sym>($gp)		(BFD_RELOC_MIPS_CALL16)
	       nop
	       jalr	$25
	       nop
	       lw	$gp,cprestore($sp)
	     The cprestore value is set using the .cprestore
	     pseudo-op.  If we are using a big GOT, we want
	       lui	$25,<sym>		(BFD_RELOC_MIPS_CALL_HI16)
	       addu	$25,$25,$gp
	       lw	$25,<sym>($25)		(BFD_RELOC_MIPS_CALL_LO16)
	       nop
	       jalr	$25
	       nop
	       lw	$gp,cprestore($sp)
	     If the symbol is not external, we want
	       lw	$25,<sym>($gp)		(BFD_RELOC_MIPS_GOT16)
	       nop
	       addiu	$25,$25,<sym>		(BFD_RELOC_LO16)
	       jalr	$25
	       nop
	       lw $gp,cprestore($sp) */

When gcc emits

$LEHB5:
        la      $25,foobar
        jal     $31,$25 
$LEHE5:

It doesn't work since

        jal     $31,$25 

is expanded to

	jalr	$25
	nop
	lw	$gp,cprestore($sp)

Now we have

$LEHB5:
        la      $25,foobar
	jalr	$25
	nop
	lw	$gp,cprestore($sp)
$LEHE5:

When foobar throws an exception, GP won't get restored. What we want is

$LEHB5:
        la      $25,foobar
	jalr	$25
	nop
$LEHE5:
	lw	$gp,cprestore($sp)

Does anyone have any suggestions how to fix it?

Thanks.


H.J.
