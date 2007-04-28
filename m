Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Apr 2007 04:04:54 +0100 (BST)
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:11928 "HELO
	smtp107.sbc.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20021608AbXD1DEw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 28 Apr 2007 04:04:52 +0100
Received: (qmail 85387 invoked from network); 28 Apr 2007 03:04:44 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=ka5YtlRA8mszOAS0dZ0MlQjW0RyQus2+sjTOavMM3iDTYMy1gD9eWc9KlpykgfdYcaUGjuQ6vPjXw68xScbMq2KStvL6le0wh8Jea3xiX97d6JEIPXCwVGa0ltAPUvQJBXRH1lGxelhlpjHqVPb4ADppAEmJV/LOLAZgqBfuJik=  ;
Received: from unknown (HELO ascent) (david-b@pacbell.net@69.226.223.45 with plain)
  by smtp107.sbc.mail.mud.yahoo.com with SMTP; 28 Apr 2007 03:04:43 -0000
X-YMail-OSG: e5tgwVMVM1mz7vbkUT5meiBLObNfBe0vdxbFrE_J6LQKrnlJeCYEhmIcDUKRAlfbsTim0rUDHQ--
From:	David Brownell <david-b@pacbell.net>
To:	Jan Nikitenko <jan.nikitenko@gmail.com>
Subject: Re: spi: Add support for au1550 spi controller
Date:	Fri, 27 Apr 2007 20:04:41 -0700
User-Agent: KMail/1.9.6
Cc:	spi-devel-general@lists.sourceforge.net, linux-mips@linux-mips.org
References: <46324403.4080606@gmail.com>
In-Reply-To: <46324403.4080606@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200704272004.42164.david-b@pacbell.net>
Return-Path: <david-b@pacbell.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14932
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david-b@pacbell.net
Precedence: bulk
X-list: linux-mips

On Friday 27 April 2007, Jan Nikitenko wrote:

> As the spi clock of the controller depends on main input clock that 
> shall be configured externally, platform data structure for au1550 spi 
> controller driver contains mainclk_hz attribute to define the input 
> clock hz ...

I suppose the only reason this isn't more or less just

	mainclk_hz = clk_get_rate(clk_get(hw->dev, "main"));

is that arch/mips/au1000/* doesn't support <linux/clk.h> yet...

In general I think it's much preferable to support that common
infrastructure than invent alternative solutions.  But I won't
be antisocial and try to hold back this driver on _that_ account!

But I will feel free to point out this particular bit of missing
infrastructure.  I hope that supporting it is on the agenda of
the MIPS subset of the embedded Linux world.  :)

- Dave
