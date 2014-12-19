Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Dec 2014 09:52:33 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:17579 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007783AbaLSIwcKA402 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Dec 2014 09:52:32 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 1C64077D2FDFF;
        Fri, 19 Dec 2014 08:52:25 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 19 Dec 2014 08:52:26 +0000
Received: from [192.168.154.125] (192.168.154.125) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 19 Dec
 2014 08:52:25 +0000
Message-ID: <5493E749.9020001@imgtec.com>
Date:   Fri, 19 Dec 2014 08:52:25 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH RFC 56/67] MIPS: kernel: branch: Emulate the BOVC, BEQC
 and BEQZALC R6 instructions
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com> <1418915416-3196-57-git-send-email-markos.chandras@imgtec.com> <549325E8.3040802@gmail.com>
In-Reply-To: <549325E8.3040802@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.125]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44829
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

On 12/18/2014 07:07 PM, David Daney wrote:
> On 12/18/2014 07:10 AM, Markos Chandras wrote:
>> MIPS R6 uses the <R6 ADDI opcode for the new BOVC, BEQC and
>> BEQZALC instructions.
>>
>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>> ---
>>   arch/mips/include/uapi/asm/inst.h | 2 +-
>>   arch/mips/kernel/branch.c         | 6 ++++++
>>   2 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/mips/include/uapi/asm/inst.h
>> b/arch/mips/include/uapi/asm/inst.h
>> index 648addfe1e1c..b95363e0551f 100644
>> --- a/arch/mips/include/uapi/asm/inst.h
>> +++ b/arch/mips/include/uapi/asm/inst.h
>> @@ -21,7 +21,7 @@
>>   enum major_op {
>>       spec_op, bcond_op, j_op, jal_op,
>>       beq_op, bne_op, blez_op, bgtz_op,
>> -    addi_op, addiu_op, slti_op, sltiu_op,
>> +    addi_or_cbcond0_op, addiu_op, slti_op, sltiu_op,
> 
> NAK.
> 
> This is a kernel ABI document, you cannot remove symbols.
ok i will find another way to workaround this. thanks

-- 
markos
