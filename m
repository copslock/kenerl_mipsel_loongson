Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f78AJEX03930
	for linux-mips-outgoing; Wed, 8 Aug 2001 03:19:14 -0700
Received: from dea.waldorf-gmbh.de (u-180-20.karlsruhe.ipdial.viaginterkom.de [62.180.20.180])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f78AJ7V03921
	for <linux-mips@oss.sgi.com>; Wed, 8 Aug 2001 03:19:07 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f78AH6902453;
	Wed, 8 Aug 2001 12:17:06 +0200
Date: Wed, 8 Aug 2001 12:17:06 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "J. Scott Kasten" <jsk@tetracon-eng.net>
Cc: Brandon Barker <bebarker@meginc.com>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Indy 64 or 32 bit?
Message-ID: <20010808121706.A602@bacchus.dhis.org>
References: <01080623471400.01828@linux> <Pine.SGI.4.33.0108072030380.20792-100000@thor.tetracon-eng.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.SGI.4.33.0108072030380.20792-100000@thor.tetracon-eng.net>; from jsk@tetracon-eng.net on Tue, Aug 07, 2001 at 08:45:17PM -0400
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Aug 07, 2001 at 08:45:17PM -0400, J. Scott Kasten wrote:

> Well, it's kind of both.  The R4000 and up are 64 bit CPU's capable of
> running either 32 or 64 bit code.  The MIPS address space is a little
> wierd such that you can kinda munge 32 and 64 bit code togeather under the
> right circumstances.

Right circumstances = almost always.  Actually Linux makes sure that it's
indeed always.

> Some of the old hands here could tell you better how Irix behaves on those
> boxes.  I know you can compile code with 64 bit int and pointers and it
> will run on those boxes under Irix, but there is a little more to it than
> that.

That's not supported on all systems.  An Indy for example is limited to
128mb RAM as shipped by SGI (256 with aftermarket parts).  There is no
point in supporting 64-bit address space on such a system and so SGI doesn't
support only N32.

> I've used both linux and Irix on the Indy.  Quite frankly, I would
> consider getting a second HD if cheep enough so that you could keep both
> around.  (Note: don't put 2 high RPM drives in the Indy, or we are talking
> melt down of your pretty blue toy...)

External drives work just fine and can be hidden where their sound isn't so
annoying.

> I've found much to like in Irix in addition to the flexibility of Linux.

Yep and they co-exist nicely.

  Ralf
