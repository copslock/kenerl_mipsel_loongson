Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5CBrLK31234
	for linux-mips-outgoing; Tue, 12 Jun 2001 04:53:21 -0700
Received: from dea.waldorf-gmbh.de (u-243-10.karlsruhe.ipdial.viaginterkom.de [62.180.10.243])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5CBrIV31228
	for <linux-mips@oss.sgi.com>; Tue, 12 Jun 2001 04:53:19 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f5CBr6G26225;
	Tue, 12 Jun 2001 13:53:06 +0200
Date: Tue, 12 Jun 2001 13:53:06 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Florian Lohoff <flo@rfc822.org>
Cc: Raoul Borenius <borenius@shuttle.de>, linux-mips@oss.sgi.com
Subject: Re: Kernel crash on boot with current cvs (todays)
Message-ID: <20010612135306.A26214@bacchus.dhis.org>
References: <20010611000359.A25631@paradigm.rfc822.org> <20010611064249.A15039@bacchus.dhis.org> <20010611165019.A17263@bunny.shuttle.de> <20010612120927.B8798@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010612120927.B8798@paradigm.rfc822.org>; from flo@rfc822.org on Tue, Jun 12, 2001 at 12:09:27PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jun 12, 2001 at 12:09:27PM +0200, Florian Lohoff wrote:

> I got a hint that it might be the compile to produce this bug - I was
> suggested to use some gcc 3.0 prerelease. I now checked again and i am
> already using some gcc 3.0

It's not a tool related bug but a genuine kernel bug in our semaphore code.
Which - unfortunately is a bit of headache to fix but is more or less the #1
on the list of my instabilities right now.

  Ralf
