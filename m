Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g27EIQu28898
	for linux-mips-outgoing; Thu, 7 Mar 2002 06:18:26 -0800
Received: from dea.linux-mips.net (a1as01-p99.stg.tli.de [195.252.185.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g27EIM928893
	for <linux-mips@oss.sgi.com>; Thu, 7 Mar 2002 06:18:22 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g27DIBF03066;
	Thu, 7 Mar 2002 14:18:11 +0100
Date: Thu, 7 Mar 2002 14:18:11 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marc Karasek <marc_karasek@ivivity.com>,
   Linux MIPS <linux-mips@oss.sgi.com>
Subject: Re: Questions?
Message-ID: <20020307141811.A3041@dea.linux-mips.net>
References: <20020307140754.A1817@dea.linux-mips.net> <Pine.GSO.4.21.0203071410460.11036-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0203071410460.11036-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Thu, Mar 07, 2002 at 02:11:50PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Mar 07, 2002 at 02:11:50PM +0100, Geert Uytterhoeven wrote:

> > The MIPS ABI only covers big endian systems - every "real" MIPS UNIX
> > system is big endian.  Everything else is a GNU extension.  There is
> > hardly any reason to choose a particular byteorder as usually endianess
> > swapping takes so little CPU time that it isn't even meassurable but so
> > I'm told there are exceptions.  If portability of software you're
> > going to write wrt. external data representation (disk or network) is
> > of any importance then I suggest you use a system of the opposite
> > endianess which trip problems much faster.
> 
> I really like the last part! ;-)
> 
> BTW, you forgot to mention to go for a full 64-bit port, to trip even more
> problems faster :-)

Fortunately in practice that hasn't been a minefield as big as you'd imagine.

  Ralf
