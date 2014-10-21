Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2014 14:11:39 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:9395 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012026AbaJUMLailMWc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Oct 2014 14:11:30 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 9C8EE372DA236;
        Tue, 21 Oct 2014 13:11:21 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 21 Oct
 2014 13:11:23 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 21 Oct 2014 13:11:23 +0100
Received: from [192.168.154.141] (192.168.154.141) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 21 Oct
 2014 13:11:22 +0100
Message-ID: <54464D6A.5000501@imgtec.com>
Date:   Tue, 21 Oct 2014 13:11:22 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Richard Cochran <richardcochran@gmail.com>
CC:     <linux-mips@linux-mips.org>, Jonathan Corbet <corbet@lwn.net>,
        <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: ptp: Fix build failure on MIPS cross builds
References: <1413794538-28465-1-git-send-email-markos.chandras@imgtec.com> <20141021110724.GA16479@netboy>
In-Reply-To: <20141021110724.GA16479@netboy>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.141]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43421
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

On 10/21/2014 12:07 PM, Richard Cochran wrote:
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
> 
> Thanks,
> Richard
> 

As far as I can see you don't cross-compile the file. You use the host
toolchain. There is no clean way to build it for host if you have your
kernel configured for MIPS. Perhaps maybe you could define
__MIPS_SIM_{ABI64, ABI32, NABI32} in the gcc command line (-D...) but
this is a bit ugly. Or maybe use the host headers instead of the ones in
the kernel source.

-- 
markos
