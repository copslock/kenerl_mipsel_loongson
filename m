Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Mar 2004 18:39:44 +0000 (GMT)
Received: from [IPv6:::ffff:138.238.147.152] ([IPv6:::ffff:138.238.147.152]:55819
	"EHLO davis.howard.edu") by linux-mips.org with ESMTP
	id <S8225226AbUCESjm>; Fri, 5 Mar 2004 18:39:42 +0000
Received: by davis.howard.edu with Internet Mail Service (5.5.2657.72)
	id <FD6NJNBV>; Fri, 5 Mar 2004 13:39:11 -0500
Message-ID: <012CF7B248DA774B8F93F0F6DBC4AB112B0365@davis.howard.edu>
From: "Williams, Eric A" <eawilliams@howard.edu>
To: 'Ralf Baechle ' <ralf@linux-mips.org>,
	"'blegand@scs.howard.edu'" <blegand@scs.howard.edu>
Cc: "''linux-mips@linux-mips.org' '" <linux-mips@linux-mips.org>
Subject: RE: DHCP/TFTP PROM error (F_magic 0x5330)
Date: Fri, 5 Mar 2004 13:39:08 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <eawilliams@howard.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4487
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eawilliams@howard.edu
Precedence: bulk
X-list: linux-mips

Ok thanks Ralf for your quick response. 

How can I go about getting red hat linux ecoff binaries for my Indy 
Prom version: PROM Monitor SGI Version 5.3 Rev B10 R4X00/R5000 IP24 Feb 12,
1996 (BE). 

I also had 'sash' (ver 6.2) on the machine--thought sash knew how to boot
ELF binaries, but I got the same error (execute format error).

Let me know what should be my next step to resolve this issue.

-----Original Message-----
From: Ralf Baechle
To: Williams, Eric A
Cc: 'linux-mips@linux-mips.org'
Sent: 3/5/04 9:41 AM
Subject: Re: DHCP/TFTP PROM error (F_magic 0x5330)

On Thu, Mar 04, 2004 at 12:02:58PM -0500, Williams, Eric A wrote:

> Anyone can give me insight as to what the error means.
> 
> Illegal F_magic number 0x5330, expected MIPSELMAGIC or MIPSEBMAGIC

You're feeding ELF to a machine that is expecting ECOFF binaries.
That's
a very old Indy firmware it seems.

  Ralf
