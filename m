Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4AIhZE10761
	for linux-mips-outgoing; Thu, 10 May 2001 11:43:35 -0700
Received: from web11903.mail.yahoo.com (web11903.mail.yahoo.com [216.136.172.187])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4AIhYF10758
	for <linux-mips@oss.sgi.com>; Thu, 10 May 2001 11:43:34 -0700
Message-ID: <20010510184334.71405.qmail@web11903.mail.yahoo.com>
Received: from [209.243.184.191] by web11903.mail.yahoo.com; Thu, 10 May 2001 11:43:34 PDT
Date: Thu, 10 May 2001 11:43:34 -0700 (PDT)
From: Wayne Gowcher <wgowcher@yahoo.com>
Subject: Re: Configuration of PCI Video card on a BIOS-less board
To: Pete Popov <ppopov@mvista.com>
Cc: linux-mips@oss.sgi.com
In-Reply-To: <3AFADA29.674BA111@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Pete,

I think I am in "dopey" mode this morning. 

The 0xC000 0000 I was talking about comes from another
board I was working on recently that mapped a
comapnion chip into kseg2 space. It seems it's been
burnt into my brain :(

The working PCI card is actually mapped to 0xA200
0000, and I am using that for the VGA card. My
comments about the address translation were totally
wrong. Sorry for any confusion.

Time for a coffee and a long rethink :)



__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - buy the things you want at great prices
http://auctions.yahoo.com/
