Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Mar 2003 13:05:38 +0000 (GMT)
Received: from p508B6D77.dip.t-dialin.net ([IPv6:::ffff:80.139.109.119]:14209
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224847AbTCXNFh>; Mon, 24 Mar 2003 13:05:37 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h2OD5U906302;
	Mon, 24 Mar 2003 14:05:30 +0100
Date: Mon, 24 Mar 2003 14:05:30 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Julian Scheel <jscheel@activevb.de>
Cc: linux-mips@linux-mips.org
Subject: Re: Set Registers for VR4181A
Message-ID: <20030324140529.C4959@linux-mips.org>
References: <200303240816.03482.jscheel@activevb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200303240816.03482.jscheel@activevb.de>; from jscheel@activevb.de on Mon, Mar 24, 2003 at 08:16:03AM +0100
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1797
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 24, 2003 at 08:16:03AM +0100, Julian Scheel wrote:

> as I wrote a few weeks ago I have a NEC VR4181A-Board, on which I want to get 
> linux running. Currently I have a kernel which should work, but it can't 
> boot, since linux seems to expect that the registers have been already set by 
> the bootloader. Since the used bootloader is a very small one which only 
> proceeds the given files (written by a friend of me) it didn't do this job, 
> so linux tries to access registers, which are not set yet.

Fixinging the few assumptions that Linus is making about the initializaton
state of the machine should be fairly easy.

  Ralf
