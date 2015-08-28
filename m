Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Aug 2015 16:06:30 +0200 (CEST)
Received: from mail.efficios.com ([78.47.125.74]:60397 "EHLO mail.efficios.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006585AbbH1OG2kh4jC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 28 Aug 2015 16:06:28 +0200
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 135C5340240;
        Fri, 28 Aug 2015 14:06:24 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id FD8c1MhfUPXB; Fri, 28 Aug 2015 14:06:14 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id EC55E340366;
        Fri, 28 Aug 2015 14:06:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9Tm5LI0HSWG8; Fri, 28 Aug 2015 14:06:13 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
        by mail.efficios.com (Postfix) with ESMTP id BA4BB340240;
        Fri, 28 Aug 2015 14:06:13 +0000 (UTC)
Date:   Fri, 28 Aug 2015 14:06:12 +0000 (UTC)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-api <linux-api@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Message-ID: <815178017.30970.1440770772982.JavaMail.zimbra@efficios.com>
In-Reply-To: <20150828074034.GA22604@linux-mips.org>
References: <1440698215-8355-1-git-send-email-mathieu.desnoyers@efficios.com> <1440698215-8355-5-git-send-email-mathieu.desnoyers@efficios.com> <20150828074034.GA22604@linux-mips.org>
Subject: Re: [RFC PATCH 4/9] mips: allocate sys_membarrier system call
 number
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [78.47.125.74]
X-Mailer: Zimbra 8.6.0_GA_1178 (ZimbraWebClient - FF40 (Linux)/8.6.0_GA_1178)
Thread-Topic: mips: allocate sys_membarrier system call number
Thread-Index: BIZvjBuqQXs18scgct95Dl4bm+8eDw==
Return-Path: <compudj@efficios.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49063
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mathieu.desnoyers@efficios.com
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

----- On Aug 28, 2015, at 3:40 AM, Ralf Baechle ralf@linux-mips.org wrote:

> On Thu, Aug 27, 2015 at 01:56:50PM -0400, Mathieu Desnoyers wrote:
> 
>> [ Untested on this architecture. To try it out: fetch linux-next/akpm,
>>   apply this patch, build/run a membarrier-enabled kernel, and do make
>>   kselftest. ]
>> 
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> CC: Andrew Morton <akpm@linux-foundation.org>
>> CC: linux-api@vger.kernel.org
>> CC: Ralf Baechle <ralf@linux-mips.org>
>> CC: linux-mips@linux-mips.org
>> ---
>>  arch/mips/include/uapi/asm/unistd.h | 15 +++++++++------
>>  arch/mips/kernel/scall32-o32.S      |  1 +
>>  arch/mips/kernel/scall64-64.S       |  1 +
>>  arch/mips/kernel/scall64-n32.S      |  1 +
>>  arch/mips/kernel/scall64-o32.S      |  1 +
>>  5 files changed, 13 insertions(+), 6 deletions(-)
> 
> Looking good assuming there is no compat syscall required.

Indeed, sys_membarrier only takes two integer arguments, so no
compat syscall is required.

Thanks!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
