Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3MLhPQ24840
	for linux-mips-outgoing; Sun, 22 Apr 2001 14:43:25 -0700
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.225])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3MLh9M24831
	for <linux-mips@oss.sgi.com>; Sun, 22 Apr 2001 14:43:24 -0700
Received: from drow by nevyn.them.org with local (Exim 3.22 #1 (Debian))
	id 14rRdR-0000Lw-00; Sun, 22 Apr 2001 17:43:13 -0400
Date: Sun, 22 Apr 2001 17:43:13 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Karsten Merker <karsten@excalibur.cologne.de>
Cc: linux-mips@oss.sgi.com, debian-mips@lists.debian.org
Subject: Re: ls from fileutils-4.0.43 segfaults
Message-ID: <20010422174313.A1342@nevyn.them.org>
References: <20010422224018.A9017@excalibur.cologne.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20010422224018.A9017@excalibur.cologne.de>; from karsten@excalibur.cologne.de on Sun, Apr 22, 2001 at 10:40:18PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Apr 22, 2001 at 10:40:18PM +0200, Karsten Merker wrote:
> Hallo everyone,
> 
> I have tried to install fileutils_4.0.43-1_mipsel.deb from
> source.rfc822.org and found that "ls" segfaults, the other binaries seem
> to be ok. So I have tried compiling it myself against glibc-2.2.2 on
> repeat.rfc822.org and also on my DECstation, but the effect stays the
> same.

Most likely you have a kernel with the sysmips() bug discussed on
linux-mips over the past month and a half or so; the archives have
Florian's workaround and other discussion.

-- 
Daniel Jacobowitz                           Debian GNU/Linux Developer
Monta Vista Software                              Debian Security Team
