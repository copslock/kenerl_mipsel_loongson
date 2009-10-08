Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Oct 2009 23:05:20 +0200 (CEST)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:10342 "EHLO
	smtp2.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493643AbZJHVFO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 Oct 2009 23:05:14 +0200
Received: from maexch1.caveonetworks.com (Not Verified[192.168.14.20]) by smtp2.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4ace53810000>; Thu, 08 Oct 2009 17:02:57 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by maexch1.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 8 Oct 2009 17:05:13 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 8 Oct 2009 14:03:38 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 8 Oct 2009 14:03:38 -0700
Message-ID: <4ACE53A9.8080504@caviumnetworks.com>
Date:	Thu, 08 Oct 2009 14:03:37 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Markus Gothe <nietzsche@lysator.liu.se>
CC:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-usb@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH 1/2] MIPS: Octeon: Add USB platform device.
References: <4ACD2EBF.8020901@caviumnetworks.com> <1254960926-12185-1-git-send-email-ddaney@caviumnetworks.com> <39A458B3-45D1-405E-A3F1-E41A6DB7EDE8@lysator.liu.se>
In-Reply-To: <39A458B3-45D1-405E-A3F1-E41A6DB7EDE8@lysator.liu.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Oct 2009 21:03:38.0223 (UTC) FILETIME=[CE7FF7F0:01CA485A]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24193
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Markus Gothe wrote:
> Is this just the HCD part AND is it tested to be endian safe?
> 

This particular patch just adds platform devices for the Octeon SOC.

The main patch (Patch 2/2) can be seen here:

http://marc.info/?l=linux-mips&m=125502126531841&w=2

For some reason it hasn't come out on linux-usb yet.

If you look at '[PATCH 2/2] USB: Add HCD for Octeon SOC', you will see 
that it has the hcd support.  I have omitted pcd support from this set, 
as I am working towards getting hcd mergable first.

As for endian issues, the current Octeon support in the kernel is for 
big-endian only, so since the usb hardware is on the same chip as the 
CPU, endian safety is not currently an issue.  I have heard rumors that 
some ralink and PPC variants have the same controller, but I have no way 
of confirming this or even testing the code as I don't have that hardware.


> Think of a 16-bits BE GIO-bus connected to the LE-32 HCD. (It's an 
> incredible mess to debug that kind of setup...)
> 

Indeed.

David Daney


> //Markus Gothe - The panamahat hacker
> 
> On 8 Oct 2009, at 02:15, David Daney wrote:
> 
>> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
>> ---
>> arch/mips/cavium-octeon/octeon-platform.c      |  105 ++
>> arch/mips/include/asm/octeon/cvmx-usbcx-defs.h | 1199 
>> ++++++++++++++++++++++++
[...]
