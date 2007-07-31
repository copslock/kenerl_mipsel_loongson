Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jul 2007 01:48:00 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:44185 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20023048AbXGaAr6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 31 Jul 2007 01:47:58 +0100
Received: (qmail 10403 invoked by uid 511); 31 Jul 2007 00:51:49 -0000
Received: from unknown (HELO ?192.168.2.233?) (192.168.2.233)
  by lemote.com with SMTP; 31 Jul 2007 00:51:49 -0000
Message-ID: <46AE8674.7020702@lemote.com>
Date:	Tue, 31 Jul 2007 08:46:44 +0800
From:	Songmao Tian <tiansm@lemote.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To:	"Steven J. Hill" <sjhill@realitydiluted.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Add errno definition to pm.h
References: <46AE05DE.1020109@lemote.com> <20070730154552.GA4937@real.realitydiluted.com>
In-Reply-To: <20070730154552.GA4937@real.realitydiluted.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15956
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips

Steven J. Hill wrote:
> On Mon, Jul 30, 2007 at 11:38:06PM +0800, Songmao Tian wrote:
>   
>> commit 296699de6bdc717189a331ab6bbe90e05c94db06 add
>> static inline int pm_suspend(suspend_state_t state) { return -ENOSYS; }
>> which need errno definition
>>
>> Signed-off-by: Songmao Tian <tiansm@lemote.com>
>>
>> diff --git a/include/linux/pm.h b/include/linux/pm.h
>> index e52f6f8..48b71ba 100644
>> --- a/include/linux/pm.h
>> +++ b/include/linux/pm.h
>> @@ -25,6 +25,7 @@
>>
>> #include <linux/list.h>
>> #include <asm/atomic.h>
>> +#include <asm/errno.h>
>>
>>     
> You should be including <linux/errno.h> which then includes the
> architecture-specific file. This patch should be rejected.
>
> -Steve
>
>
>
>   

Oh I see:)


Songmao Tian
