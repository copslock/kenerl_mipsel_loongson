Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Dec 2014 10:01:54 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:1928 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009128AbaLSJBwoxana (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Dec 2014 10:01:52 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 96C22BCE3846B;
        Fri, 19 Dec 2014 09:01:45 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 19 Dec 2014 09:01:47 +0000
Received: from [192.168.154.125] (192.168.154.125) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 19 Dec
 2014 09:01:46 +0000
Message-ID: <5493E97A.1070608@imgtec.com>
Date:   Fri, 19 Dec 2014 09:01:46 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH RFC 12/67] MIPS: asm: asmmacro: Replace add instructions
 with "addui"
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com> <1418915416-3196-13-git-send-email-markos.chandras@imgtec.com> <54932370.605@gmail.com>
In-Reply-To: <54932370.605@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.125]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44831
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

On 12/18/2014 06:56 PM, David Daney wrote:
> On 12/18/2014 07:09 AM, Markos Chandras wrote:
>> The use of "add" instruction for immediate operations is wrong and
>> relies to gas being smart enough to notice that and replace it with
>> either addi or addui. However, MIPS R6 removed the addi instruction
>> so, fix this problem properly by using the correct instruction
>> directly.
>>
> 
> This is another case of the use of "add" being a real bug.  We should
> never have faulting instructions like this in the kernel.
> 
> Can you send all patches in this set that fix this bug as a separate
> patch?  Since they are obviously correct, and really should be used by
> all non-R6 processors, we can get them in sooner that the entire R6 thing.
> 
> Thanks,
> David Daney

sure i will move these patches away from R6 and post them separately.

-- 
markos
