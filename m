Received:  by oss.sgi.com id <S553801AbRAQQuN>;
	Wed, 17 Jan 2001 08:50:13 -0800
Received: from gandalf.physik.uni-konstanz.de ([134.34.144.69]:41230 "EHLO
        gandalf.physik.uni-konstanz.de") by oss.sgi.com with ESMTP
	id <S553792AbRAQQt5>; Wed, 17 Jan 2001 08:49:57 -0800
Received: from agx by gandalf.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 14IvmR-0004VW-00; Wed, 17 Jan 2001 17:49:51 +0100
Date:   Wed, 17 Jan 2001 17:49:51 +0100
From:   Guido Guenther <guido.guenther@gmx.net>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     linux-mips@oss.sgi.com
Subject: Re: patches for dvhtool
Message-ID: <20010117174951.A17176@gandalf.physik.uni-konstanz.de>
References: <20001015021522.B3106@bilbo.physik.uni-konstanz.de> <20010117154937.C2517@paradigm.rfc822.org> <20010117162718.A2447@frodo.physik.uni-konstanz.de> <20010117165152.G2517@paradigm.rfc822.org> <20010117170603.A16624@gandalf.physik.uni-konstanz.de> <20010117173153.H2517@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010117173153.H2517@paradigm.rfc822.org>; from flo@rfc822.org on Wed, Jan 17, 2001 at 05:31:53PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Jan 17, 2001 at 05:31:53PM +0100, Florian Lohoff wrote:
> On Wed, Jan 17, 2001 at 05:06:03PM +0100, Guido Guenther wrote:
> > On Wed, Jan 17, 2001 at 04:51:52PM +0100, Florian Lohoff wrote:
> > [..snip..] 
> > > >> setenv SystemPartition scsi(1)disk(4)rdisk(0)partition(8)
> > > >> boot
> > > 1212416+135264+143084 entry: 0x880025a8                                        
> > Good. Will add that to the howto then.
> 
> BTW: Is there any way of deleteing/renaming files in the
> volume-header-directory ? Is there a way to set "bootfile" ?
Not yet. Only thing you can do is replace files by giving them the same
name as an already existent entry in the volume header. This always
bothered me too. Maybe someone wants to fix that on a 'rainy sunday':)
 -- Guido
