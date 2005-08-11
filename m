Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Aug 2005 10:24:14 +0100 (BST)
Received: from smtp-out.hotpop.com ([IPv6:::ffff:38.113.3.71]:2274 "EHLO
	smtp-out.hotpop.com") by linux-mips.org with ESMTP
	id <S8225244AbVHKJXw> convert rfc822-to-8bit; Thu, 11 Aug 2005 10:23:52 +0100
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 0DE4817ADC81
	for <linux-mips@linux-mips.org>; Thu, 11 Aug 2005 09:27:46 +0000 (UTC)
Received: from cavan (unknown [62.253.252.7])
	by smtp-3.hotpop.com (Postfix) with ESMTP id 16B6517ADC01
	for <linux-mips@linux-mips.org>; Thu, 11 Aug 2005 09:27:45 +0000 (UTC)
Date:	Thu, 11 Aug 2005 09:28:05 +0000
From:	jaypee@hotpop.com
Reply-To: linux-mips <linux-mips@linux-mips.org>
Subject: Re: Au1xxx ethernet race condition?
To:	linux-mips <linux-mips@linux-mips.org>
References: <1123749337l.30285l.5l@cavan>
In-Reply-To: <1123749337l.30285l.5l@cavan> (from jaypee@hotpop.com on Thu
	Aug 11 09:35:29 2005)
X-Mailer: Balsa 2.3.3
Message-Id: <1123752487l.30285l.8l@cavan>
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
X-archive-position: 8739
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaypee@hotpop.com
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/08/05 09:35:29, jaypee@hotpop.com wrote:
> 
> My theory as to why this occurs is that in au1000_tx there is a race
> condition.
> 
> If a tx_done interrupt for the last tx buffer occurs between reading
> buff_stat (line 1905, au1000_eth.c) and calling netif_stop_queue then
> the queue won't get woken until the watchdog barks.
> 
> I inserted a local_irq_save() at line 1903 and a local_irq_restore()
> at line 1915 and that seems to have fixed the problem. (Been running
> for half an hour with no netdev timeouts).
> 

Oh you'll need to turn WARN_ON off or you'll get lots of
Badness in local_bh_enable warnings.

- -- 
mailto:jaypee@hotpop.com
http://www.jaypee.org.uk
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC+xonZDxnKy3oOpYRApzaAKDVDqkfKA/gDXo9N6Kq2twilUVy2gCfWDRK
2qsrUN51BEFqtfXwLih7QhE=
=jbjw
-----END PGP SIGNATURE-----
