Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Feb 2014 00:14:00 +0100 (CET)
Received: from nm26.bullet.mail.ir2.yahoo.com ([212.82.96.50]:26885 "EHLO
        nm26.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825747AbaBJXN6Gqv0y convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Feb 2014 00:13:58 +0100
Received: from [212.82.98.54] by nm26.bullet.mail.ir2.yahoo.com with NNFMP; 10 Feb 2014 23:13:52 -0000
Received: from [212.82.98.121] by tm7.bullet.mail.ir2.yahoo.com with NNFMP; 10 Feb 2014 23:13:52 -0000
Received: from [127.0.0.1] by omp1058.mail.ir2.yahoo.com with NNFMP; 10 Feb 2014 23:13:52 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 226130.92793.bm@omp1058.mail.ir2.yahoo.com
Received: (qmail 95760 invoked by uid 60001); 10 Feb 2014 23:13:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.co.uk; s=s1024; t=1392074031; bh=aZ3njpTneMVyoLjYv3ewCDLCnvWNMkG96ybhtwGsLOU=; h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:Message-ID:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=XcxGxSjIdOSFaf6zAwVZeyrepLdgypSqy5y/Bvj8Ehn5NaLKMEIYXhO6f/9/cmic+gHGqmX2OrVr85myIV1R1rqhghnY+zfFDuwbSPzM2XFADejaaanlqDEYPcC+zEA5FoZdJJ6PebAFyaid7tEbjcxtQSvIcCQBN/6VM6duYbM=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.uk;
  h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:Message-ID:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=OGT0bEQcbrytAqc7+z5fFw2ql3ZPC/VdeMLS0pP576PGHdBRoyT+HhLkyvlc2YjQ7TcjVUGDSX3cLpqXBQTK7YXdtbvP0C0rJJPebNKFJxVa1bAUs8zeiT5q0gkPfYiOTi4n07+hPABlpcb+X+kvn0CYV1Vm+Gzvk3E4cT9TXNY=;
X-YMail-OSG: g4B9aCUVM1nLfCkBzpFLq5PUrLVI00ut5aIu8AP8akjHfcI
 .RZ0r6scBg3FcmfCwxF6NcfLIH3i39DqkpAmurKD0jvJlRyFIwkz3ebAAAyu
 sK52avnS2MH8syq5TMnKD3gIhMhsrv0oS4fOsK.x5wiAstU9ZyFGYt1HQ0Bu
 96ZfBOydkR7jfo4GrLAbMtE_MEwbwqnS5_S3mLEy03pMpbqGGfIqxeaiCkcE
 eVWvbWKyYOn7MA1nPA1mKhQY4txFL8m8P40JHqT2mTbEeuWSSR68dvL7sFFO
 uzh_iPIxno2qeChE7ELdGYxPi0tdXRCiKUHZyiiYQ0coYcz1B8DLpIKTmjqf
 G65syz.ZrSN9hAdAyY13toCE7dLvzkrtwzmk3Ksdfc5Q4pjDjIolzhMH.kC4
 86OD9mfpAlvQraFTFWeXA37cxD69LSSS2lwa3rELNBqQIcuYWG8swJX0Kpgy
 zf6SWtT2RcC.pfkiZUntZaZFHDln97WRi93aAF_niqxSddYQIT.jqwaWr4hu
 YlNnMOg_VokzIQHjNlkLtcW2.fwEIHvj86x1daZTHJLNpv_cQFJGmmc84jlE
 MKw--
Received: from [86.30.137.134] by web172302.mail.ir2.yahoo.com via HTTP; Mon, 10 Feb 2014 23:13:51 GMT
X-Rocket-MIMEInfo: 002.001,Cg0KDQoNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpPbiBNb24sIEZlYiAxMCwgMjAxNCAxMDo1MCBQTSBHTVQgTGFycnkgRmluZ2VyIHdyb3RlOg0KDQo.T24gMDIvMTAvMjAxNCAwMzozOCBQTSwgU3RhbmlzbGF3IEdydXN6a2Egd3JvdGU6DQo.PiBUaGlzIHBhdGNoIGZpeGVzIHJlZ3Jlc3Npb24gY2F1c2VkIGJ5IGNvbW1pdCBhMTZkYWQ3NzYzNCAiTUlQUzogRml4DQo.PiBwb3RlbmNpYWwgY29ycnVwdGlvbiIuIFRoYXQgY29tbWl0IGZpeGVzIG9uZSBjb3JydXB0aW9uIHNjZW5hcmlvIGkBMAEBAQE-
X-Mailer: YahooMailWebService/0.8.176.634
Message-ID: <1392074031.26053.BPMail_high_noncarrier@web172302.mail.ir2.yahoo.com>
Date:   Mon, 10 Feb 2014 23:13:51 +0000 (GMT)
From:   Hin-Tak Leung <hintak_leung@yahoo.co.uk>
Subject: Re: [PATCH] rtl8187: fix regression on MIPS without coherent DMA
To:     larry.finger@lwfinger.net, stf_xl@wp.pl,
        linux-wireless@vger.kernel.org
Cc:     herton@canonical.com, linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-Path: <hintak_leung@yahoo.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39271
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hintak_leung@yahoo.co.uk
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips






------------------------------
On Mon, Feb 10, 2014 10:50 PM GMT Larry Finger wrote:

>On 02/10/2014 03:38 PM, Stanislaw Gruszka wrote:
>> This patch fixes regression caused by commit a16dad77634 "MIPS: Fix
>> potencial corruption". That commit fixes one corruption scenario in
>> cost of adding another one, which actually start to cause crashes
>> on Yeeloong laptop when rtl8187 driver is used.
>>
>> For correct DMA read operation on machines without DMA coherence, kernel
>> have to invalidate cache, such it will refill later with new data that
>> device wrote to memory, when that data is needed to process. We can only
>> invalidate full cache line. Hence when cache line includes both dma
>> buffer and some other data (written in cache, but not yet in main
>> memory), the other data can not hit memory due to invalidation. That
>> happen on rtl8187 where struct rtl8187_priv fields are located just
>> before and after small buffers that are passed to USB layer and DMA
>> is performed on them.
>>
>> To fix the problem we align buffers and reserve space after them to make
>> them match cache line.
>>
>> This patch does not resolve all possible MIPS problems entirely, for
>> that we have to assure that we always map cache aligned buffers for DMA,
>> what can be complex or even not possible. But patch fixes visible and
>> reproducible regression and seems other possible corruptions do not
>> happen in practice, since Yeeloong laptop works stable without rtl8187
>> driver.
>>
>> Bug report:
>> https://bugzilla.kernel.org/show_bug.cgi?id=54391
>>
>> Reported-by: Petr Pisar <petr.pisar@atlas.cz>
>> Bisected-by: Tom Li <biergaizi2009@gmail.com>
>> Reported-and-tested-by: Tom Li <biergaizi2009@gmail.com>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
>> ---
>
>Congratulations to all for sorting this out. It could not have been too easy.
>
>The only effect I see on architectures with DMA coherence is that the private 
>data area has grown a little. Certainly, my RTL8187B device still works on x86_64.
>
>Acked-by: Larry Finger <Larry.Finger@lwfinger.next>
>
>Larry
>
>>   drivers/net/wireless/rtl818x/rtl8187/rtl8187.h |   10 ++++++++--
>>   1 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/wireless/rtl818x/rtl8187/rtl8187.h b/drivers/net/wireless/rtl818x/rtl8187/rtl8187.h
>> index 56aee06..a6ad79f 100644
>> --- a/drivers/net/wireless/rtl818x/rtl8187/rtl8187.h
>> +++ b/drivers/net/wireless/rtl818x/rtl8187/rtl8187.h
>> @@ -15,6 +15,8 @@
>>   #ifndef RTL8187_H
>>   #define RTL8187_H
>>
>> +#include <linux/cache.h>
>> +
>>   #include "rtl818x.h"
>>   #include "leds.h"
>>
>> @@ -139,7 +141,10 @@ struct rtl8187_priv {
>>   	u8 aifsn[4];
>>   	u8 rfkill_mask;
>>   	struct {
>> -		__le64 buf;
>> +		union {
>> +			__le64 buf;
>> +			u8 dummy1[L1_CACHE_BYTES];
>> +		} ____cacheline_aligned;
>>   		struct sk_buff_head queue;
>>   	} b_tx_status; /* This queue is used by both -b and non-b devices */
>>   	struct mutex io_mutex;
>> @@ -147,7 +152,8 @@ struct rtl8187_priv {
>>   		u8 bits8;
>>   		__le16 bits16;
>>   		__le32 bits32;
>> -	} *io_dmabuf;
>> +		u8 dummy2[L1_CACHE_BYTES];
>> +	} *io_dmabuf ____cacheline_aligned;
>>   	bool rfkill_off;
>>   	u16 seqno;
>>   };
>>
>
