Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fARIkMS27790
	for linux-mips-outgoing; Tue, 27 Nov 2001 10:46:22 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fARIivo27759;
	Tue, 27 Nov 2001 10:44:57 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fARHjcB21835;
	Tue, 27 Nov 2001 09:45:38 -0800
Message-ID: <3C03D113.F8980229@mvista.com>
Date: Tue, 27 Nov 2001 09:44:51 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>, linux-mips@oss.sgi.com
Subject: Re: new asm-mips/io.h
References: <20011126.123545.41627333.nemoto@toshiba-tops.co.jp> <20011126200946.A8408@dea.linux-mips.net> <20011127.130406.104026562.nemoto@toshiba-tops.co.jp> <20011127180648.H29424@dea.linux-mips.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:
> 
> On Tue, Nov 27, 2001 at 01:04:06PM +0900, Atsushi Nemoto wrote:
 Not a bad idea in context of fish and chips.
> 
> Well, talk to it's developers before it's too late.  Or as it has already
> happened for some hardware I think we should simply go with your
> suggestion and make all those functions vectors.
> 

I don't know about the details of function vectors, but would imagine it would
be 1) slow, 2)clumsy with extra layer of abstraction and 3) intrusive to the
most common cases which is the current io file.

My suggestion is to have a separate io file for the board, and then add the
following to the beginning of io.h:

/* for tasteless boards */
#if defined(CONFIG_TOSHIBA_TASTELESS)
#define _ASM_IO_H		/* so that we don't include the rest */
#include <asm/toshiba/tasteless_io.h>
#endif

This way not only we have minimum impact to the majority, but also easier to
remove such ad hoc support when toshiba becomes more tasteful.

Jun
