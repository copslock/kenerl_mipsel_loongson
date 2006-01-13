Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Jan 2006 18:27:51 +0000 (GMT)
Received: from p549F60EF.dip.t-dialin.net ([84.159.96.239]:907 "EHLO
	p549F60EF.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S8126537AbWAOS00 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 15 Jan 2006 18:26:26 +0000
Received: from [IPv6:::ffff:163.181.251.6] ([IPv6:::ffff:163.181.251.6]:54926
	"EHLO amdext4.amd.com") by linux-mips.net with ESMTP
	id <S873030AbWAMKMI>; Fri, 13 Jan 2006 11:12:08 +0100
Received: from SAUSGW02.amd.com (sausgw02.amd.com [163.181.250.22])
	by amdext4.amd.com (8.12.11/8.12.11/AMD) with ESMTP id k0DA7p8b011365;
	Fri, 13 Jan 2006 04:08:42 -0600
Received: from 163.181.250.1 by SAUSGW01.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Fri, 13 Jan 2006 04:08:23 -0600
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
Received: from elbe.amd.com (elbe.amd.com [172.20.31.2]) by
 amdint2.amd.com (8.12.8/8.12.8/AMD) with ESMTP id k0DA8Kh5009974; Fri,
 13 Jan 2006 04:08:20 -0600 (CST)
Received: from [172.20.32.126] by elbe.amd.com (8.8.8+Sun/AMD-S-2.0) id
 LAA20341; Fri, 13 Jan 2006 11:08:19 +0100 (MET)
Message-ID: <43C77C1D.3030702@amd.com>
Date:	Fri, 13 Jan 2006 11:08:29 +0100
From:	"Thomas Dahlmann" <thomas.dahlmann@amd.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	"Oliver Neukum" <oliver@neukum.org>
cc:	linux-usb-devel@lists.sourceforge.net,
	"Jordan Crouse" <jordan.crouse@amd.com>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org, info-linux@ldcmail.amd.com
Subject: Re: [linux-usb-devel] [PATCH] UDC support for MIPS/AU1200 and
 Geode/CS5536
References: <20060109180356.GA8855@cosmic.amd.com>
 <200601092344.55988.oliver@neukum.org> <43C39431.6020308@amd.com>
 <200601101440.38853.oliver@neukum.org>
In-Reply-To: <200601101440.38853.oliver@neukum.org>
X-WSS-ID: 6FD9A39D3983386203-01-01
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <thomas.dahlmann@amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9872
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.dahlmann@amd.com
Precedence: bulk
X-list: linux-mips

Oliver Neukum wrote:

>Am Dienstag, 10. Januar 2006 12:02 schrieb Thomas Dahlmann:
>  
>
>>Oliver Neukum wrote:
>>
>>    
>>
>>>Am Montag, 9. Januar 2006 19:03 schrieb Jordan Crouse:
>>> 
>>>
>>>      
>>>
>>>>>From the "two-birds-one-stone" department, I am pleased to present USB UDC
>>>>support for both the MIPS Au1200 SoC and the Geode CS5535 south bridge.  
>>>>Also, coming soon (in the next few days), OTG, which has been removed from
>>>>the usb_host patch, and put into its own patch (as per David's comments).
>>>>
>>>>This patch is against current linux-mips git, but it should apply for Linus's
>>>>tree as well.
>>>>
>>>>Regards,
>>>>Jordan
>>>>
>>>>   
>>>>
>>>>        
>>>>
>>>+        VDBG("udc_read_bytes(): %d bytes\n", bytes);
>>>+
>>>+        /* dwords first */
>>>+        for (i = 0; i < bytes / UDC_DWORD_BYTES; i++) {
>>>+               *((u32*) (buf + (i<<2))) = readl(dev->rxfifo); 
>>>+        }
>>>
>>>Is there any reason you don't increment by 4?
>>>
>>>	Regards
>>>		Oliver
>>>
>>>
>>>
>>> 
>>>
>>>      
>>>
>>The loop is for reading dwords only, so "i < bytes / UDC_DWORD_BYTES" cuts
>>off remaining 1,2 or 3 bytes which are handled by the next loop.
>>But you are right, incrementing by 4 may look better,  as
>>
>>        for (i = 0; i < bytes - bytes % UDC_DWORD_BYTES; i+=4) {
>>               *((u32*) (buf + i)) = readl(dev->rxfifo); 
>>        }
>>    
>>
>
>Not only will it look better, but it'll save you a shift operation.
>You might even compute start and finish values before the loop and
>save an addition in the body.
>
>	Regards
>		Oliver
>
>
>
>  
>
I have changed this for the next patch release. Thanks for the input !

Regards,
Thomas
