Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Dec 2004 18:06:06 +0000 (GMT)
Received: from pimout1-ext.prodigy.net ([IPv6:::ffff:207.115.63.77]:40437 "EHLO
	pimout1-ext.prodigy.net") by linux-mips.org with ESMTP
	id <S8225305AbULHSGA>; Wed, 8 Dec 2004 18:06:00 +0000
Received: from 127.0.0.1 (adsl-68-124-224-225.dsl.snfc21.pacbell.net [68.124.224.225])
	by pimout1-ext.prodigy.net (8.12.10 milter /8.12.10) with ESMTP id iB8I5s6M184356
	for <linux-mips@linux-mips.org>; Wed, 8 Dec 2004 13:05:54 -0500
Received: from  [63.194.214.47] by 127.0.0.1
  (ArGoSoft Mail Server Pro for WinNT/2000/XP, Version 1.8 (1.8.6.7)); Wed, 8 Dec 2004 10:07:51 -0800
Message-ID: <41B7426A.2040502@embeddedalley.com>
Date: Wed, 08 Dec 2004 10:05:30 -0800
From: Pete Popov <ppopov@embeddedalley.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Karl Lessard <klessard@sunrisetelecom.com>
CC: linux-mips@linux-mips.org
Subject: Re: Epson13806 performances on Pb1100
References: <MAILSERVERUhrBb0aCQ0000084e@mailserver.sunrisetelecom.com>
In-Reply-To: <MAILSERVERUhrBb0aCQ0000084e@mailserver.sunrisetelecom.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ArGoMail-Authenticated: ppopov@embeddedalley.com
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6603
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Karl Lessard wrote:
> Hi all,
> 
> I'm currently developping on a Pb1100 alchemy board, and I use the Epson 
> 13806 graphic controller connected to the Au1100 static bus. I've written a 
> driver for it for kernel 2.6.x, and update the Au1100 code so I can access 
> 0xE 0000 0000 address range.
> 
> Everything works fine, but for the speed. It seems that accessing the chip is 
> too slow for having high-graphic performances. The LCLK is set at 49500KHz, 
> as the memory clock inside the chip. I know it's a bit overclocked, but a 
> lower LCLK freezes my system.

I've used the chip with the 2.4 kernel/driver to run X and some 
apps. I'm not sure what you mean by high performance -- does X run 
at reasonable speeds?

Pete

> I would like to know if anyone have encountered this performance problem in 
> the past with this chip.
> 
> Thanks in advance,
> Karl
> 
> 
