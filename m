Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g54Hg6nC002349
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 4 Jun 2002 10:42:06 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g54Hg6Ls002348
	for linux-mips-outgoing; Tue, 4 Jun 2002 10:42:06 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from ns.snowman.net (ns.snowman.net [63.80.4.34])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g54HfmnC002341;
	Tue, 4 Jun 2002 10:41:48 -0700
Received: from ns.snowman.net (localhost [127.0.0.1])
	by ns.snowman.net (8.12.3/8.12.3/Debian -4) with ESMTP id g54HfZjT003477
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=FAIL);
	Tue, 4 Jun 2002 13:41:36 -0400
From: nick@snowman.net
Received: from localhost (nick@localhost)
	by ns.snowman.net (8.12.3/8.12.3/Debian -4) with ESMTP id g54HfZtO003471;
	Tue, 4 Jun 2002 13:41:35 -0400
X-Authentication-Warning: ns.snowman.net: nick owned process doing -bs
Date: Tue, 4 Jun 2002 13:41:34 -0400 (EDT)
X-Sender: nick@ns
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
cc: Ralf Baechle <ralf@oss.sgi.com>, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   "Gleb O. Raiko" <raiko@niisi.msk.ru>, Jun Sun <jsun@mvista.com>,
   Alexandr Andreev <andreev@niisi.msk.ru>, linux-mips@oss.sgi.com
Subject: Re: 3 questions about linux-2.4.18 and R3000
In-Reply-To: <20020603235311.GJ23411@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.LNX.4.21.0206041341130.31816-100000@ns>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Do you have gfx working on i2 impact?  Is it also an R10k system, or are
you useing an r4k system?
	Thanks
		Nick

On Tue, 4 Jun 2002, Thiemo Seufer wrote:

> Ralf Baechle wrote:
> > On Tue, Jun 04, 2002 at 01:11:18AM +0200, Thiemo Seufer wrote:
> > 
> > > > Wonderful.  Due to the hackish way we're using to build 64-bit kernels
> > > > for the currently supported targets we don't run into this problems,
> > > > there are no R_MIPS_HIGHEST relocs ever.
> > > 
> > > Well, for my I2 Impact I do. :-) I hope to get it running again with
> > > the current kernel (plus my patches) in the next days.
> > 
> > Interesting.  So you don't place the kernel into any of the 32-bit
> > compatibility address spaces on that machine?
> 
> Load address is 0xa800000020002000 (and my diff against CVS > 300k). :-)
> I'm busy because of Linuxtag now, I think I have time to provide some
> parts of this in about two weeks.
> 
> 
> Thiemo
> 
