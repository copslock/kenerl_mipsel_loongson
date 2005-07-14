Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jul 2005 15:40:38 +0100 (BST)
Received: from smtp-out.hotpop.com ([IPv6:::ffff:38.113.3.61]:28845 "EHLO
	smtp-out.hotpop.com") by linux-mips.org with ESMTP
	id <S8226372AbVGNOkT> convert rfc822-to-8bit; Thu, 14 Jul 2005 15:40:19 +0100
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 2EE961416454
	for <linux-mips@linux-mips.org>; Thu, 14 Jul 2005 14:41:17 +0000 (UTC)
Received: from cavan (unknown [62.253.252.7])
	by smtp-1.hotpop.com (Postfix) with ESMTP id DD8941A0234
	for <linux-mips@linux-mips.org>; Thu, 14 Jul 2005 13:52:54 +0000 (UTC)
Date:	Thu, 14 Jul 2005 13:52:36 +0000
From:	jaypee@hotpop.com
Subject: Re: Au1550 ethernet throughput low
To:	linux-mips <linux-mips@linux-mips.org>
References: <A8A67F242940E246A515077CF9ECACC16B16C4@dbde01.ent.ti.com>
In-Reply-To: <A8A67F242940E246A515077CF9ECACC16B16C4@dbde01.ent.ti.com>
	(from ajaysingh@ti.com on Thu Jul 14 06:02:22 2005)
X-Mailer: Balsa 2.3.3
Message-Id: <1121349173l.5178l.0l@cavan>
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
X-archive-position: 8482
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaypee@hotpop.com
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


On 14/07/05 06:02:22, Singh, Ajay wrote:
> Is your driver on Linux 2.6 NAPI enabled ? And is CONFIG_PREEMPT=y?

Turning preempt on made no difference, maybe a little worse.

I put a scope on the TX enable line and it is high for ~100us and low  
~50us. With the 2.4 kernel on au1000 it is high all the time.

This to me suggest there is some thing wrong in the au1000_eth driver/
interrupt handling/ packet scheduling in 2.6 as it is not keeping the  
DMA buffers full.


- -- 
mailto:jaypee@hotpop.com
http://www.jaypee.org.uk
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC1m41ZDxnKy3oOpYRAhooAJ9W7J8ZpXywqW0jPxc0b8hI3iS/DwCfZzWM
6lp6Z7cHYwW3WWW87SJrZPI=
=1No0
-----END PGP SIGNATURE-----
