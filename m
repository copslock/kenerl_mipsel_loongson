Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Apr 2004 08:18:26 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:5787 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225397AbUDXHSI>; Sat, 24 Apr 2004 08:18:08 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id F035E4AEA0; Sat, 24 Apr 2004 09:18:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id CEB41474B6; Sat, 24 Apr 2004 09:18:00 +0200 (CEST)
Date: Sat, 24 Apr 2004 09:18:00 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
Cc: linux-mips@linux-mips.org
Subject: Re: 32-bit ABI
In-Reply-To: <Pine.GSO.4.10.10404240825540.10762-100000@helios.et.put.poznan.pl>
Message-ID: <Pine.LNX.4.55.0404240855580.14494@jurand.ds.pg.gda.pl>
References: <Pine.GSO.4.10.10404240825540.10762-100000@helios.et.put.poznan.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4868
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Sat, 24 Apr 2004, Stanislaw Skowronek wrote:

> why do we attempt to compile the kernel with 32-bit GAS abi and 64-bit GCC
> abi? Is it because the module loader is broken and supports only 32-bit
> ELFs? Then what about machines which load their kernels at weird 64-bit
> addresses, like 0xa800000020004000 (Octane)?

1. Backward compatibility.  Old versions of gas/ld were buggy or
non-functional (depending on the version used) when using the (n)64 ABI.  
Search the mailing list archives -- I'm pretty sure anything since
2.13.2.1 should be safe, though.

2. Using the o32 ABI makes the binary smaller due to 32-bit pointers.  If
used without care, it can lead to pointer crops, though.  Anyway, some
people say it's important for them, despite the associated hassle.

> I have changed it to 64-bit abi in my Octane kernel, because it won't even
> compile otherwise. I've got gcc 3.3.2, gas 2.14.

 I know.  I build using (n)64 consistently for two years successfully --
it's OK even with gcc 2.95.x.  Making a choice between the ABIs for gas
user-selectable is on my to-do list for some time.  For now I think `make
gas-abi=64 ...' is probably the easiest workaround, though you'll need to
objcopy the resulting image to a 32-bit ELF file manually if your firmware
or loader cannot cope with 64-bit ELF binaries.  Well, I don't like the
automatic copy anyway -- it wastes too much disk space in the long run;
perhaps as a compromise it should be user-selectable, too (ditto about
SREC).

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
