Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6HDtwRw024270
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 17 Jul 2002 06:55:59 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6HDtwfA024269
	for linux-mips-outgoing; Wed, 17 Jul 2002 06:55:58 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft17-f190.dialo.tiscali.de [62.246.17.190])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6HDtsRw024260
	for <linux-mips@oss.sgi.com>; Wed, 17 Jul 2002 06:55:55 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g6HE0l526649;
	Wed, 17 Jul 2002 16:00:47 +0200
Date: Wed, 17 Jul 2002 16:00:47 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Johannes Stezenbach <js@convergence.de>
Cc: linux-mips@oss.sgi.com
Subject: Re: PATCH: dma_addr_t 32/64bit mix-up
Message-ID: <20020717160047.A26625@dea.linux-mips.net>
References: <20020716160327.GA12079@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020716160327.GA12079@convergence.de>; from js@convergence.de on Tue, Jul 16, 2002 at 06:03:27PM +0200
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 16, 2002 at 06:03:27PM +0200, Johannes Stezenbach wrote:

> the following patch applies to the linux_2_4 branch.

Thanks for noticing.  The fix isn't entirely right, the condition should be
defined(CONFIG_HIGHMEM) && defined(CONFIG_64BIT_PHYS_ADDR).

  Ralf
