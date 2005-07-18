Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jul 2005 18:24:42 +0100 (BST)
Received: from smtp-out.hotpop.com ([IPv6:::ffff:38.113.3.61]:5320 "EHLO
	smtp-out.hotpop.com") by linux-mips.org with ESMTP
	id <S8226838AbVGRRYY> convert rfc822-to-8bit; Mon, 18 Jul 2005 18:24:24 +0100
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 7CAAE1454656
	for <linux-mips@linux-mips.org>; Mon, 18 Jul 2005 17:25:52 +0000 (UTC)
Received: from cavan (unknown [62.253.252.7])
	by smtp-2.hotpop.com (Postfix) with ESMTP
	id A751A145439B; Mon, 18 Jul 2005 17:25:50 +0000 (UTC)
Date:	Mon, 18 Jul 2005 17:25:50 +0000
From:	jaypee@hotpop.com
Subject: Re: Au1550 ethernet throughput low
To:	Clem Taylor <clem.taylor@gmail.com>, linux-mips@linux-mips.org
References: <1121270402l.7656l.3l@cavan>
	<ecb4efd1050714171318ce81aa@mail.gmail.com> <1121415711l.5178l.3l@cavan>
	<200507151117.49012.bruno.randolf@4g-systems.biz>
	<1121680641l.13805l.1l@cavan> <ecb4efd105071809082628bb27@mail.gmail.com>
In-Reply-To: <ecb4efd105071809082628bb27@mail.gmail.com> (from
	clem.taylor@gmail.com on Mon Jul 18 17:08:20 2005)
X-Mailer: Balsa 2.3.3
Message-Id: <1121707552l.13805l.10l@cavan>
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
X-archive-position: 8535
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaypee@hotpop.com
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


On 18/07/05 17:08:20, Clem Taylor wrote:
> 
> Here's what I'm using... This is for the development kernel, I haven't
> created the release kernel config yet. Our board is called 'aquila' as
> referred to in the config file.
> 
>                         --Clem
> 

Thanks Clem,

I've fixed it. I turn off kernel debugging and it works a treat.
Doh! So easy.

Thank you everyone for your posts.
This was sending me round the bend.

- -- 
mailto:jaypee@hotpop.com
http://www.jaypee.org.uk
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC2+YgZDxnKy3oOpYRAgM6AJ9HsvTNfyu1yUCFurAyWVUW2YRmjQCfag3c
eBMrNLBWaIzIE+ARD8GClFQ=
=413X
-----END PGP SIGNATURE-----
