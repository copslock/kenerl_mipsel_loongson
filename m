Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6EHGeP27870
	for linux-mips-outgoing; Sat, 14 Jul 2001 10:16:40 -0700
Received: from mailgate3.cinetic.de (mailgate3.cinetic.de [212.227.116.80])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6EHGaV27867;
	Sat, 14 Jul 2001 10:16:37 -0700
Received: from smtp.web.de (smtp01.web.de [194.45.170.210])
	by mailgate3.cinetic.de (8.11.2/8.11.2/SuSE Linux 8.11.0-0.4) with SMTP id f6EHGYg23799;
	Sat, 14 Jul 2001 19:16:34 +0200
Received: from intel by smtp.web.de with smtp
	(freemail 4.2.2.2 #11) id m15LT1t-007oGwC; Sat, 14 Jul 2001 19:16 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
From: Harald Koerfgen <hkoerfg@web.de>
Organization: none to speak of
To: Ralf Baechle <ralf@oss.sgi.com>, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Subject: Re: ll/sc emulation patch
Date: Sat, 14 Jul 2001 19:19:37 +0200
X-Mailer: KMail [version 1.2]
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-mips@oss.sgi.com,
   linux-mips@fnet.fr
References: <20010712224520.C23062@bacchus.dhis.org> <Pine.GSO.3.96.1010713124802.3193B-100000@delta.ds2.pg.gda.pl> <20010714125312.A6713@bacchus.dhis.org>
In-Reply-To: <20010714125312.A6713@bacchus.dhis.org>
MIME-Version: 1.0
Message-Id: <01071419193700.00504@intel>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Saturday 14 July 2001 12:53, Ralf Baechle wrote:
> I'm just making an attempt to re-implement the ll/sc emulation as light
> as possible.  I hope to get the overhead down to the point were we don't
> need _test_and_set anymore - in any case below the overhead of a syscall.

I'd love to see something like that. What 's your idea?


Greetings,
Harald
-- 
There is no distinctly native American criminal class except Congress.
		-- Mark Twain
