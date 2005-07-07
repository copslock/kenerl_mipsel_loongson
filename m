Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jul 2005 22:02:14 +0100 (BST)
Received: from smtp001.bizmail.yahoo.com ([IPv6:::ffff:216.136.172.125]:32141
	"HELO smtp001.bizmail.yahoo.com") by linux-mips.org with SMTP
	id <S8226325AbVGGVB6>; Thu, 7 Jul 2005 22:01:58 +0100
Received: (qmail 85347 invoked from network); 7 Jul 2005 21:02:19 -0000
Received: from unknown (HELO ?192.168.1.101?) (ppopov@embeddedalley.com@71.128.175.242 with plain)
  by smtp001.bizmail.yahoo.com with SMTP; 7 Jul 2005 21:02:18 -0000
Subject: Re: insmod error for pcmcia support on db1550
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	rolf liu <rolfliu@gmail.com>
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <2db32b7205070713553df6096a@mail.gmail.com>
References: <2db32b7205070713553df6096a@mail.gmail.com>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Thu, 07 Jul 2005 14:02:23 -0700
Message-Id: <1120770143.5777.85.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8398
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Thu, 2005-07-07 at 13:55 -0700, rolf liu wrote:
> I compiled linux 2.6.12 with the pcmcia support. And I got 3 module
> files: au1x00_ss.ko, pcmcia.ko, and pcmcia_core.ko.
> 
> I used" insmod au1x00_ss.ko", but system tells me:
> >>insmod: QM_MODULES: Function not implemented
> 
> The same thing happens to pcmcia_core.ko and pcmcia.ko too.
> 
> What is the problem here? Do I need to recompile the module untilities
> for the 2.6 kernels?
> 
> Also, when I typed "lspci -v", no information for the pcmcia showed up.
> 
> Thanks for comments

Just my 2c: you have to do some work yourself before you ping the
mailing list. If you search on google for the above error, you'll find
the answer within 5 min.  

Yes, you do need a new modules loading package which you'll have to
compile.

Pete
