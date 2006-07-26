Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Jul 2006 01:22:38 +0100 (BST)
Received: from imf19aec.mail.bellsouth.net ([205.152.59.67]:59205 "EHLO
	imf19aec.mail.bellsouth.net") by ftp.linux-mips.org with ESMTP
	id S8133994AbWGZAWC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Jul 2006 01:22:02 +0100
Received: from ibm60aec.bellsouth.net ([74.236.202.48])
          by imf19aec.mail.bellsouth.net with ESMTP
          id <20060726002120.BIUM21715.imf19aec.mail.bellsouth.net@ibm60aec.bellsouth.net>
          for <linux-mips@linux-mips.org>; Tue, 25 Jul 2006 20:21:20 -0400
Received: from [192.168.1.96] (really [74.236.202.48])
          by ibm60aec.bellsouth.net with ESMTP
          id <20060726002120.EOCM16573.ibm60aec.bellsouth.net@[192.168.1.96]>
          for <linux-mips@linux-mips.org>; Tue, 25 Jul 2006 20:21:20 -0400
Mime-Version: 1.0 (Apple Message framework v752.2)
In-Reply-To: <1153872862.6478.7.camel@sandbar.kenati.com>
References: <1153872862.6478.7.camel@sandbar.kenati.com>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <68A51BFC-20AC-4D7A-9B07-CC40EC49C22A@willmert.com>
Content-Transfer-Encoding: 7bit
From:	craigslist <craigslist@willmert.com>
Subject: Re: YAMON: go
Date:	Tue, 25 Jul 2006 20:21:13 -0400
To:	linux-mips@linux-mips.org
X-Mailer: Apple Mail (2.752.2)
Return-Path: <craigslist@willmert.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12072
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: craigslist@willmert.com
Precedence: bulk
X-list: linux-mips


On Jul 25, 2006, at 8:14 PM, Ashlesha Shintre wrote:

> Hi,
>
> I compiled an 2.6 kernel for the db1500 board and used the load  
> command
> in YAMON to write the srec image to the RAM using tftp.  Now I want to
> start the kernel and so I issued the go command.  It gives me the
> following error:
>
> * Exception (user) : Reserved instruction *
>
> CAUSE    = 0x00808028  STATUS   = 0x00000002
> EPC      = 0x80404004  ERROREPC = 0x00000000
> BADVADDR = 0x00000000

I think the command should be
	go .

the period tells it to use the start address from the last "load"  
command.

>
> Also another query is this: How does one know whether the load command
> has written to the RAM or the Flash?

The address the srec file is loaded to is dependent upon the address  
used when building the srec file. I believe it defaults to ram  
memory. I use the --adjust-vma option with objcopy to adjust the  
address to a flash memory location. Yamon will put that in flash if  
the address parameter is correct.

> The help load says that this
> depends on the address.  However, upon issuing the load command  
> without
> any options, YAMON outputs the following as the location of the load:
>
> Start = 0x80404000, range = (0x80100000,0x80423084), format = SREC
>
> Thanks & Regards,
>
> Ashlesha Shintre.
> Intern
> Kenati Technologies
> 800W California Ave.
> Sunnyvale, CA
>
>
