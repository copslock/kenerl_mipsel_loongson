Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g158UXm00513
	for linux-mips-outgoing; Tue, 5 Feb 2002 00:30:33 -0800
Received: from dea.linux-mips.net (a1as18-p231.stg.tli.de [195.252.193.231])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g158UUA00503
	for <linux-mips@oss.sgi.com>; Tue, 5 Feb 2002 00:30:30 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g158SBn02688;
	Tue, 5 Feb 2002 09:28:11 +0100
Date: Tue, 5 Feb 2002 09:28:11 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jay Carlson <nop@nop.com>
Cc: Dominic Sweetman <dom@algor.co.uk>,
   Hiroyuki Machida <machida@sm.sony.co.jp>, hjl@lucon.org,
   linux-mips@oss.sgi.com
Subject: Re: PATCH: Fix ll/sc for mips (take 3)
Message-ID: <20020205092811.C2582@dea.linux-mips.net>
References: <15454.21812.39310.478616@gladsmuir.algor.co.uk> <EEAA28A0-19FF-11D6-927F-0030658AB11E@nop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <EEAA28A0-19FF-11D6-927F-0030658AB11E@nop.com>; from nop@nop.com on Tue, Feb 05, 2002 at 01:16:46AM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Feb 05, 2002 at 01:16:46AM -0500, Jay Carlson wrote:

> Given that I tossed out the SVR4 ABI in search of code density in snow, 
> I'm probably a little abnormal in these concerns.  But other people on 
> small platforms may care.

SNOW certainly was a nice invention and the definition of small is
changing.  Are you planning to keep up the support for SNOW?

   Ralf
