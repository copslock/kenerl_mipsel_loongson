Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7DJZYU17736
	for linux-mips-outgoing; Mon, 13 Aug 2001 12:35:34 -0700
Received: from mailgate3.cinetic.de (mailgate3.cinetic.de [212.227.116.80])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7DJZUj17733;
	Mon, 13 Aug 2001 12:35:30 -0700
Received: from smtp.web.de (smtp01.web.de [194.45.170.210])
	by mailgate3.cinetic.de (8.11.2/8.11.2/SuSE Linux 8.11.0-0.4) with SMTP id f7DJZS608675;
	Mon, 13 Aug 2001 21:35:29 +0200
Received: from intel by smtp.web.de with smtp
	(freemail 4.2.2.2 #11) id m15WNUm-007oYqC; Mon, 13 Aug 2001 21:35 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
From: Harald Koerfgen <hkoerfg@web.de>
Organization: none to speak of
To: Ralf Baechle <ralf@oss.sgi.com>, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Subject: Re: [patch] linux 2.4.5: Export mips_machtype
Date: Mon, 13 Aug 2001 21:39:11 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
References: <Pine.GSO.3.96.1010813152457.18279F-100000@delta.ds2.pg.gda.pl> <20010813175357.E2228@bacchus.dhis.org>
In-Reply-To: <20010813175357.E2228@bacchus.dhis.org>
MIME-Version: 1.0
Message-Id: <01081321391100.09809@intel>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Monday 13 August 2001 17:53, Ralf Baechle wrote:
> On Mon, Aug 13, 2001 at 03:26:23PM +0200, Maciej W. Rozycki wrote:
> >  The following patch exports mips_machtype to modules.  Please apply.
>
> Ok - but I'd like to burry the whole mips_machtype mechanism in 2.5.  To
> messy and requires a central authority to allocate machine types.  What
> do you think?

Well, it doesn't neccessarily have to be called mips_machtype, but, yes, we 
would need something similar at least for DECstations.

	Harald
