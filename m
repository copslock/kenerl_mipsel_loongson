Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2LIHq605451
	for linux-mips-outgoing; Thu, 21 Mar 2002 10:17:52 -0800
Received: from real.realitydiluted.com (real.realitydiluted.com [208.242.241.164])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2LIHoq05448
	for <linux-mips@oss.sgi.com>; Thu, 21 Mar 2002 10:17:50 -0800
Received: from localhost.localdomain ([127.0.0.1] helo=cotw.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 16o6Bz-0007Fu-00; Thu, 21 Mar 2002 11:17:36 -0600
Message-ID: <3C9A15AA.304AE304@cotw.com>
Date: Thu, 21 Mar 2002 11:17:30 -0600
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pete Popov <ppopov@mvista.com>
CC: linux-mips <linux-mips@oss.sgi.com>
Subject: Re: pci-pcmcia bridges/adapters
References: <1016683254.4951.168.camel@zeus>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Pete Popov wrote:
> 
> Has anyone gotten a pci-pcmcia adapter card to work with any 16 bit
> pcmcia card in it on mips linux?
> 
Your first priority should be to look at the main PCMCIA page for
Linux and find a PCI adapter that has a supported chipset, otherwise
you are wasting your time. I bought a PCI->PCMCIA adapter from LinkSys
for one of my wireless cards and the driver never worked, so my
experience has not been good. 

-Steve

-- 
 Steven J. Hill - Embedded SW Engineer
