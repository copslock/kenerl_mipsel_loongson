Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g472p2wJ032456
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 6 May 2002 19:51:02 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g472p22C032455
	for linux-mips-outgoing; Mon, 6 May 2002 19:51:02 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from guest (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g472oxwJ032452
	for <linux-mips@oss.sgi.com>; Mon, 6 May 2002 19:50:59 -0700
Received: (from ralf@localhost)
	by guest (8.11.6/8.11.6) id g46Brft29019;
	Mon, 6 May 2002 19:53:41 +0800
Date: Mon, 6 May 2002 19:53:41 +0800
From: Ralf Baechle <ralf@oss.sgi.com>
To: Kjeld Borch Egevang <kjelde@mips.com>
Cc: linux-mips mailing list <linux-mips@oss.sgi.com>
Subject: Re: zsh on console
Message-ID: <20020506195340.B15551@guest.intrengr>
References: <Pine.LNX.4.44.0205061440210.21711-100000@coplin19.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0205061440210.21711-100000@coplin19.mips.com>; from kjelde@mips.com on Mon, May 06, 2002 at 02:44:33PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, May 06, 2002 at 02:44:33PM +0200, Kjeld Borch Egevang wrote:

> When I run zsh on the console (serial interface) the process hangs. I can 
> login with /bin/bash, but when I start /bin/zsh it waits forever. I can 
> interrupt the process and regain control.
> 
> It's only related to the console. If I login with telnet it works just 
> fine.
> 
> Any idea, what could be wrong?

I recently fixed a simliar bug in the sb1250_duart.c driver.  Basically
a hangup of the tty did result in the close routine getting called thus
the driver's usage counter for ttyS0 eventually dropping to zero though
it was still open ...

  Ralf
