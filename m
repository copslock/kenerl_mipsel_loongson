Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2014 18:35:54 +0200 (CEST)
Received: from shards.monkeyblade.net ([149.20.54.216]:35662 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012061AbaJUQfxCwghY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Oct 2014 18:35:53 +0200
Received: from localhost (nat-pool-rdu-t.redhat.com [66.187.233.202])
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4168958432A;
        Tue, 21 Oct 2014 09:35:48 -0700 (PDT)
Date:   Tue, 21 Oct 2014 12:35:44 -0400 (EDT)
Message-Id: <20141021.123544.9516812519754063.davem@davemloft.net>
To:     richardcochran@gmail.com
Cc:     markos.chandras@imgtec.com, linux-mips@linux-mips.org,
        corbet@lwn.net, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: ptp: Fix build failure on MIPS cross
 builds
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20141021110724.GA16479@netboy>
References: <1413794538-28465-1-git-send-email-markos.chandras@imgtec.com>
        <20141021110724.GA16479@netboy>
X-Mailer: Mew version 6.5 on Emacs 24.1 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.7 (shards.monkeyblade.net [149.20.54.216]); Tue, 21 Oct 2014 09:35:49 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43426
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
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

From: Richard Cochran <richardcochran@gmail.com>
Date: Tue, 21 Oct 2014 13:07:25 +0200

> On Mon, Oct 20, 2014 at 09:42:18AM +0100, Markos Chandras wrote:
>> diff --git a/Documentation/ptp/Makefile b/Documentation/ptp/Makefile
>> index 293d6c09a11f..397c1cd2eda7 100644
>> --- a/Documentation/ptp/Makefile
>> +++ b/Documentation/ptp/Makefile
>> @@ -1,5 +1,15 @@
>>  # List of programs to build
>> +ifndef CROSS_COMPILE
>>  hostprogs-y := testptp
>> +else
>> +# MIPS system calls are defined based on the -mabi that is passed
>> +# to the toolchain which may or may not be a valid option
>> +# for the host toolchain. So disable testptp if target architecture
>> +# is MIPS but the host isn't.
>> +ifndef CONFIG_MIPS
>> +hostprogs-y := testptp
>> +endif
>> +endif
> 
> It seems like a shame to simply give up and not compile this at all.
> Is there no way to correctly cross compile this for MIPS?

Yeah seriously, we should try to make this work instead of throwing our
hands in the air.
