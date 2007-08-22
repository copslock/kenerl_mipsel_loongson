Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Aug 2007 21:36:09 +0100 (BST)
Received: from port535.ds1-van.adsl.cybercity.dk ([217.157.140.228]:11888 "EHLO
	valis.murphy.dk") by ftp.linux-mips.org with ESMTP
	id S20022912AbXHVUgH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Aug 2007 21:36:07 +0100
Received: from [10.0.0.115] ([10.0.0.115])
	by valis.murphy.dk (8.13.3/8.13.3/Debian-6) with ESMTP id l7MKZx8d010659;
	Wed, 22 Aug 2007 22:36:00 +0200
Message-ID: <46CC9E2E.5090402@murphy.dk>
Date:	Wed, 22 Aug 2007 22:35:58 +0200
From:	Brian Murphy <brm@murphy.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.9) Gecko/20061219 Iceape/1.0.7 (Debian-1.0.7-2)
MIME-Version: 1.0
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Add back support for LASAT platforms
References: <200708212034.l7LKYGiD011023@potty.localnet> <20070822101425.430da249.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20070822101425.430da249.yoichi_yuasa@tripeaks.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <brm@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16248
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brm@murphy.dk
Precedence: bulk
X-list: linux-mips

Yoichi Yuasa wrote:

<much snipping>
>> +
>> +config DS1603
>> +	bool "DS1603 RTC driver"
>> +	depends on LASAT
>>     
>
> If you add new RTC driver, it should go to drivers/rtc.
>   
It's hardly new, is it? It was removed by you with the rest
of the LASAT stuff two months ago after it had been in the kernel
for 5 years. Why are RTC drivers more important than any others?
And why is it important that a platform specific driver goes in a
common area when only one platform uses it?

The driver is quite platform specific:

1) It needs to adjust for a slow transistor on the I/O line to allow
for three-stating.
2) A special lasat_ndelay which guesses the clock speed based
on platform to allowi the bit-banging interface to control the device
before the CP0 timer is calibrated (by the RTC).
3) Platform specific I/O which is not programmable (part of an FPGA/CPLD).

1 Is basically solved now in an ugly manner with a long delay parameter.
2 I cant really see a sensible solution to.
3 I could use the new fancy gpio interface but as the I/O is neither
general or programmable I'm not sure of the point. If someone else
needed the driver then I would have no problem in doing this but as
it is it seems like a waste of time.

The interface the rtc uses is still used by many drivers implemented
in the platform directories and is much simpler and straightforward
than the general interface used by the drivers in drivers/rtc and will
give more code.

I have no problems with your other points but I would really like the
RTC code to stay where it is.

/Brian
