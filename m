Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f48LvJX01316
	for linux-mips-outgoing; Tue, 8 May 2001 14:57:19 -0700
Received: from pizda.ninka.net (IDENT:root@pizda.ninka.net [216.101.162.242])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f48LvIF01313
	for <linux-mips@oss.sgi.com>; Tue, 8 May 2001 14:57:18 -0700
Received: (from davem@localhost)
	by pizda.ninka.net (8.9.3/8.9.3) id OAA27905;
	Tue, 8 May 2001 14:54:48 -0700
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15096.27432.381478.837650@pizda.ninka.net>
Date: Tue, 8 May 2001 14:54:48 -0700 (PDT)
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-kernel@vger.kernel.org, linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] 2.4.4: mmap() fails for certain legal requests
In-Reply-To: <Pine.GSO.3.96.1010508232117.4713F-100000@delta.ds2.pg.gda.pl>
References: <15096.23421.564537.144351@pizda.ninka.net>
	<Pine.GSO.3.96.1010508232117.4713F-100000@delta.ds2.pg.gda.pl>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Czesc,

Maciej W. Rozycki writes:
 >  Yep, I know (ia64 and sparc*).  But being lazy enough (and being short on
 > time) I won't do it until I know the idea of the change is accepted.  I'm
 > sorry -- I sent previous versions of the patch twice since last Summer
 > with no response at all and doing bits no one is interested in is a waste
 > of time.
 > 
 >  Thanks for your response, though -- maybe there is someone interested,
 > after all. 

That's pretty arrogant that cut and pasting a few lines into some
architecture specific files and reporting the updated patch is too
much to ask.

Perhaps reviewing your change is also, too much to ask.  Perhaps
we are too lazy and short on time to have a look at your change.

I don't think it's asking a lot to provide a complete change.

I'm sure the MIPS folks know all too well whats it's like when their
port is crapped up because someone only made changes to x86 port
portions.  At least for me on after working on Sparc for some time,
I'm adamant about providing complete changes so that this kind of
grief is avoided for other port maintainers.

In the time you used to compose your response to me, and now
to read this email from me, you could have fixed up the patch
perhaps 2 or 3 times.  Just do it and get it over with ok?

Dziekuje.

Later,
David S. Miller
davem@redhat.com
