Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 May 2003 20:29:58 +0100 (BST)
Received: from p508B56B7.dip.t-dialin.net ([IPv6:::ffff:80.139.86.183]:37101
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225206AbTENT34>; Wed, 14 May 2003 20:29:56 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h4EJUZ4P029078;
	Wed, 14 May 2003 21:30:35 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h4EJUWO1029077;
	Wed, 14 May 2003 21:30:32 +0200
Date: Wed, 14 May 2003 21:30:32 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Guido Guenther <agx@sigxcpu.org>, linux-mips@linux-mips.org
Subject: Re: r4k Indigo 1 (was Re: Branch relocation fixing at Kernel-compiling with Debian-toolchain)
Message-ID: <20030514193032.GA26327@linux-mips.org>
References: <20030514123144.52da1d81.achim.hensel@ruhr-uni-bochum.de> <20030514110227.GA8503@falcon.cita.utoronto.ca> <20030514180034.GA13328@linux-mips.org> <20030514183218.GE3889@bogon.ms20.nix> <20030514184224.GA3152@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030514184224.GA3152@bogon.ms20.nix>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2380
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 14, 2003 at 08:42:24PM +0200, Guido Guenther wrote:

> > > Little; however it's know that the machine is relativly similar to the
> > > Indy for example so it seems doable for somebody with enough time.
> > Maybe I'm stating the obvious but good look into Irix's /usr/include
> > helps a lot. It seems to have almost everything in it to get the Indigo
> > going (without serial consoel of course).
> _without_ fb and _with_ serial console only is what I wanted to say.
>  -- Guido

Thta still leaves alot of details open - but yes, it's certainly a step
into the right direction.  And there's always the hope once there is a
start somebody at SGI will throw real docs into our direction ...

  Ralf
