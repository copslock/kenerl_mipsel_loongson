Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Feb 2005 17:47:47 +0000 (GMT)
Received: from mail.chipsandsystems.com ([IPv6:::ffff:64.164.196.27]:967 "EHLO
	mail.chipsag.com") by linux-mips.org with ESMTP id <S8225403AbVBWRrc>;
	Wed, 23 Feb 2005 17:47:32 +0000
Received: from [10.1.100.35] ([10.1.100.35]) by mail.chipsag.com with Microsoft SMTPSVC(6.0.3790.0);
	 Wed, 23 Feb 2005 09:50:34 -0800
Message-ID: <421CC1AA.4070201@embeddedalley.com>
Date:	Wed, 23 Feb 2005 09:47:22 -0800
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To:  ppopov@embeddedalley.com
Organization: Embedded Alley Solutions, Inc
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Thomas Sailer <sailer@scs.ch>
CC:	Dan Malek <dan@embeddededge.com>,
	JP Foster <jp.foster@exterity.co.uk>, linux-mips@linux-mips.org
Subject: Re: Big Endian au1550
References: <1109157737.16445.6.camel@localhost.localdomain>	 <000301c5199d$3154ad40$0300a8c0@Exterity.local>	 <1109160313.16445.20.camel@localhost.localdomain>	 <cb80abe539fa80effd786cacc1340de7@embeddededge.com> <1109177856.18018.13.camel@kronenbourg.scs.ch>
In-Reply-To: <1109177856.18018.13.camel@kronenbourg.scs.ch>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Feb 2005 17:50:34.0885 (UTC) FILETIME=[2D00DB50:01C519D0]
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7328
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Thomas Sailer wrote:
> On Wed, 2005-02-23 at 10:03 -0500, Dan Malek wrote:
> 
> 
>>The only issues with big endian Au1xxx is the USB and potentially
>>PCI.  There have been recent patches posted for USB that could
>>fix this.  The PCI problem is with the read/write/in/out macros.
> 
> 
> Last time I tried (about a month ago using the then current linux-mips
> 2.6 CVS tree), USB host didn't work neither in big nor little endian
> mode on my AMD Pb1000. Ethernet and Serial worked either way.

We've been doing all the 2.6 work on the Db1x boards. The Pb1x need 
an uplift as well, but I don't know if we'll have time to do it.

Pete
