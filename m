Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4J40dY15820
	for linux-mips-outgoing; Fri, 18 May 2001 21:00:39 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4J40YF15817
	for <linux-mips@oss.sgi.com>; Fri, 18 May 2001 21:00:35 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f4J3oI901384;
	Sat, 19 May 2001 00:50:18 -0300
Date: Sat, 19 May 2001 00:50:18 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: Wayne Gowcher <wgowcher@yahoo.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Netscape on linux-mipsel ??
Message-ID: <20010519005018.C1209@bacchus.dhis.org>
References: <3AFB04FF.353198C6@mvista.com> <20010518202342.25982.qmail@web11908.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010518202342.25982.qmail@web11908.mail.yahoo.com>; from wgowcher@yahoo.com on Fri, May 18, 2001 at 01:23:42PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, May 18, 2001 at 01:23:42PM -0700, Wayne Gowcher wrote:

> Does anyone know if Netscape or any other browser has
> been compiled to run on linux mipsel ? All I can find
> so far are "x86" source for netscape.
> 
> If it has, care to tell me the links where I may get
> it ?
> 
> Alternatively, if no one knows of anyone having a
> working linux mipsel Netscape binary / rpm. Anyone
> care to guess the scope of attempting to modify the
> x86 or mips-sgi-irix sources to run on mips ?

If you check more exactly you'll find that all the sources are actually
binaries ...

I had Mozilla running on Linux/MIPS three years ago but didn't continue
to debug it.  Getting it to work shouldn't be rocket science.  The text
mode browsers lynx, w3m or link just work.

  Ralf
