Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4VKOfnC013492
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 31 May 2002 13:24:41 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4VKOfgq013491
	for linux-mips-outgoing; Fri, 31 May 2002 13:24:41 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4VKOdnC013488
	for <linux-mips@oss.sgi.com>; Fri, 31 May 2002 13:24:39 -0700
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id g4VKPu6F009001;
	Fri, 31 May 2002 13:25:56 -0700
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id g4VKPtlQ008997;
	Fri, 31 May 2002 13:25:55 -0700
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Fri, 31 May 2002 13:25:55 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
   Dan Malek <dan@embeddededge.com>, "Kevin D. Kissell" <kevink@mips.com>,
   Jun Sun <jsun@mvista.com>, "Steven J. Hill" <sjhill@realitydiluted.com>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: PCI Graphics/Video Card for Malta Board?
In-Reply-To: <1022676598.4124.165.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0205311324440.3190-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> I've had no problem with Russell King's ARM code.

The problem with older S3 cards is that they have so many different
RAMDACS and often 3rd party PLLs.

> And for the 3dfx
> voodoo2 (UKP 9 off ebay) none at all. The voodoo seems to have always
> been designed to be totally soft configured and as its not a primary
> video card the bios/firmware all leaves it alone

Yeap!! I was reading in the docs how to get voodoo cards to be multihead
freindly :-)
