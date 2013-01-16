Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jan 2013 19:58:05 +0100 (CET)
Received: from mail-pa0-f53.google.com ([209.85.220.53]:50463 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6832245Ab3APS6D3Z7Af (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Jan 2013 19:58:03 +0100
Received: by mail-pa0-f53.google.com with SMTP id hz1so947877pad.40
        for <multiple recipients>; Wed, 16 Jan 2013 10:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=nQk/I5n3bGk7dtcksvzHqj2jd5+Ib54AkOaBPw4wIz4=;
        b=tN4Wepu/xY7cyTKfWJID9lyKcB20CHNy+rA3MmJ7AWKD8NCuadwAwWRV12y4FPbvsb
         uiOmF/snFRWu87J3ATVRqTR//J4GszaSwpXBUvS8KZLr2KGC8hUhTRyx8kkHx/B3wz3p
         ffvMmoJGTaeuDp6LYR5hLEaawDLLgO/XrS5NEKGCHG7LneMCjni1LT99wVrIF/vvuTf9
         xqRsGabO9EoFKKJTg1Lbxn3xCoKOQKG4jtt6NFcVciz5Y18EWaO6tp/9+OlLtsLiPrSr
         Dh+51GsLfilwnmcvv8PFpZMYlE+kuYdMJMHDc5pqI8MdqyHZ9f9H6we3oA6kUFJsTytg
         smIg==
X-Received: by 10.68.252.100 with SMTP id zr4mr5449030pbc.103.1358362676317;
        Wed, 16 Jan 2013 10:57:56 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id v2sm13440485paz.36.2013.01.16.10.57.55
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 16 Jan 2013 10:57:55 -0800 (PST)
Message-ID: <50F6F832.1060807@gmail.com>
Date:   Wed, 16 Jan 2013 10:57:54 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     "Hill, Steven" <sjhill@mips.com>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "cernekee@gmail.com" <cernekee@gmail.com>,
        "kevink@paralogos.com" <kevink@paralogos.com>,
        "Daney, David" <David.Daney@caviumnetworks.com>
Subject: Re: [PATCH] [RFC] Proposed changes to eliminate 'union mips_instruction'
 type.
References: <1358230420-3575-1-git-send-email-sjhill@mips.com>,<50F5B0D0.9010604@gmail.com> <31E06A9FC96CEC488B43B19E2957C1B801146C51CC@exchdb03.mips.com> <50F5DA93.2080706@gmail.com>
In-Reply-To: <50F5DA93.2080706@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35472
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 01/15/2013 02:39 PM, David Daney wrote:
> On 01/15/2013 02:19 PM, Hill, Steven wrote:
>>>> This patch shows the use of macros in place of 'union mips_instruction'
>>>> type.
>>>>
>>> Why?  What are the benefits of doing this?
>>>
>> The microMIPS patches will not make it in due to the 4x size increase
>> of this structure. Also, as was mentioned on the list previously by
>> Ralf, it should have been done like this years back.
>
> A matter of opinion.  Bitfields have a certain elegance
>
> Personally I would investigate machine generating the file with the
> structure definitions.  That way you could insure consistency between
> big and little endian versions.

Like this:

------------------8<------------------
#include <stdio.h>

struct mips_insn_field {
	const char *field_name;
	const char *field_type;
	int width;
};

struct mips_insn_format {
	const char *format_name;
	const char *comment;
	struct mips_insn_field *fields;
};


static struct mips_insn_format *insn_types[] = {
	&(struct mips_insn_format){"j_format",
				   "Jump format",
				   (struct mips_insn_field[]){{"opcode", "unsigned", 6},
							      {"target", "unsigned", 26},
							      {0}}},

	&(struct mips_insn_format){"i_format",
				   "Immediate format (addi, lw, ...)",
				   (struct mips_insn_field[]){{"opcode", "unsigned", 6},
							      {"rs", "unsigned", 5},
							      {"rt", "unsigned", 5},
							      {"simmediate", "signed", 5},
							      {0}}},

	&(struct mips_insn_format){"u_format",
				   "Unsigned immediate format (ori, xori, ...)",
				   (struct mips_insn_field[]){{"opcode", "unsigned", 6},
							      {"rs", "unsigned", 5},
							      {"rt", "unsigned", 5},
							      {"uimmediate", "unsigned", 5},
							      {0}}},

	&(struct mips_insn_format){"c_format",
				   "Cache (>= R6000) format",
				   (struct mips_insn_field[]){{"opcode", "unsigned", 6},
							      {"rs", "unsigned", 5},
							      {"c_op", "unsigned", 3},
							      {"cacge", "unsigned", 2},
							      {"simmediate", "signed", 5},
							      {0}}},
	NULL
};


static void print_one_field(struct mips_insn_field *field)
{
	printf("\t%s int %s:%d\n", field->field_type, field->field_name, 
field->width);
}

static void print_one_format(struct mips_insn_format *type)
{
	int i;
	int num_fields = 0;
	struct mips_insn_field *field;

	field = type->fields;
	while (field->field_name) {
		num_fields++;
		field++;
	}

	printf("struct %s {", type->format_name);
	if (type->comment)
		printf("\t/* %s */\n", type->comment);
	else
		printf("\n");
	printf("#ifdef __MIPSEB__\n");

	for (i = 0; i < num_fields; i++)
		print_one_field(&type->fields[i]);
		
	printf("#else\n");

	for (i = num_fields - 1; i >= 0; i--)
		print_one_field(&type->fields[i]);

	printf("#endif\n");
	printf("};\n");
}

int main(int argc, char *argv[])
{
	struct mips_insn_format **type = insn_types;

	printf("/* Machine generated, do not edit. */\n");
	printf("/* Edit gen_mips_insns.c instead. */\n");

	while (*type) {
		print_one_format(*type);
		type++;
	}

	return 0;
}

------------------8<------------------


>
>
>>
>>>> +
>>>> +#define J_INSN(op,target)            ((op << 26) | target)
>>>
>>> What is the type of J_INSN()?  What happens if target overflows into the
>>> 'op' field?
>>>
>> Jump instruction, which is evident from the code removed in the patch.
>> The macros are not done, this is a prototype and bounds checking will
>> of course be done for the final. I mostly wanted to see if people were
>> happy with the macro names, how they are laid out in the header file
>> and syntactical nits.
>>
>
> For me it is much more important that the data types be correct and the
> overflow conditions are handled (and perhaps also warned about).
>
> The order in the file I don't care about.
>
>>>> +#define J_INSN_TARGET(insn)          (insn & 0x03ffffff)
>
> INSN_J_TARGET ...
>
>>>> +#define R_INSN(op,rs,rt,rd,re,func)  ((op << 26) | (rs << 21) |      \
>>>> +                                      (rt << 16) | (rd << 11) |      \
>>>> +                                      (re << 6) | func)
>
>
> #define INSN_RANGE_CHECK(v, bits) ({ \
>      u32 val = (v); \
>      u32 mask = (1 << bits) - 1; \
>      WARN((v & mask) != v, "YOU LOSE"); \
>      val; \
> })
>
> #define INSN_TYPE_R(op, rs, rt, rd, re, func) \
>   ((INSN_RANGE_CHECK((op), 6) << 26 | \
>    (INSN_RANGE_CHECK((rs), 5) << 21 | \
>    (INSN_RANGE_CHECK((rt), 5) << 16 | \
>    (INSN_RANGE_CHECK((rd), 5) << 11 | \
>    (INSN_RANGE_CHECK((re), 5) << 6 | \
>    (INSN_RANGE_CHECK((func), 6))
>
> But you cannot use that as a static initializer.
>
>
>>>> +#define F_INSN(op,fmt,rt,rd,re,func) R_INSN(op,fmt,rt,rd,re,func)
>>>> +#define F_INSN_FMT(insn)             INSN_RS(insn)
>>>> +#define U_INSN(op,rs,uimm)           ((op << 26) | (rs << 21) |
>>>> uimmediate)
>>>> [...]
>>>> +     unsigned int n_insn = insn.word;
>>>
>>> I don't like that the width of an insn is not obvious by looking at the
>>> code.
>>>
>>> Can we, assuming we merge something like this, make it something like
>>> u32, or insn_t?  I'm not sure which is better.
>>>
>> I was planning on making it a 'u32' but I am open to either one. Ralf,
>> which would you prefer?
>>
>> -Steve
>>
>
