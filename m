Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g53I6CnC003808
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 3 Jun 2002 11:06:12 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g53I6Crv003807
	for linux-mips-outgoing; Mon, 3 Jun 2002 11:06:12 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g53I66nC003801
	for <linux-mips@oss.sgi.com>; Mon, 3 Jun 2002 11:06:06 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g538taa03126;
	Mon, 3 Jun 2002 01:55:36 -0700
Date: Mon, 3 Jun 2002 01:55:36 -0700
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Cc: Jun Sun <jsun@mvista.com>, Alexandr Andreev <andreev@niisi.msk.ru>,
   linux-mips@oss.sgi.com
Subject: Re: 3 questions about linux-2.4.18 and R3000
Message-ID: <20020603015536.B2832@dea.linux-mips.net>
References: <3CEEBBA9.5070809@niisi.msk.ru> <3CEEAC5F.6010802@mvista.com> <3CF2A17D.6050207@niisi.msk.ru> <3CF3BB4B.504@mvista.com> <3CF745B7.16CD0387@niisi.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3CF745B7.16CD0387@niisi.msk.ru>; from raiko@niisi.msk.ru on Fri, May 31, 2002 at 01:43:19PM +0400
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, May 31, 2002 at 01:43:19PM +0400, Gleb O. Raiko wrote:

> > >> We have been using gcc 2.9.5 and binutils 2.10.x for R3000 CPUs for
> > >> quite a  while with no problems.  It seems newer gcc and binutiles are
> > >> fine too.

Some gcc 3.0 versions definately misscompiles the kernel; anyway 3.0 enjoys
a bad reputation for bugginess and being slow at generating slow code
beyond just the MIPS port, so why both with 3.0.  2.95.4 seems quite
reliable.

> > > I understand, but is there any __official__ recommended versions of these
> > > utils? http://oss.sgi.com/mips/mips-howto.html is out-of-date :(

Send patches.

> > 
> > Who are the "officiers" to decide on __official__ versions? :-)  If you are
> > really uncomfortable with non-official stuff, you might want to consider
> > paying some vendor and I am sure you will be given an "official" version.
> 
> "Official" means "if I report a bug w/o a patch in this list, I don't
> get a message which requests to change the tools". 

> I think, Ralf is the "officier" who decides what the right toolchain is.
> Now, last toolchain Ralf announced was 

Nah, I don't consider myself an officer :-)

> Date:            Fri, 1 Dec 2000 03:06:19 +0100

[embarrasingly old email deleted ...]

The issues with newer toolchains have been discussed at various times on
the list; at this time I don't have a tested toolchain that is usable for
all configurations of the kernel.  Also note that my recommendation of
binutils 2.9.5 is only for the kernel.

Anyway, binutils 2.12 is looking promising so far ...

  Ralf
