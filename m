Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7GJ9pV04969
	for linux-mips-outgoing; Thu, 16 Aug 2001 12:09:51 -0700
Received: from kuolema.infodrom.north.de (postfix@kuolema.infodrom.north.de [217.89.86.35])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7GJ9jj04966;
	Thu, 16 Aug 2001 12:09:46 -0700
Received: from finlandia.infodrom.north.de (finlandia.Infodrom.North.DE [217.89.86.34])
	by kuolema.infodrom.north.de (Postfix) with ESMTP
	id D69674D73F; Thu, 16 Aug 2001 21:09:34 +0200 (CEST)
Received: from nautilus.noreply.org (unknown [138.232.34.77])
	by finlandia.infodrom.north.de (Postfix) with ESMTP
	id 4EAD310918; Thu, 16 Aug 2001 21:09:29 +0200 (CEST)
Received: by nautilus.noreply.org (Postfix, from userid 10)
	id BCF153581D; Thu, 16 Aug 2001 21:09:18 +0200 (CEST)
Received: by fisch.cyrius.com (Postfix, from userid 1000)
	id 866B222B45; Thu, 16 Aug 2001 21:09:40 +0200 (CEST)
Date: Thu, 16 Aug 2001 21:09:40 +0200
From: Martin Michlmayr <tbm@cyrius.com>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Brian Murphy <brian.murphy@eicon.com>,
   linux-mips@oss.sgi.com
Subject: Re: glibc
Message-ID: <20010816210940.A21001@fisch.cyrius.com>
References: <3B7B8951.B666A175@eicon.com> <E15XNl1-0005C7-00@the-village.bc.nu> <20010816181419.B30997@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010816181419.B30997@bacchus.dhis.org>; from ralf@oss.sgi.com on Thu, Aug 16, 2001 at 06:14:19PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

* Ralf Baechle <ralf@oss.sgi.com> [20010816 18:14]:
> The latest glibc 2.0.6 I was spreading only has MIPS-specific bug
> fixes.  All the other big holes which are indeed big enough to drive
> a nice shipload of trucks through are unfixed.  I haven't noticed
> that any other glibc 2.0 variant floating around has additional
> fixes.
> 
> Nice for Cobalt boxen ...

Debian is being ported to Cobalts.  A base tar ball can be found at
http://www.pocketlinux.com/~samc/debian-cobalt
