Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Aug 2004 01:50:33 +0100 (BST)
Received: from p508B65A8.dip.t-dialin.net ([IPv6:::ffff:80.139.101.168]:6010
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224907AbUHDAu3>; Wed, 4 Aug 2004 01:50:29 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i740oSHV010510;
	Wed, 4 Aug 2004 02:50:28 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i740oNh7010509;
	Wed, 4 Aug 2004 02:50:23 +0200
Date: Wed, 4 Aug 2004 02:50:23 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Alec Voropay <a.voropay@vmb-service.ru>
Cc: linux-mips@linux-mips.org
Subject: Re: SGI ARC .vs. ACE ARC BIOS
Message-ID: <20040804005023.GA9046@linux-mips.org>
References: <01ed01c47963$bc74a220$1701a8c0@portege>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01ed01c47963$bc74a220$1701a8c0@portege>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5589
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 03, 2004 at 06:11:12PM +0400, Alec Voropay wrote:

>  Can anyone explain a difference between SGI ARC BOOT-PROM
> (sometimes called ARCS) and an old ACE ARC BIOS (Jazz/Magnum) ?
> Is this equal (in functionality, not command line) ?
> 
> P.S.
> http://www.netbsd.org/Documentation/Hardware/Machines/ARC/

ARC is a dead-born standard that standardizes both hardware and firmware.
All implementations violate it more or less.  The whole thing was
originally part of the ACE initiative, which also has developped the
Jazz design to which the Magnum, Acer and others are more or less related.
As I recall the Manum was some sort of reference implementation.  The
hardware specs were rather fuzzy and more or less obsolete from a UNIX
workstation perspective already ten years ago.  Not considering endianess -
SGI ARC(S) is big endian, other firmware is little endian - and for the
little ARC functionality that Linux is using the two can be considered
equivalent.

  Ralf
