Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Sep 2008 00:33:32 +0100 (BST)
Received: from bu3sch.de ([62.75.166.246]:58580 "EHLO vs166246.vserver.de")
	by ftp.linux-mips.org with ESMTP id S29567934AbYIXXdZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 25 Sep 2008 00:33:25 +0100
Received: from p5b09de83.dip.t-dialin.net ([91.9.222.131] helo=powermac.local)
	by vs166246.vserver.de with esmtpa (Exim 4.63)
	(envelope-from <mb@bu3sch.de>)
	id 1KictF-0001Uz-Rd; Wed, 24 Sep 2008 22:31:21 +0000
From:	Michael Buesch <mb@bu3sch.de>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/6] [MIPS] BCM47xx: Add platform specific PCI code
Date:	Thu, 25 Sep 2008 00:31:00 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Cc:	Aurelien Jarno <aurelien@aurel32.net>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <20080924191840.GA18700@volta.aurel32.net> <20080924191955.GB18700@volta.aurel32.net> <48DABBBE.7060201@ru.mvista.com>
In-Reply-To: <48DABBBE.7060201@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200809250031.00844.mb@bu3sch.de>
Return-Path: <mb@bu3sch.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20623
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mb@bu3sch.de
Precedence: bulk
X-list: linux-mips

On Thursday 25 September 2008 00:14:22 Sergei Shtylyov wrote:
> > +	WARN_ON((res == 0) || (res == 1));
>
>    Unneeded ()...

> > +	err = ssb_pcibios_plat_dev_init(dev);
> > +	if (err) {
> > +		printk(KERN_ALERT "PCI: Failed to init device %s\n",
> > +		       pci_name(dev));
> > +	}
> >   
> 
>    Unneeded {}...


You must me kidding.
Get this freaking regression fix upstream, please.
We're not going to respin it to fix trivial taste issues.
(The above code is _perfectly_ fine and doesn't violate any rule).

-- 
Greetings Michael.
