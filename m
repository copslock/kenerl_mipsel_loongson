Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Aug 2005 09:31:43 +0100 (BST)
Received: from smtp-out.hotpop.com ([IPv6:::ffff:38.113.3.71]:37003 "EHLO
	smtp-out.hotpop.com") by linux-mips.org with ESMTP
	id <S8225243AbVHKIbY> convert rfc822-to-8bit; Thu, 11 Aug 2005 09:31:24 +0100
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id C138617AD637
	for <linux-mips@linux-mips.org>; Thu, 11 Aug 2005 08:35:17 +0000 (UTC)
Received: from cavan (unknown [62.253.252.7])
	by smtp-3.hotpop.com (Postfix) with ESMTP
	id 0C21917ADC57; Thu, 11 Aug 2005 08:35:16 +0000 (UTC)
Date:	Thu, 11 Aug 2005 08:35:29 +0000
From:	jaypee@hotpop.com
Subject: Au1xxx ethernet race condition?
To:	linux-mips <linux-mips@linux-mips.org>
Cc:	tnt@246tNt.com
X-Mailer: Balsa 2.3.3
Message-Id: <1123749337l.30285l.5l@cavan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Return-Path: <jaypee@hotpop.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8735
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaypee@hotpop.com
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

While preforming network soak test on our au1550 based board, I noticed
lots of netdev timeout messages.

If I increased the ETH_TX_TIMEOUT to 5*HZ from HZ/4, I can see that  
traffic does stop until the watchdog barks.

However if I print out the TX DMA status at this stage all the buffers
are ready to use.

My theory as to why this occurs is that in au1000_tx there is a race  
condition.

If a tx_done interrupt for the last tx buffer occurs between reading  
buff_stat (line 1905, au1000_eth.c) and calling netif_stop_queue then
the queue won't get woken until the watchdog barks.

I inserted a local_irq_save() at line 1903 and a local_irq_restore()
at line 1915 and that seems to have fixed the problem. (Been running
for half an hour with no netdev timeouts).

I'm sure this is overkill. Can anyone else confirm?
a) they see the problem
b) that there is a better solution

As an aside, the network stack for the 2.6 kernel is pretty slow, as  
large 32k udp pckts don't use anywhere near the amount of cycles that  
1.5k udp pckts do.
Suggests to me that it is the udp/ip path that is the bottleneck.


Just had a look at the mailing list and it looks like sylvain is
having a similar problem. Can you try this fix and see if it removes
your netdev tx timeouts sylvain?

thankx

- -- 
mailto:jaypee@hotpop.com
http://www.jaypee.org.uk
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC+w3ZZDxnKy3oOpYRAsPKAKCe5R6qBsmMDyBY1w/MvoL1CvabvwCdEz9g
xFXbK05i7hD0PAYwotk2+u0=
=W7tS
-----END PGP SIGNATURE-----
