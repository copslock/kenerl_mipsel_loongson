Received:  by oss.sgi.com id <S42281AbQHIVgF>;
	Wed, 9 Aug 2000 14:36:05 -0700
Received: from u-22.karlsruhe.ipdial.viaginterkom.de ([62.180.19.22]:37125
        "EHLO u-22.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42279AbQHIVfa>; Wed, 9 Aug 2000 14:35:30 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868943AbQHIQN5>;
        Wed, 9 Aug 2000 18:13:57 +0200
Date:   Wed, 9 Aug 2000 18:13:57 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:     "Gleb O. Raiko" <raiko@niisi.msk.ru>,
        Ralf Baechle <ralf@uni-koblenz.de>,
        Harald Koerfgen <Harald.Koerfgen@home.ivm.de>,
        Craig P Prescott <prescott@phys.ufl.edu>, linux-mips@fnet.fr,
        linux-mips@oss.sgi.com
Subject: Re: BREAK and magic SysRq handling for Z8530
Message-ID: <20000809181357.B10906@bacchus.dhis.org>
References: <39911193.672C7E59@niisi.msk.ru> <Pine.GSO.3.96.1000809110212.11080A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.GSO.3.96.1000809110212.11080A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Aug 09, 2000 at 11:38:37AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Aug 09, 2000 at 11:38:37AM +0200, Maciej W. Rozycki wrote:

>  It's actually the reverse. ;-)  Without these (oh well, sunkbd.c is for
> completeness, indeed) you cannot compile-in the magic SysRq support if you
> do not include the virtual terminal driver.  This is an unnecessary
> limitation -- I don't want the VT (well, actually I would, if I had a
> driver for my console, but I haven't, yet). 
> 
>  Such changes actually went into the Linus' 2.4.0-test6-pre* (but not mine
> -- someone overtook me, and he also missed one bit ;-) ).

That probably where Prumpf's changes; I recently discussed various problem
with SysRq with him.  I guess he only tried to fix the HP part of the
problem.

  Ralf
