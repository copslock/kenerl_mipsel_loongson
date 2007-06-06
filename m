Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2007 02:34:16 +0100 (BST)
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:32893 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20021982AbXFFBeN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 Jun 2007 02:34:13 +0100
Received: (qmail 30650 invoked from network); 6 Jun 2007 01:33:07 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:Received:Date:From:To:Subject:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=4KIj5DJaGkJ5QyB8ow8LY7hxaJUMCPSHb0JqCxdv9wbYTznEWhxsTXlSZRWSbB4yZ85T0A1jMQIf8dbmVZHKA4OGnTMTnbwGPlG3OCn5i6t0ZcRXqXj0B8TtshuZE5Yoy5JzM2v6/XVcDAhdk9EbefN6dRx0PoYWeqNmC5D3E2o=  ;
Received: from unknown (HELO adsl-69-226-248-13.dsl.pltn13.pacbell.net) (david-b@pacbell.net@69.226.212.132 with login)
  by smtp109.sbc.mail.mud.yahoo.com with SMTP; 6 Jun 2007 01:33:06 -0000
X-YMail-OSG: Ds4aQqkVM1ntyUvuOj9LPwyyjNeU61MRjLcMoFNVTttHuwdlChBTlNbFCn5Sffcakf8YFR3oFA--
Received: by adsl-69-226-248-13.dsl.pltn13.pacbell.net (Postfix, from userid 500)
	id 058F0230A73; Tue,  5 Jun 2007 18:32:43 -0700 (PDT)
Date:	Tue, 05 Jun 2007 18:32:43 -0700
From:	David Brownell <david-b@pacbell.net>
To:	stjeanma@pmc-sierra.com, gregkh@suse.de
Subject: Re: [PATCH 11/12] drivers: PMC MSP71xx USB driver
Cc:	linux-usb-devel@lists.sourceforge.net, linux-mips@linux-mips.org,
	akpm@linux-foundation.org
References: <200706060048.l560moU4007288@pasqua.pmc-sierra.bc.ca>
In-Reply-To: <200706060048.l560moU4007288@pasqua.pmc-sierra.bc.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20070606013243.058F0230A73@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Return-Path: <david-b@pacbell.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15261
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david-b@pacbell.net
Precedence: bulk
X-list: linux-mips

[ $SUBJECT is getting less accurate... ]

There are already big-endian support patches for EHCI in the USB queue.

I strongly suspect this patch will clash with those.  For example,
they obviously don't cope with mixed configuration systems, where
an SOC includes big-endian EHCI registers but there's also PCI which
is "normal"-endian.  The register accessors all accept a handle to
the host controller, so they can figure out which byte sex to use
on an access-by-access basis if the system needs that...


Another split you need to do:  the usb/core/hub.c stuff should
be a patch in its own right.  But hmm, wait ... that looks like
it mirrors something done in another EHCI patch that's already
in the USB queue.  There's some other EHCI silicon that chose the
"software (vs hardware) powers ports off" implementation option.


So you should grab those patches from Greg's queue and redo yours
to match.  Looks like a bunch of the host side work you did has
already been done...

- Dave
