Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1KFkwf16994
	for linux-mips-outgoing; Wed, 20 Feb 2002 07:46:58 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1KFkk916990;
	Wed, 20 Feb 2002 07:46:46 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA08601;
	Wed, 20 Feb 2002 15:46:32 +0100 (MET)
Date: Wed, 20 Feb 2002 15:46:32 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Jun Sun <jsun@mvista.com>, "Kevin D. Kissell" <kevink@mips.com>,
   linux-mips@oss.sgi.com
Subject: Re: FPU emulator unsafe for SMP?
In-Reply-To: <20020220140917.C15588@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1020220153608.5781A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 20 Feb 2002, Ralf Baechle wrote:

> The context register is actually intended to be used for indexing a flat
> 4mb array of pagetables on a 32-bit processor.  It's a bit ill-defined
> on R4000-class processors as it assumes a size of 8 bytes per pte, so
> cannot be used in the Linux/MIPS kernel without shifting bits around.

 Ill???  I think someone was just longsighted enough not to limit PTEs to
38-bit physical addresses.  A shift costs a single cycle if we want to
save memory. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
