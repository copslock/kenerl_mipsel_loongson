Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jan 2003 13:38:31 +0000 (GMT)
Received: from p508B6BF1.dip.t-dialin.net ([IPv6:::ffff:80.139.107.241]:3818
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8226087AbTAINia>; Thu, 9 Jan 2003 13:38:30 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h09DcMK24074;
	Thu, 9 Jan 2003 14:38:22 +0100
Date: Thu, 9 Jan 2003 14:38:22 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Gilad Benjamini <gilad@riverhead.com>
Cc: linux-mips@linux-mips.org
Subject: Re: ksymoops and 64 bit mips
Message-ID: <20030109143822.A23928@linux-mips.org>
References: <ECEPLLMMNGHMFBLHCLMAGEDGDHAA.gilad@riverhead.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <ECEPLLMMNGHMFBLHCLMAGEDGDHAA.gilad@riverhead.com>; from gilad@riverhead.com on Wed, Jan 08, 2003 at 10:15:19PM +0200
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1107
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 08, 2003 at 10:15:19PM +0200, Gilad Benjamini wrote:

> Initially I got a lot of garbage.
> Upgrdaing to ksymoops 2.4.5 , and using the --truncate=1 and 
> -t elf32-little reduced 
> the amount of garbage, but still all the output shown
> was "No symbol available".
> 
> Any additional things I should do ?

Possibly your ksymoops is get confused by the System.map file.  The vmlinux
file is a 32-bit ELF file but the System.map file contains the addresses
sign-extended to 64-bit.  As a bandaid you can just chop off the high
32-bits of all addresses in System.map.

  Ralf
