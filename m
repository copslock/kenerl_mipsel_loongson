Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7OFttS17310
	for linux-mips-outgoing; Fri, 24 Aug 2001 08:55:55 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7OFtod17307
	for <linux-mips@oss.sgi.com>; Fri, 24 Aug 2001 08:55:50 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA15866;
	Fri, 24 Aug 2001 17:57:59 +0200 (MET DST)
Date: Fri, 24 Aug 2001 17:57:59 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
cc: Jun Sun <jsun@mvista.com>, linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.5: Export mips_machtype
In-Reply-To: <3B86206C.832A9801@niisi.msk.ru>
Message-ID: <Pine.GSO.3.96.1010824152002.11987C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 24 Aug 2001, Gleb O. Raiko wrote:

> Alpha is easy and simple from my POV, it has just SRM or MILO, kernel at
> fixed location anyway. 

 I mean the way platform-specific backends get installed, not the way each
of the family members get detected.  The firmware is not used beyond the
initial setup stage -- hardware is addressed directly at run time.

> In our case, almost every box has own location for kernel varying from
> 0x80000000 for brave people to 0x80100000 for people who doesn't care
> much about 1 MB :-). (Well, I clearly understand it's firmware
> requirements, not people's preferences. Almost.) Then, various binary
> formats of the kernel image...

 But due to the MIPS design there MUST be RAM starting from the physical
address 0x00000000 as exception vectors are installed at virtual addresses
starting from 0x80000000.  So except for twisted systems that only map a
few kilobytes of memory at 0x00000000 (SGI systems do, I'm told) there
exists an address, say 0x80100000 as you quoted or maybe a different one
which yet needs to be determined, which would suit most if not all
platforms.

 Such a kernel would not be meant to be run as the best one.  It would be
useful for end users to bootstrap a distribution installation at least for
the workstation/server class of MIPS hardware (ditto for MIPS64), but
possibly for certain dedicated one, too.  Given a lot of kernel images
it's not always obvious to the user which one to choose -- remember mid
nineties (pre-modules) whan you had a bunch of distribution kernel images
with different SCSI controllers and possibly network interfaces (think NFS
install) on the i386?  It wasn't nice at all... 

> I personally prefer PPC with its _machine tricks and SPARC for BTFIXUP
> stuff.

 I'm just quoting Alpha since I know it best beside i386 and MIPS.

> However, I doubt whether we could support single kernel image for all
> MIPS boxes. MIPS is typical embedded platform, where standards are
> favourite because there are so many to choose from.

 We could try our best, though. 

> BTW, I remember, Ralf tried to implement CPU type recognition at
> run-time, he dropped his efforts after he realized nobody could use this
> feature because boxes are so different.

 I think Jun's proposal is promising -- just let each vendor provide an
own function to detect own hardware.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
