Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Sep 2014 10:25:21 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:28403 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008635AbaIJIZRmDwgs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Sep 2014 10:25:17 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 6D0194539E91E;
        Wed, 10 Sep 2014 09:25:09 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 10 Sep
 2014 09:25:10 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 10 Sep 2014 09:25:10 +0100
Received: from [192.168.154.67] (192.168.154.67) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 10 Sep
 2014 09:25:09 +0100
Message-ID: <54100AE5.6050401@imgtec.com>
Date:   Wed, 10 Sep 2014 09:25:09 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
MIME-Version: 1.0
To:     Greg KH <greg@kroah.com>
CC:     <linux-mips@linux-mips.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        <linux-next@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>
Subject: Re: [PATCH linux-next] MIPS: ioctls: Add missing TIOC{S,G}RS485 definitions
References: <1410263575-26720-1-git-send-email-markos.chandras@imgtec.com> <20140909191736.GA7467@kroah.com>
In-Reply-To: <20140909191736.GA7467@kroah.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.67]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42487
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

On 09/09/2014 08:17 PM, Greg KH wrote:
> On Tue, Sep 09, 2014 at 12:52:55PM +0100, Markos Chandras wrote:
>> Commit e676253b19b2d269cccf67fdb1592120a0cd0676
>> (serial/8250: Add support for RS485 IOCTLs) added cases for the
>> TIOC{S,G}RS485 commands but this broke the build for MIPS:
>>
>> drivers/tty/serial/8250/8250_core.c: In function 'serial8250_ioctl':
>> drivers/tty/serial/8250/8250_core.c:2874:7: error: 'TIOCSRS485' undeclared
>> (first use in this function)
>> drivers/tty/serial/8250/8250_core.c:2886:7: error: 'TIOCGRS485' undeclared
>> (first use in this function)
>>
>> This patch adds these missing definitions
>>
>> Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
>> Cc: <linux-next@vger.kernel.org>
>> Cc: <linux-kernel@vger.kernel.org>
>> Cc: <linux-serial@vger.kernel.org>
>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>> ---
>>  arch/mips/include/uapi/asm/ioctls.h | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/mips/include/uapi/asm/ioctls.h b/arch/mips/include/uapi/asm/ioctls.h
>> index b1e637757fe3..34050cb6b631 100644
>> --- a/arch/mips/include/uapi/asm/ioctls.h
>> +++ b/arch/mips/include/uapi/asm/ioctls.h
>> @@ -76,6 +76,8 @@
>>  
>>  #define TIOCSBRK	0x5427	/* BSD compatibility */
>>  #define TIOCCBRK	0x5428	/* BSD compatibility */
>> +#define TIOCGRS485	0x542E
>> +#define TIOCSRS485	0x542F
> 
> Any reason you aren't using the _IOR() type macros here?
> 
> thanks,
> 
> greg k-h
> 
Hi Greg,

Not really. I am being consistent with what
include/uapi/asm-generic/ioctls.h is using, and with the xtensa patch
that was posted yesterday

https://lkml.org/lkml/2014/9/9/27

-- 
markos
