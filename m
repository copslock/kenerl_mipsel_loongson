Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7A1rkQ00897
	for linux-mips-outgoing; Thu, 9 Aug 2001 18:53:46 -0700
Received: from dea.waldorf-gmbh.de (u-219-10.karlsruhe.ipdial.viaginterkom.de [62.180.10.219])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7A1rhV00894
	for <linux-mips@oss.sgi.com>; Thu, 9 Aug 2001 18:53:44 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f7A1qRU23575;
	Fri, 10 Aug 2001 03:52:27 +0200
Date: Fri, 10 Aug 2001 03:52:27 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Salisbury, Roger" <Roger.Salisbury@team.telstra.com>
Cc: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Re: FW: indigo2 kernel build failures
Message-ID: <20010810035227.B23548@bacchus.dhis.org>
References: <C1CCF0351229D311BBEB0008C75B9A8A02CAFACB@ntmsg0080.corpmail.telstra.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <C1CCF0351229D311BBEB0008C75B9A8A02CAFACB@ntmsg0080.corpmail.telstra.com.au>; from Roger.Salisbury@team.telstra.com on Fri, Aug 10, 2001 at 11:21:52AM +1000
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Aug 10, 2001 at 11:21:52AM +1000, Salisbury, Roger wrote:

> > If so what do  i do to fix?

> EG when updating binutils I get:
> > ########################################
> > bash-2.04# pwd
> > /binutils-2.9.5.0.37
> > bash-2.04# ./configure
> > Configuring for a mips-unknown-linux-gnu host.
> > *** This configuration is not supported in the following subdirectories:
> >      gprof
> >     (Any other directories should still work fine.)

As it says - gprof.

  Ralf
