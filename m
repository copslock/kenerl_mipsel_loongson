Received:  by oss.sgi.com id <S42281AbQGSWr1>;
	Wed, 19 Jul 2000 15:47:27 -0700
Received: from u-185.karlsruhe.ipdial.viaginterkom.de ([62.180.21.185]:61702
        "EHLO u-185.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42275AbQGSWq7>; Wed, 19 Jul 2000 15:46:59 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S639487AbQGSOIN>;
        Wed, 19 Jul 2000 16:08:13 +0200
Date:   Wed, 19 Jul 2000 16:08:13 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     clemej <clemej@mail.alum.rpi.edu>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Okay, lost
Message-ID: <20000719160813.A13006@bacchus.dhis.org>
References: <200007182323.AA145031220@mail.alum.rpi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200007182323.AA145031220@mail.alum.rpi.edu>; from clemej@mail.alum.rpi.edu on Tue, Jul 18, 2000 at 11:23:22PM -0400
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Jul 18, 2000 at 11:23:22PM -0400, clemej wrote:

> When I was bitten by the infamous '-N' bug, it seems to me the 
> exception I got said "UTLB" in it somewhere.  This one doesn't.
> So maybe that's not the problem.
> 
> And I think I might be being bitten by the same thing.  All 2.4 
> kernels I've tried die with what seems to be a similar error on 
> my Indigo2 (R4400 200Mhz).  I thought I read somewhere something 
> about XZ graphics causing problems and boards should be 
> removed... why? Could this be the cause? I have XZ in my 
> machine.... I want to try a few more things before sounding too 
> many alarms though...

The XZ graphics isn't supported nor do we properly detect and avoid it
which is why the kernel blows up on XZ.  Now, Ulf had the same problem
and as he knows about this issue I guess there is a real problem
hidden behind that ...

  Ralf
