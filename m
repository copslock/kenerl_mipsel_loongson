Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3QIXIwJ020827
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 26 Apr 2002 11:33:18 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3QIXIkb020826
	for linux-mips-outgoing; Fri, 26 Apr 2002 11:33:18 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3QIXCwJ020820;
	Fri, 26 Apr 2002 11:33:12 -0700
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id LAA18441;
	Fri, 26 Apr 2002 11:32:53 -0700
Subject: Re: reiserfs
From: Pete Popov <ppopov@mvista.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips <linux-mips@oss.sgi.com>
In-Reply-To: <Pine.GSO.4.21.0204251011190.1401-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0204251011190.1401-100000@vervain.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3.99 
Date: 26 Apr 2002 11:34:09 -0700
Message-Id: <1019846051.13973.24.camel@zeus>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 2002-04-25 at 01:11, Geert Uytterhoeven wrote:
> On Thu, 25 Apr 2002, Ralf Baechle wrote:
> > On Wed, Apr 24, 2002 at 04:13:06PM -0700, Pete Popov wrote:
> > > Has anyone been able to run reiserfs on big endian systems?
> > 
> > I've seen reports of people running Reiserfs on MIPS but I don't know what
> > endianess.
> 
> Some people run it on PowerPC, which is big endian as far as Linux is
> concerned.

FYI, it turned out to be a toolchain bug (2.95.3). Versions 2.96 and 3.x
work just fine.

Pete
