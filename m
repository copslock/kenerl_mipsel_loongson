Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Jul 2006 01:20:47 +0100 (BST)
Received: from smtp107.biz.mail.mud.yahoo.com ([68.142.200.255]:38768 "HELO
	smtp107.biz.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133987AbWGZAUe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Jul 2006 01:20:34 +0100
Received: (qmail 13761 invoked from network); 26 Jul 2006 00:20:23 -0000
Received: from unknown (HELO ?192.168.1.107?) (ppopov@embeddedalley.com@71.128.175.242 with plain)
  by smtp107.biz.mail.mud.yahoo.com with SMTP; 26 Jul 2006 00:20:22 -0000
Subject: Re: YAMON: go
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	ashlesha@kenati.com
Cc:	linux-mips@linux-mips.org
In-Reply-To: <1153872862.6478.7.camel@sandbar.kenati.com>
References: <1153872862.6478.7.camel@sandbar.kenati.com>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Tue, 25 Jul 2006 17:20:06 -0700
Message-Id: <1153873206.1824.59.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12071
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Tue, 2006-07-25 at 17:14 -0700, Ashlesha Shintre wrote:
> Hi,
> 
> I compiled an 2.6 kernel for the db1500 board and used the load command
> in YAMON to write the srec image to the RAM using tftp.  Now I want to
> start the kernel and so I issued the go command.  It gives me the
> following error:
> 
> * Exception (user) : Reserved instruction *
> 
> CAUSE    = 0x00808028  STATUS   = 0x00000002
> EPC      = 0x80404004  ERROREPC = 0x00000000
> BADVADDR = 0x00000000

> Also another query is this: How does one know whether the load command
> has written to the RAM or the Flash?  The help load says that this
> depends on the address.  However, upon issuing the load command without
> any options, YAMON outputs the following as the location of the load:
> 
> Start = 0x80404000, range = (0x80100000,0x80423084), format = SREC

... which is a ram address.  SRECs have the load address embedded in
them and the kernel is linked to run from ram.

Are you sure the jumpers on the board are setup to match the kernel
endianness you have compiled? Looks like your kernel crashed pretty
quickly.

Pete
