Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0RMeXr28154
	for linux-mips-outgoing; Sun, 27 Jan 2002 14:40:33 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id g0RMeUP28151
	for <linux-mips@oss.sgi.com>; Sun, 27 Jan 2002 14:40:30 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id g0RLeRu16334;
	Sun, 27 Jan 2002 13:40:27 -0800
Date: Sun, 27 Jan 2002 13:40:27 -0800
From: Ralf Baechle <ralf@oss.sgi.com>
To: Soeren Laursen <soeren.laursen@scrooge.dk>
Cc: linux-mips@oss.sgi.com
Subject: Re: SMP support challenge L
Message-ID: <20020127134027.A2129@dea.linux-mips.net>
References: <3C53FC3D.10933.55876D@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C53FC3D.10933.55876D@localhost>; from soeren.laursen@scrooge.dk on Sun, Jan 27, 2002 at 01:10:21PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Jan 27, 2002 at 01:10:21PM +0100, Soeren Laursen wrote:

> Just wondering if the SMP support is working at all. Sometimes
> there are patches that affect the SMP support.
> 
> Got a challenge L with two R4xxx cpu's. Could start working on it
>  via a nft root and give some feed back, fixes etc.
> 
> Just one question. The terminal is broken and a guy at SGI Denmark 
> told me how to create a null modem that worked on the challenge L but 
> I have lost the paper. Any one got a clue?

Null modems are described in a FAQ about the serial interface written by
Christian Blum and others.  Just google for it.  The pinout as used on
various SGI systems is described in IRIX's serial man page which if not
on your system you can also find somewhere online.

  Ralf
