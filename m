Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jan 2006 11:00:39 +0000 (GMT)
Received: from amdext4.amd.com ([163.181.251.6]:44936 "EHLO amdext4.amd.com")
	by ftp.linux-mips.org with ESMTP id S8133428AbWAJLAU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 10 Jan 2006 11:00:20 +0000
Received: from SAUSGW01.amd.com (sausgw01.amd.com [163.181.250.21])
	by amdext4.amd.com (8.12.11/8.12.11/AMD) with ESMTP id k0AB3KZO001003;
	Tue, 10 Jan 2006 05:03:20 -0600
Received: from 163.181.250.1 by SAUSGW01.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Tue, 10 Jan 2006 05:03:11 -0600
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
Received: from elbe.amd.com (elbe.amd.com [172.20.31.2]) by
 amdint2.amd.com (8.12.8/8.12.8/AMD) with ESMTP id k0AB38h5013642; Tue,
 10 Jan 2006 05:03:09 -0600 (CST)
Received: from [172.20.36.124] by elbe.amd.com (8.8.8+Sun/AMD-S-2.0) id
 MAA06856; Tue, 10 Jan 2006 12:03:08 +0100 (MET)
Message-ID: <43C39431.6020308@amd.com>
Date:	Tue, 10 Jan 2006 12:02:09 +0100
From:	"Thomas Dahlmann" <thomas.dahlmann@amd.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	"Oliver Neukum" <oliver@neukum.org>
cc:	linux-usb-devel@lists.sourceforge.net,
	"Jordan Crouse" <jordan.crouse@amd.com>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org, info-linux@ldcmail.amd.com
Subject: Re: [linux-usb-devel] [PATCH] UDC support for MIPS/AU1200 and
 Geode/CS5536
References: <20060109180356.GA8855@cosmic.amd.com>
 <200601092344.55988.oliver@neukum.org>
In-Reply-To: <200601092344.55988.oliver@neukum.org>
X-WSS-ID: 6FDD4BE53982923370-01-01
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <thomas.dahlmann@amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9836
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.dahlmann@amd.com
Precedence: bulk
X-list: linux-mips


Oliver Neukum wrote:

>Am Montag, 9. Januar 2006 19:03 schrieb Jordan Crouse:
>  
>
>>>From the "two-birds-one-stone" department, I am pleased to present USB UDC
>>support for both the MIPS Au1200 SoC and the Geode CS5535 south bridge.  
>>Also, coming soon (in the next few days), OTG, which has been removed from
>>the usb_host patch, and put into its own patch (as per David's comments).
>>
>>This patch is against current linux-mips git, but it should apply for Linus's
>>tree as well.
>>
>>Regards,
>>Jordan
>>
>>    
>>
>+        VDBG("udc_read_bytes(): %d bytes\n", bytes);
>+
>+        /* dwords first */
>+        for (i = 0; i < bytes / UDC_DWORD_BYTES; i++) {
>+               *((u32*) (buf + (i<<2))) = readl(dev->rxfifo); 
>+        }
>
>Is there any reason you don't increment by 4?
>
>	Regards
>		Oliver
>
>
>
>  
>
The loop is for reading dwords only, so "i < bytes / UDC_DWORD_BYTES" cuts
off remaining 1,2 or 3 bytes which are handled by the next loop.
But you are right, incrementing by 4 may look better,  as

        for (i = 0; i < bytes - bytes % UDC_DWORD_BYTES; i+=4) {
               *((u32*) (buf + i)) = readl(dev->rxfifo); 
        }


Thanks,
Thomas
