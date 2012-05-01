Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 May 2012 02:51:34 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:17892 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903724Ab2EAAva (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 May 2012 02:51:30 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4f9f33f50000>; Mon, 30 Apr 2012 17:53:09 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 30 Apr 2012 17:51:20 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 30 Apr 2012 17:51:20 -0700
Message-ID: <4F9F3387.1050500@cavium.com>
Date:   Mon, 30 Apr 2012 17:51:19 -0700
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     "Steven J. Hill" <sjhill@mips.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Subject: Re: [PATCH 04/10] MIPS: Add micro-assembler support for 'ins' and
 'ext' instructions.
References: <1333817315-30091-1-git-send-email-sjhill@mips.com> <1333817315-30091-5-git-send-email-sjhill@mips.com> <alpine.LFD.2.00.1204300459120.19691@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.00.1204300459120.19691@eddie.linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 May 2012 00:51:20.0045 (UTC) FILETIME=[85D0D1D0:01CD2734]
X-archive-position: 33106
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 04/30/2012 05:26 PM, Maciej W. Rozycki wrote:
> On Sat, 7 Apr 2012, Steven J. Hill wrote:
>
>> diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
>> index 5fa1851..fb6d8e27 100644
>> --- a/arch/mips/mm/uasm.c
>> +++ b/arch/mips/mm/uasm.c
>> @@ -63,6 +63,7 @@ enum opcode {
>>   	insn_bne, insn_cache, insn_daddu, insn_daddiu, insn_dmfc0,
>>   	insn_dmtc0, insn_dsll, insn_dsll32, insn_dsra, insn_dsrl,
>>   	insn_dsrl32, insn_drotr, insn_drotr32, insn_dsubu, insn_eret,
>> +	insn_ins, insn_ext,
>>   	insn_j, insn_jal, insn_jr, insn_ld, insn_ll, insn_lld,
>>   	insn_lui, insn_lw, insn_mfc0, insn_mtc0, insn_or, insn_ori,
>>   	insn_pref, insn_rfe, insn_sc, insn_scd, insn_sd, insn_sll,
>> @@ -113,6 +114,8 @@ static struct insn insn_table[] __uasminitdata = {
>>   	{ insn_drotr32, M(spec_op, 1, 0, 0, 0, dsrl32_op), RT | RD | RE },
>>   	{ insn_dsubu, M(spec_op, 0, 0, 0, 0, dsubu_op), RS | RT | RD },
>>   	{ insn_eret,  M(cop0_op, cop_op, 0, 0, 0, eret_op),  0 },
>> +	{ insn_ins, M(spec3_op, 0, 0, 0, 0, ins_op), RS | RT | RD | RE },
>> +	{ insn_ext, M(spec3_op, 0, 0, 0, 0, ext_op), RS | RT | RD | RE },
>>   	{ insn_j,  M(j_op, 0, 0, 0, 0, 0),  JIMM },
>>   	{ insn_jal,  M(jal_op, 0, 0, 0, 0, 0),  JIMM },
>>   	{ insn_jr,  M(spec_op, 0, 0, 0, 0, jr_op),  RS },
>
>   Not an extensive review -- just noticed this issue while browsing...
>
>   These two data definitions are clearly alphabetically ordered, so please
> keep them as such.  It seems rather a trivial update in this case -- just
> swap the new entries.  Thanks.

Well I broke the ordering with a bunch of my patches lower down.

Perhaps we should fix it so it goes back to being ordered.

David Daney
