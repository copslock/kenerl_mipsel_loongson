Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Dec 2005 11:43:45 +0000 (GMT)
Received: from web32903.mail.mud.yahoo.com ([68.142.206.50]:35961 "HELO
	web32903.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133657AbVLELnE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Dec 2005 11:43:04 +0000
Received: (qmail 54234 invoked by uid 60001); 5 Dec 2005 11:42:33 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=QO75+iR0ZcxS06nZe4vpa1UG2a8ncaQpDUUMJ9rpRb8Y5eUEm2jDmk8++/ifabJcxDC226lzNW6Ual/b+m3mH1AzFuk2xju9fsHnh0D4pCkSWD10nLxONGRD002TLpM2ZgAacQ0rp0fDqLpTbS5qkuvMWHFOCrA1Ehg1uaEempY=  ;
Message-ID: <20051205114233.54232.qmail@web32903.mail.mud.yahoo.com>
Received: from [203.145.155.11] by web32903.mail.mud.yahoo.com via HTTP; Mon, 05 Dec 2005 03:42:33 PST
Date:	Mon, 5 Dec 2005 03:42:33 -0800 (PST)
From:	Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [PATCH] ALCHEMY: SPI driver for Au1200
To:	Jordan Crouse <jordan.crouse@amd.com>, linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
In-Reply-To: <20051202190223.GG28227@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <komal_shah802003@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9594
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: komal_shah802003@yahoo.com
Precedence: bulk
X-list: linux-mips

--- Jordan Crouse <jordan.crouse@amd.com> wrote:

> A SPI driver for the Au1200 processor.  Sending now so it 
> can be queued for the post 2.6.15 rush.

Good. As there is long discussion going on which SPI framework to
accept in mainline, I would suggest you to implement the same master
controller and protocol driver using either David Brownell's framework
(right now in 2.6.15-rc3-mm1) or Dmitry/Wool framework.


---Komal Shah
http://komalshah.blogspot.com/


		
__________________________________ 
Start your day with Yahoo! - Make it your home page! 
http://www.yahoo.com/r/hs
