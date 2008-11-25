Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2008 17:02:27 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:28573 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S23909330AbYKYRCU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 25 Nov 2008 17:02:20 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id D17653ECA; Tue, 25 Nov 2008 09:02:14 -0800 (PST)
Message-ID: <492C2F97.3000400@ru.mvista.com>
Date:	Tue, 25 Nov 2008 20:02:15 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-ide@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] libata: Add three more columns to the ata_timing
 table.
References: <492B56B0.9030409@caviumnetworks.com> <1227577181-30206-1-git-send-email-ddaney@caviumnetworks.com> <492BDB28.8020103@ru.mvista.com> <492C2BCE.60409@caviumnetworks.com>
In-Reply-To: <492C2BCE.60409@caviumnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21420
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

David Daney wrote:

>>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>>> index 59b0f1c..7c44e45 100644
>>> --- a/include/linux/libata.h
>>> +++ b/include/linux/libata.h

>> [...]

>>> @@ -863,6 +868,9 @@ struct ata_timing {
>>>      unsigned short cyc8b;        /* t0 for 8-bit I/O */
>>>      unsigned short active;        /* t2 or tD */
>>>      unsigned short recover;        /* t2i or tK */
>>> +    unsigned short write_hold;    /* t4 */
>>> +    unsigned short read_hold;    /* t6 */

>>   -DIOR hold time is 5 ns for all PIO and MWDMA modes -- there's no 
>> sense in storing it here.

    Oops, that doesn't follow indeed...

> By storing it here, ata_timing_compute() will compute the bus clock 
> counts for me.  Makes perfect sense to me.

    Then let's just put *every* timing specified by the ATA standard there. 
That would be consistent at least. :-)

>>> +    unsigned short read_holdz;    /* t6z  or tj */

>>   T6z and Tj are not the same timing. Well, you specify it as 0 for  
>> DMA modes anyway...

> I had intended to overload this column for DMA, but somehow screwed it 
> up.  For my next patch I plan to populate this column for DMA modes.

    There seems to be no timing "parallel" for T6z in the DMA transfers, so 
you'll need another field then. Remember, the PIO and DMA timings are also 
"mergeable" -- by selecting the maximum field value of 2 'struct ata_timing' 
instances, so there should be no arbitrary field overloading.

> David Daney

WBR, Sergei
