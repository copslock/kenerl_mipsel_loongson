Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Aug 2005 10:21:24 +0100 (BST)
Received: from smtp-out.hotpop.com ([IPv6:::ffff:38.113.3.61]:10198 "EHLO
	smtp-out.hotpop.com") by linux-mips.org with ESMTP
	id <S8225244AbVHKJVD> convert rfc822-to-8bit; Thu, 11 Aug 2005 10:21:03 +0100
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 9949A156C07B
	for <linux-mips@linux-mips.org>; Thu, 11 Aug 2005 09:24:58 +0000 (UTC)
Received: from cavan (unknown [62.253.252.7])
	by smtp-3.hotpop.com (Postfix) with ESMTP
	id D35FE17ADC0B; Thu, 11 Aug 2005 09:24:55 +0000 (UTC)
Date:	Thu, 11 Aug 2005 09:25:20 +0000
From:	jaypee@hotpop.com
Subject: Re: Au1xxx ethernet race condition?
To:	Jerry <jerry@wicomtechnologies.com>,
	linux-mips <linux-mips@linux-mips.org>
References: <1123749337l.30285l.5l@cavan>
	<1905543925.20050811120527@wicomtechnologies.com>
In-Reply-To: <1905543925.20050811120527@wicomtechnologies.com> (from
	jerry@wicomtechnologies.com on Thu Aug 11 10:05:27 2005)
X-Mailer: Balsa 2.3.3
Message-Id: <1123752323l.30285l.7l@cavan>
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
X-archive-position: 8738
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaypee@hotpop.com
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> 
> We are dealing with au1200 and there are some problems around
> at least with udp timeouts and maybe low perfomance. But it
> seems to be driver problems (occurs both in 2.4 and 2.6) besides
> au1200 does not use au1000_eth.c
> 
> Maybe your problem is somewhere else, and maybe it is completely
> different.
> 

Agreed, I don't think au1000_eth.c is a problem as far throughput goes.


- -- 
mailto:jaypee@hotpop.com
http://www.jaypee.org.uk
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD4DBQFC+xmDZDxnKy3oOpYRAkAGAJjZLla7TN9Mcny1o9H/QAoJQpfiAKCFUDmU
eOfmPvEPqbMgtpZxmK9Npg==
=IrC3
-----END PGP SIGNATURE-----
