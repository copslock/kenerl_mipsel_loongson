Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Dec 2004 23:35:13 +0000 (GMT)
Received: from pimout3-ext.prodigy.net ([IPv6:::ffff:207.115.63.102]:15025
	"EHLO pimout3-ext.prodigy.net") by linux-mips.org with ESMTP
	id <S8225346AbULHXfG>; Wed, 8 Dec 2004 23:35:06 +0000
Received: from 127.0.0.1 (adsl-68-124-224-225.dsl.snfc21.pacbell.net [68.124.224.225])
	by pimout3-ext.prodigy.net (8.12.10 milter /8.12.10) with ESMTP id iB8NZ1mu380132
	for <linux-mips@linux-mips.org>; Wed, 8 Dec 2004 18:35:02 -0500
Received: from  [63.194.214.47] by 127.0.0.1
  (ArGoSoft Mail Server Pro for WinNT/2000/XP, Version 1.8 (1.8.6.7)); Wed, 8 Dec 2004 15:36:52 -0800
Message-ID: <41B78F83.9010001@embeddedalley.com>
Date: Wed, 08 Dec 2004 15:34:27 -0800
From: Pete Popov <ppopov@embeddedalley.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: charles.eidsness@ieee.org
CC: linux-mips@linux-mips.org
Subject: Re: Au1000 Ethernet Driver using NAPI
References: <41B764AB.5070201@ieee.org>
In-Reply-To: <41B764AB.5070201@ieee.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ArGoMail-Authenticated: ppopov@embeddedalley.com
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6610
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips


Very cool, thanks. Is the patch for 2.4 or 2.6?

Pete

Charles Eidsness wrote:
> Hi All,
> 
> I was having a problem running a streaming audio application on my 
> Au1000 processor when the Ethernet port was being bombarded with 
> packets. All of the interrupt servicing was hogging my precious 
> processing power and there was nothing left for my app. There's a new 
> method for writing Ethernet drivers called NAPI which resolves this 
> issue (somewhat). I converted the au1000's Ethernet driver to use this 
> method. If you're interested you can find a patch that applys my changes 
> to the most recent kernel here:
> 
> http://members.rogers.com/charles.eidsness/linux-au1000_eth.napi.patch
> 
> Cheers,
> Charles
> 
> 
