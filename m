Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7DFtcV12013
	for linux-mips-outgoing; Mon, 13 Aug 2001 08:55:38 -0700
Received: from dea.waldorf-gmbh.de (u-86-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.86])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7DFtaj12010
	for <linux-mips@oss.sgi.com>; Mon, 13 Aug 2001 08:55:36 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f7DFrvD02291;
	Mon, 13 Aug 2001 17:53:57 +0200
Date: Mon, 13 Aug 2001 17:53:57 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Harald Koerfgen <hkoerfg@web.de>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.5: Export mips_machtype
Message-ID: <20010813175357.E2228@bacchus.dhis.org>
References: <Pine.GSO.3.96.1010813152457.18279F-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010813152457.18279F-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Aug 13, 2001 at 03:26:23PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Aug 13, 2001 at 03:26:23PM +0200, Maciej W. Rozycki wrote:

>  The following patch exports mips_machtype to modules.  Please apply.

Ok - but I'd like to burry the whole mips_machtype mechanism in 2.5.  To
messy and requires a central authority to allocate machine types.  What
do you think?

  Ralf
