Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Feb 2010 17:35:15 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:47988 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492387Ab0BQQfM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 17 Feb 2010 17:35:12 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o1HGZ7lf005496;
        Wed, 17 Feb 2010 17:35:07 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o1HGZ66Q005494;
        Wed, 17 Feb 2010 17:35:06 +0100
Date:   Wed, 17 Feb 2010 17:35:05 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH -queue] MIPS/net: fix au1000_eth.c build and warnings
Message-ID: <20100217163505.GL1561@linux-mips.org>
References: <1266263017-6874-1-git-send-email-manuel.lauss@gmail.com>
 <201002171603.44952.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201002171603.44952.florian@openwrt.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25952
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 17, 2010 at 04:03:44PM +0100, Florian Fainelli wrote:

> > @@ -1006,7 +1006,7 @@ static int __devinit au1000_probe(struct
> >  platform_device *pdev) db_dest_t *pDB, *pDBfree;
> >  	int irq, i, err = 0;
> >  	struct resource *base, *macen;
> > -	DECLARE_MAC_BUF(ethaddr);
> > +	char ethaddr[6];
> 
> That hunk is already in net-next-2.6.

Fortunately this doesn't cause a merge conflict.

  Ralf
