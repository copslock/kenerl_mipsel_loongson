Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jul 2005 10:56:17 +0100 (BST)
Received: from smtp-out.hotpop.com ([IPv6:::ffff:38.113.3.61]:7564 "EHLO
	smtp-out.hotpop.com") by linux-mips.org with ESMTP
	id <S8226818AbVGRJ4A> convert rfc822-to-8bit; Mon, 18 Jul 2005 10:56:00 +0100
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 4CBF81446DEE
	for <linux-mips@linux-mips.org>; Mon, 18 Jul 2005 09:57:24 +0000 (UTC)
Received: from cavan (unknown [62.253.252.7])
	by smtp-2.hotpop.com (Postfix) with ESMTP
	id 65EA91449ED2; Mon, 18 Jul 2005 09:57:18 +0000 (UTC)
Date:	Mon, 18 Jul 2005 09:57:13 +0000
From:	jaypee@hotpop.com
Subject: Re: Au1550 ethernet throughput low
To:	Bruno Randolf <bruno.randolf@4g-systems.biz>
Cc:	Clem Taylor <clem.taylor@gmail.com>,
	linux-mips <linux-mips@linux-mips.org>
References: <1121270402l.7656l.3l@cavan>
	<ecb4efd1050714171318ce81aa@mail.gmail.com> <1121415711l.5178l.3l@cavan>
	<200507151117.49012.bruno.randolf@4g-systems.biz>
In-Reply-To: <200507151117.49012.bruno.randolf@4g-systems.biz> (from
	bruno.randolf@4g-systems.biz on Fri Jul 15 10:17:44 2005)
X-Mailer: Balsa 2.3.3
Message-Id: <1121680641l.13805l.1l@cavan>
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
X-archive-position: 8523
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaypee@hotpop.com
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 15/07/05 10:17:44, Bruno Randolf wrote:
> On Friday 15 July 2005 10:21, jaypee@hotpop.com wrote:
> > Yours is using ~30% cpu to send 100Mbps.
> > Mine is using 100% to send 66Mbps.
> 
> i remember that ethernet thruput dropped from nearly 100Mbps to about
> 60-70Mbps on our Au1500 based board, when we enabled
> CONFIG_NONCOHERENT_IO...

Thanks Bruno but I can't find that config option to select.
I did find CONFIG_
Changing from CONFIG_DMA_NONCOHERENT to CONFIG_DMA_COHERENT  make no  
difference, although I can see that if the kernel invalidates the cache
line for each packet on send there would be a performance hit.

Clem can you send me your .config to see if I can figure out why your  
setup works?

> 
> bruno
> 

- -- 
mailto:jaypee@hotpop.com
http://www.jaypee.org.uk
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC230BZDxnKy3oOpYRAjq2AJ49DO0KrqGmWcS1N1dHHLe2lOlEhgCeNyqw
aTRA+DA6FyMNakcLBt5oV88=
=TR4O
-----END PGP SIGNATURE-----
