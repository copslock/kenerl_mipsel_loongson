Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 May 2006 19:55:54 +0200 (CEST)
Received: from bender.bawue.de ([193.7.176.20]:45498 "HELO bender.bawue.de")
	by ftp.linux-mips.org with SMTP id S8133485AbWEPRzq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 16 May 2006 19:55:46 +0200
Received: from lagash (unknown [194.74.144.146])
	by bender.bawue.de (Postfix) with ESMTP
	id 1B7C24458B; Tue, 16 May 2006 19:55:43 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1Fg3lE-0007pF-HP; Tue, 16 May 2006 18:55:08 +0100
Date:	Tue, 16 May 2006 18:55:08 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] fix interrupt handling for R2 CPUs
Message-ID: <20060516175508.GH11370@networkno.de>
References: <20060515172747.GF9026@networkno.de> <20060516174848.GA30064@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060516174848.GA30064@linux-mips.org>
User-Agent: Mutt/1.5.11+cvs20060403
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11453
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Mon, May 15, 2006 at 06:27:47PM +0100, Thiemo Seufer wrote:
> 
> > a) only the low bit is used for status flags if CONFIG_CPU_MIPSR2,
> >    consistent with the use of di/ei.
> > 
> > b) the ERL/EXL bits get cleared as well.
> 
> Does this patch make a difference for you anywhere?

It fixes a MIPS32R2-compiled qemu kernel for me which broke when the
new bitfield instructions were added.


Thiemo
