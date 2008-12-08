Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Dec 2008 18:29:33 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:10209 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24207486AbYLHS3b (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 8 Dec 2008 18:29:31 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B493d676e000a>; Mon, 08 Dec 2008 13:29:02 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 8 Dec 2008 10:22:00 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 8 Dec 2008 10:22:00 -0800
Message-ID: <493D65C8.2060808@caviumnetworks.com>
Date:	Mon, 08 Dec 2008 10:22:00 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.18 (X11/20081119)
MIME-Version: 1.0
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
CC:	linux-ide@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] libata: Add two more columns to the ata_timing table.
References: <4939B402.9010004@caviumnetworks.com> <1228518561-16242-1-git-send-email-ddaney@caviumnetworks.com> <493ADE48.6050709@ru.mvista.com>
In-Reply-To: <493ADE48.6050709@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Dec 2008 18:22:00.0763 (UTC) FILETIME=[DCC900B0:01C95961]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21548
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
> 
>> The forthcoming OCTEON SOC Compact Flash driver needs a few more
>> timing values than were available in the ata_timing table.  I add new
>> columns for write_hold and read_holdz times.  The values were obtained
>> from the Compact Flash specification Rev 4.1.
> 
>> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> 
> NAK.
> 
>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>> index ed3f26e..95fa9f6 100644
>> --- a/include/linux/libata.h
>> +++ b/include/linux/libata.h
> [...]
>>  enum ata_xfer_mask {
>> @@ -864,6 +868,8 @@ struct ata_timing {
>>      unsigned short cyc8b;        /* t0 for 8-bit I/O */
>>      unsigned short active;        /* t2 or tD */
>>      unsigned short recover;        /* t2i or tK */
>> +    unsigned short write_hold;    /* t4 */
>> +    unsigned short read_holdz;    /* t6z */
> 
>    Sorry for failing to notice this before but t6z is again the timing 
> that the host can't control. Therefore I'm seeig no sense in its 
> addition.

The host cannot control t6z, but in some cases (like ours) it needs to 
be aware of its value.  We cannot start driving the bus for access to 
other devices until the CF stops driving it.  We need to know how long 
to wait until it is safe to use the bus for other things.


> I don't know how your driver is going to use it -- but most 
> probably incorrectly...

Thanks for that vote of confidence.


David Daney
