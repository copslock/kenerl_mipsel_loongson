Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Dec 2008 01:51:36 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:35125 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24071181AbYLKBv2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Dec 2008 01:51:28 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B494072010000>; Wed, 10 Dec 2008 20:50:57 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 10 Dec 2008 17:50:33 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 10 Dec 2008 17:50:33 -0800
Message-ID: <494071E9.2010808@caviumnetworks.com>
Date:	Wed, 10 Dec 2008 17:50:33 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.18 (X11/20081119)
MIME-Version: 1.0
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
CC:	linux-ide@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/3] libata: Add another column to the ata_timing table.
References: <494052D1.10208@caviumnetworks.com> <1228952353-12323-1-git-send-email-ddaney@caviumnetworks.com> <49405640.4020205@ru.mvista.com>
In-Reply-To: <49405640.4020205@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 11 Dec 2008 01:50:33.0688 (UTC) FILETIME=[DAF6F580:01C95B32]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21579
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Sergei Shtylyov wrote:
> Hello.
> 
> David Daney wrote:
>> The forthcoming OCTEON SOC Compact Flash driver needs an additional
>> timing value that was not available in the ata_timing table.  I add a
>> new column for dmack_hold time.  The values were obtained from the
>> Compact Flash specification Rev 4.1.
>>   
> 
>   Note that I wasn't telling you to drop t4, just to correct its value 
> for SWDMA modes.
> 

I decided I don't need it, so I tried to drop it...


>> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
>>   
> 
>   NAK, patch broken.
> 
[...]
>
>> @@ -864,6 +866,8 @@ struct ata_timing {
>>      unsigned short cyc8b;        /* t0 for 8-bit I/O */
>>      unsigned short active;        /* t2 or tD */
>>      unsigned short recover;        /* t2i or tK */
>> +    unsigned short write_hold;    /* t4 */
>> +    unsigned short dmack_hold;    /* tj */
>>      unsigned short cycle;        /* t0 */
>>      unsigned short udma;        /* t2CYCTYP/2 */
>>  };
>>   
> 
>   This is broken. You're still adding 2 fields but initializer doesný 
> much that.
> 

Sorry about that.  I am testing a fixed version.

David Daney
