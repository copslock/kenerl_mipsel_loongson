Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Feb 2003 11:26:46 +0000 (GMT)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.144.71]:48006
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225196AbTBJL0p>; Mon, 10 Feb 2003 11:26:45 +0000
Received: by honk1.physik.uni-konstanz.de (Postfix, from userid 11053)
	id 5AB632BC2F; Mon, 10 Feb 2003 12:26:45 +0100 (CET)
Date: Mon, 10 Feb 2003 12:26:45 +0100
From: Guido Guenther <agx@gandalf.physik.uni-konstanz.de>
To: Vivien Chappelier <vivienc@nerim.net>, linux-mips@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: Re: porting arcboot
Message-ID: <20030210112645.GA32696@honk.physik.uni-konstanz.de>
References: <20030210034549.GA8408@pureza.melbourne.sgi.com> <Pine.LNX.4.21.0302101120390.1117-100000@melkor> <20030210111330.GA32276@honk.physik.uni-konstanz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030210111330.GA32276@honk.physik.uni-konstanz.de>
User-Agent: Mutt/1.3.28i
Return-Path: <guido@honk1.physik.uni-konstanz.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1376
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@gandalf.physik.uni-konstanz.de
Precedence: bulk
X-list: linux-mips

On Mon, Feb 10, 2003 at 12:13:30PM +0100, Guido Guenther wrote:
> Can't we read the load address (and needed space) from the elf header
s/load address/kernel's load address/
> before InitMalloc? Would be much nicer and we don't need a different
> loader for every subarch.
In case we find a unique place for arcboot in the memory map of the
different subarches.
Regards,
 -- Guido
