Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Feb 2005 10:05:18 +0000 (GMT)
Received: from no-dns-yet.demon.co.uk ([IPv6:::ffff:83.104.11.251]:43699 "EHLO
	exterity.co.uk") by linux-mips.org with ESMTP id <S8225339AbVBXKFC>;
	Thu, 24 Feb 2005 10:05:02 +0000
Received: from [192.168.0.85] ([192.168.0.85]) by exterity.co.uk with Microsoft SMTPSVC(6.0.3790.211);
	 Thu, 24 Feb 2005 10:06:20 +0000
Subject: Re: Big Endian au1550
From:	JP Foster <jp.foster@exterity.co.uk>
To:	ppopov@embeddedalley.com
Cc:	linux-mips@linux-mips.org
In-Reply-To: <000001c519d1$84d9c250$0300a8c0@Exterity.local>
References: <1109157737.16445.6.camel@localhost.localdomain>
	 <000301c5199d$3154ad40$0300a8c0@Exterity.local>
	 <1109160313.16445.20.camel@localhost.localdomain>
	 <cb80abe539fa80effd786cacc1340de7@embeddededge.com>
	 <1109177856.18018.13.camel@kronenbourg.scs.ch>
	 <000001c519d1$84d9c250$0300a8c0@Exterity.local>
Content-Type: text/plain
Date:	Thu, 24 Feb 2005 10:04:55 +0000
Message-Id: <1109239495.8389.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.1.5 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Feb 2005 10:06:20.0546 (UTC) FILETIME=[7CEFC620:01C51A58]
Return-Path: <jpfoster@exterity.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jp.foster@exterity.co.uk
Precedence: bulk
X-list: linux-mips

On Wed, 2005-02-23 at 18:00 +0000, Pete Popov wrote:
>Thomas Sailer wrote:
>> On Wed, 2005-02-23 at 10:03 -0500, Dan Malek wrote:
>> 
>> 
>>>The only issues with big endian Au1xxx is the USB and potentially
>>>PCI.  There have been recent patches posted for USB that could
>>>fix this.  The PCI problem is with the read/write/in/out macros.
>> 
>> 
>> Last time I tried (about a month ago using the then current linux-mips
>> 2.6 CVS tree), USB host didn't work neither in big nor little endian
>> mode on my AMD Pb1000. Ethernet and Serial worked either way.
>
>We've been doing all the 2.6 work on the Db1x boards. The Pb1x need 
>an uplift as well, but I don't know if we'll have time to do it.
>
>Pete
>

Great, but I still can't get a running kernel from cvs mips-linux for
a DB1550 board. Is it perhaps the toolchain? I'm using gcc-3.4.1 perhaps
that is too recent. 

Tried mipsel last night and got the same result as big end so I suspect
it may be my compiler/binutils combination. Is there are recommended
toolchain for mips. Should I go build gcc-2.95 and binutils 2.12 ?

JP
