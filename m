Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Mar 2006 18:22:25 +0000 (GMT)
Received: from smtp104.biz.mail.mud.yahoo.com ([68.142.200.252]:43368 "HELO
	smtp104.biz.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133418AbWCQSWQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 17 Mar 2006 18:22:16 +0000
Received: (qmail 2866 invoked from network); 17 Mar 2006 18:31:30 -0000
Received: from unknown (HELO ?192.168.1.103?) (ppopov@embeddedalley.com@71.128.175.242 with plain)
  by smtp104.biz.mail.mud.yahoo.com with SMTP; 17 Mar 2006 18:31:29 -0000
Subject: Re: au1000_tx_timeout and promiscuous mode
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	Jordan Crouse <jordan.crouse@amd.com>
Cc:	elmar gerdes <elmar.gerdes@engel-kg.com>, linux-mips@linux-mips.org
In-Reply-To: <20060317163806.GA3679@cosmic.amd.com>
References: <20060317010227.GA16575@engel-kg.com>
	 <20060317163806.GA3679@cosmic.amd.com>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Fri, 17 Mar 2006 10:31:05 -0800
Message-Id: <1142620265.8348.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10841
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Fri, 2006-03-17 at 09:38 -0700, Jordan Crouse wrote:
> On 17/03/06 02:02 +0100, elmar gerdes wrote:
> > 
> > hi folks,
> 
> Greetings Elmar.
> 
> > @@ -2070,6 +2070,7 @@
> >  	printk(KERN_ERR "%s: au1000_tx_timeout: dev=%p\n", dev->name, dev);
> >  	reset_mac(dev);
> >  	au1000_init(dev);
> > +	set_rx_mode(dev);	// EG 2006-03-15: set promiscuous mode
> >  	dev->trans_start = jiffies;
> >  	netif_wake_queue(dev);
> 
> I would move the comment to the previous line, use standard /* */ notation,
> and your name and the date isn't really needed, as that information will
> be stored in the GIT log.
> 
> Also, don't forget your Signed-off-by line and a short description of the
> patch for posterity.
> 
> Other then that, I have no problems with the bug - unless Pete wants to
> object, I think you should send the fixed-up patch to netdev@vger.kernel.org 
> and CC this list. 

Nah, you're owner/reviewer now ;)

Pete
