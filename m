Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2004 15:16:01 +0000 (GMT)
Received: from neptune.fsa.ucl.ac.be ([IPv6:::ffff:130.104.233.21]:14277 "EHLO
	neptune.fsa.ucl.ac.be") by linux-mips.org with ESMTP
	id <S8225385AbUA1PQB>; Wed, 28 Jan 2004 15:16:01 +0000
Received: from 246tNt.com (21-6.CampusNet.ucl.ac.be [130.104.21.6])
	by neptune.fsa.ucl.ac.be (8.12.10/8.12.9/mp-2002.03.25) with ESMTP id i0SFFKfe027382;
	Wed, 28 Jan 2004 16:15:22 +0100 (MET)
Message-ID: <4017D213.8070108@246tNt.com>
Date: Wed, 28 Jan 2004 16:15:31 +0100
From: Sylvain Munaut <tnt@246tnt.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031211 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
CC: linux-mips@linux-mips.org
Subject: Re: Linux 2.6 on AMD Alchemy Au1500
References: <4017927B.5080907@246tNt.com> <4017CF37.4070708@embeddededge.com>
In-Reply-To: <4017CF37.4070708@embeddededge.com>
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
Return-Path: <tnt@246tnt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4165
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tnt@246tnt.com
Precedence: bulk
X-list: linux-mips



Dan Malek wrote:

>> For a new design, we're considering Alchemy Au1500 processor family. 
>> I'd like to know what is the current state of the linux 2.6 on this 
>> platforms / experiences ?
>
>
> There are several of us working on it.  The kernel is basically 
> functional,
> and we are now in the  midst of the 36-bit addressing updates for the
> peripherals, such as PCI.  This should be completed soon.
>
Ok cool.

>> I mainly need :
>> - PCI support to connect Wifi, IDE controller, USB2.0 Host, FireWire 
>> controller
>> - Included Ethernet support
>
>
> If you are looking for product support, you should probably be contacting
> people that provide these services :-)  We will eventually get around to
> testing all of these devices, but those of us working on this are likely
> to have different priorities.

Yes, what I meant is that I needed PCI support and wanted to know if it 
was OK, the chips I connect on it are supported.

I just forgot to ask if the AC97 stuff was already supported by the ALSA 
stuff in the kernel ?


Thanks for the info
    Munaut Sylvain
