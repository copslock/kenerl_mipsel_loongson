Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f48Junj28735
	for linux-mips-outgoing; Tue, 8 May 2001 12:56:49 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f48JiBF27611
	for <linux-mips@oss.sgi.com>; Tue, 8 May 2001 12:46:39 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id VAA06088;
	Tue, 8 May 2001 21:34:23 +0200 (MET DST)
Date: Tue, 8 May 2001 21:34:22 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: linux-mips@oss.sgi.com
Subject: Re: machine types for MIPS in ELF file
In-Reply-To: <3AF843F7.72BC47F0@mvista.com>
Message-ID: <Pine.GSO.3.96.1010508211713.4713A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 8 May 2001, Jun Sun wrote:

> The e_machine field in ELF file standard defines two values for MIPS:
> 
> 8	- MIPS RS3000 BE
> 10	- MIPS RS4000 BE
> 
> Naturally the question is: what about LE binaries?  And what about other
> CPUs?  Is there any effort to clean up this thing?

 The latter has been changed to "MIPS RS3000 LE" in the latest ELF spec,
AFAIK.  The ISA level is further specified in the e_flags field.  No idea
why they want to keep redundant endianness information in e_machine --
there is an endianness specification at e_ident[5]. 

 Also no idea why they named the CPU RS3000 and not R3000. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
