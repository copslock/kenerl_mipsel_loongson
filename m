Received:  by oss.sgi.com id <S305189AbPLRN1c>;
	Sat, 18 Dec 1999 05:27:32 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:35178 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305163AbPLRN1K>;
	Sat, 18 Dec 1999 05:27:10 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA09175; Sat, 18 Dec 1999 05:25:12 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id FAA92657
	for linux-list;
	Sat, 18 Dec 1999 05:04:46 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id FAA78186
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 18 Dec 1999 05:04:05 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA02965
	for <linux@cthulhu.engr.sgi.com>; Sat, 18 Dec 1999 05:04:03 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-12.uni-koblenz.de (cacc-12.uni-koblenz.de [141.26.131.12])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id OAA28641;
	Sat, 18 Dec 1999 14:03:57 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407891AbPLRNDa>;
	Sat, 18 Dec 1999 11:03:30 -0200
Date:   Sat, 18 Dec 1999 11:03:30 -0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Khaled Labib <labibk@taec.toshiba.com>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: Milo
Message-ID: <19991218110330.B838@uni-koblenz.de>
References: <199912172008.MAA22757@stafford.taec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <199912172008.MAA22757@stafford.taec.com>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Fri, Dec 17, 1999 at 12:08:51PM -0800, Khaled Labib wrote:

> I am using linux/MIPS kernel v2.2.1 and I am now considering loading it. I 
> looked at the Milo 0.27. 
> 
> There is very little documentation for Milo, basically, a single README
> file.  Can some one point me on where to get more info about Milo. I need
> basically the following:
> 
> 1- How exactly does Milo boot the kernel ?
> 2- Where should the Milo executable reside. On Disk, ROM ...etc. ?

On any medium that is supporte by the ARC firmware implementation.  In
practice that means a TFTP/BOOTP server, CDROM, FAT fs on a local harddisk.

> 3- What functions does Milo perform ?
> 4- Do I still need BIOS support with Milo ?
> 5- What is this ARC firmware ?

Basically a very primitive OS or BIOS for PC-oid brains.

> 6- Where is the latest Milo ?

0.27.1 is the latest, from oss.sgi.com or other places that collect antique
stuff.

> I'll be booting this kernel on a harware Emulator with a limited
> functionality target board. The Target board itself is a PCI-based board
> that sits in a regular PC and contains memory (system memory).
> 
> I would appreciate pointers to information related to the above.

I recommend to not use Milo.  The normal build process will provide you an
ELF kernel binary; with elf2ecoff the kernel sources also provide you with
a tool to convert this into ECOFF.  That is what more than 95% of embedded
and evaluation systems will need.  Milo was only used in the early stages
of Linux/MIPS development has been abandomed like two years ago.

  Ralf
