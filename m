Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Nov 2004 20:51:02 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:63740 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225330AbUKIUu4>; Tue, 9 Nov 2004 20:50:56 +0000
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 1F390185C2; Tue,  9 Nov 2004 12:50:53 -0800 (PST)
Message-ID: <41912DAC.6070905@mvista.com>
Date: Tue, 09 Nov 2004 12:50:52 -0800
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] Small fix for the Sibyte Mac driver
References: <20041108235148.GA20991@prometheus.mvista.com> <20041109195953.GA25337@linux-mips.org>
In-Reply-To: <20041109195953.GA25337@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6291
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Mon, Nov 08, 2004 at 03:51:48PM -0800, Manish Lachwani wrote:
> 
> 
>>Attached is a small patch for the Sibyte MAC Driver. This helps
>>print the device name correctly
> 
> 
>>-	/* This is needed for PASS2 for Rx H/W checksum feature */
>>-	sbmac_set_iphdr_offset(sc);
>>-
>> 	err = register_netdev(dev);
>> 	if (err)
>> 		goto out_uninit;
>> 
>>+	/* This is needed for PASS2 for Rx H/W checksum feature */
>>+	sbmac_set_iphdr_offset(sc);
>>+
> 
> 
> Your patch introduces a race condition - the NIC needs to be fully setup
> before register_netdev.  By the time register_netdev returns the driver
> could possibly already be opened and traffic be flowing.  What's usually
> done is using the PCI device's name as obtained through pci_name().
> Which in this case fails, so maybe you should convert the driver to a
> platform_device() and print platform_device->name instead.  The Titan GE
> driver which I think you're familiar with already use platform_device ;-)
> 
>   Ralf
> 
Hi Ralf

Thanks for the response. To make it really simple and avoid lot of 
changes to the driver code, we can continue to do 
sbmac_set_iphdr_offset() before the call to register_netdev() and print 
the "...enabling TCP rcv checksum" after register_netdev().

Since we need the driver to print the device name correctly, this change 
can keep things really simple :)

Thanks
Manish Lachwani
