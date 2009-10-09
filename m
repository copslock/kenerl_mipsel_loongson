Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Oct 2009 17:41:43 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:3099 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492963AbZJIPlg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 9 Oct 2009 17:41:36 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4acf595e0000>; Fri, 09 Oct 2009 08:40:14 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 9 Oct 2009 08:39:35 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 9 Oct 2009 08:39:35 -0700
Message-ID: <4ACF5935.50409@caviumnetworks.com>
Date:	Fri, 09 Oct 2009 08:39:33 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Stefan Roese <sr@denx.de>
CC:	Markus Gothe <nietzsche@lysator.liu.se>, ralf@linux-mips.org,
	linux-mips@linux-mips.org, linux-usb@vger.kernel.org,
	gregkh@suse.de
Subject: Re: [PATCH 1/2] MIPS: Octeon: Add USB platform device.
References: <4ACD2EBF.8020901@caviumnetworks.com> <39A458B3-45D1-405E-A3F1-E41A6DB7EDE8@lysator.liu.se> <4ACE53A9.8080504@caviumnetworks.com> <200910090935.55346.sr@denx.de>
In-Reply-To: <200910090935.55346.sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Oct 2009 15:39:35.0675 (UTC) FILETIME=[B44054B0:01CA48F6]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24203
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Stefan Roese wrote:
> On Thursday 08 October 2009 23:03:37 David Daney wrote:
>> If you look at '[PATCH 2/2] USB: Add HCD for Octeon SOC', you will see
>> that it has the hcd support.  I have omitted pcd support from this set,
>> as I am working towards getting hcd mergable first.
>>
>> As for endian issues, the current Octeon support in the kernel is for
>> big-endian only, so since the usb hardware is on the same chip as the
>> CPU, endian safety is not currently an issue.  I have heard rumors that
>> some ralink and PPC variants have the same controller, but I have no way
>> of confirming this or even testing the code as I don't have that
>> hardware.
> 
> Yes, this Synopsys USB-OTG core is also integrated in some AMCC (Applied 
> Micro) PowerPC's (e.g. PPC405EX and PPC460EX). So we should try to make this 
> driver usable by those platforms as well. But this could be done in a later 
> step.

I can only refer you to '[PATCH 2/2] USB: Add HCD for Octeon SOC' 
(unfortunately eaten by linux-usb but available in the linux-mips 
archives),  The target specific code is all in dwc_otg_octeon.c.  The 
rest should be target independent.  My expectation is that, much as the 
ohci and ehci drivers have target specific code spilt out, we would do 
the same with dwc_otg.


> 
> David, on which Synopsys driver version did you base your driver? The latest 
> version available is 2.90a IIRC.
>

It has this annotation:

  "2.40a 10-APR-2006"

We have made local bug fixes though.

> Cheers,
> Stefan
> 
> --
> DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-0 Fax: (+49)-8142-66989-80 Email: office@denx.de
> 
