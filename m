Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Feb 2003 11:13:33 +0000 (GMT)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.144.71]:46726
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225196AbTBJLNc>; Mon, 10 Feb 2003 11:13:32 +0000
Received: by honk1.physik.uni-konstanz.de (Postfix, from userid 11053)
	id 72FBD2BC2F; Mon, 10 Feb 2003 12:13:30 +0100 (CET)
Date: Mon, 10 Feb 2003 12:13:30 +0100
From: Guido Guenther <agx@gandalf.physik.uni-konstanz.de>
To: Vivien Chappelier <vivienc@nerim.net>
Cc: linux-mips@linux-mips.org
Subject: Re: porting arcboot
Message-ID: <20030210111330.GA32276@honk.physik.uni-konstanz.de>
References: <20030210034549.GA8408@pureza.melbourne.sgi.com> <Pine.LNX.4.21.0302101120390.1117-100000@melkor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0302101120390.1117-100000@melkor>
User-Agent: Mutt/1.3.28i
Return-Path: <guido@honk1.physik.uni-konstanz.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1375
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@gandalf.physik.uni-konstanz.de
Precedence: bulk
X-list: linux-mips

On Mon, Feb 10, 2003 at 11:33:39AM +0100, Vivien Chappelier wrote:
> mention with 64-bit userland. The code is still a bit ugly and I've
> hardcoded a different load address for the O2 (this should be a
> 'configure' option at least), but you might be interested to have a look.
Can't we read the load address (and needed space) from the elf header
before InitMalloc? Would be much nicer and we don't need a different
loader for every subarch.
 -- Guido
