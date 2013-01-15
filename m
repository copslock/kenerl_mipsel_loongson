Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jan 2013 23:20:29 +0100 (CET)
Received: from dns1.mips.com ([12.201.5.69]:51031 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6832214Ab3AOWUY1G3Si convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Jan 2013 23:20:24 +0100
Received: from mailgate1.mips.com (mailgate1.mips.com [12.201.5.111])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id r0FMKGtE005120;
        Tue, 15 Jan 2013 14:20:16 -0800
X-WSS-ID: 0MGOU0P-01-0FP-02
X-M-MSG: 
Received: from exchdb01.mips.com (unknown [192.168.36.84])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mailgate1.mips.com (Postfix) with ESMTP id 2AF7B36467A;
        Tue, 15 Jan 2013 14:19:37 -0800 (PST)
Received: from EXCHDB03.MIPS.com ([fe80::6df1:ae84:797e:9076]) by
 exchhub01.mips.com ([::1]) with mapi id 14.02.0247.003; Tue, 15 Jan 2013
 14:19:32 -0800
From:   "Hill, Steven" <sjhill@mips.com>
To:     David Daney <ddaney.cavm@gmail.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "cernekee@gmail.com" <cernekee@gmail.com>,
        "kevink@paralogos.com" <kevink@paralogos.com>
Subject: RE: [PATCH] [RFC] Proposed changes to eliminate 'union
 mips_instruction' type.
Thread-Topic: [PATCH] [RFC] Proposed changes to eliminate 'union
 mips_instruction' type.
Thread-Index: AQHN8ud/23VXA8A/UkelDJ80Zymw1ZhLUM8A//+kFDE=
Date:   Tue, 15 Jan 2013 22:19:31 +0000
Message-ID: <31E06A9FC96CEC488B43B19E2957C1B801146C51CC@exchdb03.mips.com>
References: <1358230420-3575-1-git-send-email-sjhill@mips.com>,<50F5B0D0.9010604@gmail.com>
In-Reply-To: <50F5B0D0.9010604@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.36.79]
x-ems-proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
x-ems-stamp: JUJ4vq3SnmL5aHhi7nOVqA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 35453
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

>> This patch shows the use of macros in place of 'union mips_instruction'
>> type.
>>
> Why?  What are the benefits of doing this?
>
The microMIPS patches will not make it in due to the 4x size increase of this structure. Also, as was mentioned on the list previously by Ralf, it should have been done like this years back.

>> +
>> +#define J_INSN(op,target)            ((op << 26) | target)
>
> What is the type of J_INSN()?  What happens if target overflows into the
> 'op' field?
>
Jump instruction, which is evident from the code removed in the patch. The macros are not done, this is a prototype and bounds checking will of course be done for the final. I mostly wanted to see if people were happy with the macro names, how they are laid out in the header file and syntactical nits.

>> +#define J_INSN_TARGET(insn)          (insn & 0x03ffffff)
>> +#define R_INSN(op,rs,rt,rd,re,func)  ((op << 26) | (rs << 21) |      \
>> +                                      (rt << 16) | (rd << 11) |      \
>> +                                      (re << 6) | func)
>> +#define F_INSN(op,fmt,rt,rd,re,func) R_INSN(op,fmt,rt,rd,re,func)
>> +#define F_INSN_FMT(insn)             INSN_RS(insn)
>> +#define U_INSN(op,rs,uimm)           ((op << 26) | (rs << 21) | uimmediate)
>>[...]
>> +     unsigned int n_insn = insn.word;
>
> I don't like that the width of an insn is not obvious by looking at the
> code.
>
> Can we, assuming we merge something like this, make it something like
> u32, or insn_t?  I'm not sure which is better.
>
I was planning on making it a 'u32' but I am open to either one. Ralf, which would you prefer?

-Steve
