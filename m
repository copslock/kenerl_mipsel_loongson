Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Oct 2004 04:46:07 +0100 (BST)
Received: from wip-ec-wd.wipro.com ([IPv6:::ffff:203.101.113.39]:31130 "EHLO
	wip-ec-wd.wipro.com") by linux-mips.org with ESMTP
	id <S8224839AbUJGDqD> convert rfc822-to-8bit; Thu, 7 Oct 2004 04:46:03 +0100
Received: from wip-ec-wd.wipro.com (localhost.wipro.com [127.0.0.1])
	by localhost (Postfix) with ESMTP id BE7ED20571;
	Thu,  7 Oct 2004 09:12:37 +0530 (IST)
Received: from blr-ec-bh3.wipro.com (unknown [10.200.50.93])
	by wip-ec-wd.wipro.com (Postfix) with ESMTP id 9969B20530;
	Thu,  7 Oct 2004 09:12:37 +0530 (IST)
Received: from chn-snr-bh1.wipro.com ([10.145.50.91]) by blr-ec-bh3.wipro.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 7 Oct 2004 09:15:53 +0530
Received: from chn-snr-msg.wipro.com ([10.145.50.99]) by chn-snr-bh1.wipro.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 7 Oct 2004 09:15:54 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: __up, __down_trylock & __down_interruptible for MIPS
Date: Thu, 7 Oct 2004 09:15:53 +0530
Message-ID: <6BF015B686198842A1C8F84F4B7E6D2601276ADE@chn-snr-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: __up, __down_trylock & __down_interruptible for MIPS
thread-index: AcSrrpN2Q1ugNcKBS8GUkD4TjOIpugAa/zog
From: <priya.mani@wipro.com>
To: <ralf@linux-mips.org>
Cc: <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 07 Oct 2004 03:45:54.0062 (UTC) FILETIME=[2575BAE0:01C4AC20]
Return-Path: <priya.mani@wipro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5966
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: priya.mani@wipro.com
Precedence: bulk
X-list: linux-mips

Hi Ralf

I too doubted that the kernel which I am using is not in proper shape.
Please could you point me to a proper link where I can download it from.
I am in need of a proper working kernel version 2.4.25 or above.

Hope you can lead me to a proper link for this!

Thanks
Priya

-----Original Message-----
From: linux-mips-bounce@linux-mips.org
[mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Ralf Baechle
Sent: Wednesday, October 06, 2004 7:40 PM
To: Priya Balasubramanian (WT01 - EMBEDDED & PRODUCT ENGINEERING
SOLUTIONS)
Cc: linux-mips@linux-mips.org
Subject: Re: __up, __down_trylock & __down_interruptible for MIPS


On Wed, Oct 06, 2004 at 04:55:10PM +0530, priya.mani@wipro.com wrote:

> If I try to use the functions from the latest CVS files in the
mips-org
> site it gives other compilation errors.
> 
> Please can you tell me how do I go about this problem. Have the above
> functions been obsoleted? Is there any patch available for them? Or is
> there any doc explaining this? I am using Kernel version 2.4.22.

This was working in 2.4.22 so it seems you're using a broken tree.
Where
did you get it from?

  Ralf
