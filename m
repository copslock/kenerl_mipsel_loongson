Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2BNeQr16948
	for linux-mips-outgoing; Mon, 11 Mar 2002 15:40:26 -0800
Received: from [64.152.86.3] (unknown.Level3.net [64.152.86.3] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2BNeN916944
	for <linux-mips@oss.sgi.com>; Mon, 11 Mar 2002 15:40:23 -0800
Received: from mail.esstech.com by [64.152.86.3]
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 11 Mar 2002 22:44:15 UT
Received: from venus (venus.esstech.com [193.5.205.5])
	by mail.esstech.com (8.11.6/8.11.6) with SMTP id g2BMc6516257;
	Mon, 11 Mar 2002 14:38:06 -0800 (PST)
Received: from bud.austin.esstech.com by venus (SMI-8.6/SMI-SVR4)
	id OAA23613; Mon, 11 Mar 2002 14:39:39 -0800
Received: from esstech.com by bud.austin.esstech.com (SMI-8.6/SMI-SVR4)
	id QAA25162; Mon, 11 Mar 2002 16:31:30 -0600
Message-ID: <3C8D338E.6050805@esstech.com>
Date: Mon, 11 Mar 2002 16:45:34 -0600
From: Gerald Champagne <gerald.champagne@esstech.com>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
CC: linux-mips@oss.sgi.com
Subject: Re: pci config cycles on VRC-5477
References: <3C8D26C8.2060903@esstech.com> <3C8D2E89.10001@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> Your understanding is correct.  I think this is a bug.
> 
> Do you actually see the bug happening?  So far it has never hit me, but 
> maybe due to the drivers that are loaded on my configuration.
> 
> Jun

No, I don't actually see it.  It's not a big window, and pci config
cycles don't occur very often.  I found it while learning the device.

I checked the ddb5476 and ddb5074 dirctories, and it looks like they
have the same problem.

It's a shame that the devices have only two windows into pci space when
having three windows would be much simpler...

Thanks for the response.

Gerald
