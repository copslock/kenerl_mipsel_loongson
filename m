Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jan 2013 20:41:17 +0100 (CET)
Received: from mail-da0-f48.google.com ([209.85.210.48]:64543 "EHLO
        mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6832208Ab3AOTlNDq0lB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Jan 2013 20:41:13 +0100
Received: by mail-da0-f48.google.com with SMTP id k18so186328dae.7
        for <multiple recipients>; Tue, 15 Jan 2013 11:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=AHnlWPAyEij0BReHwacG16bM6bZMCMls3qVspKTG5LY=;
        b=zwR8z0TKK48f7mz/Bc2nNUVY2HMQHlW4EN1ROFXB7YjrXWNP6K7BKjPwO4vaEXZify
         lZXrzxWs16zs+I6hItr+4TX5R9G/z/OBsjkgZzTibyrj9MC4QsVj/bBXpV4mSWvWOKmP
         HAdvqzvnQUo5061ahXU0WVieqkAfoePrSrGnkYJps9oGwm6RR70UvtHnsARvDeV3BkVm
         XsnepsLINKMvtzc2CvB9ldTwPdhwrCXwgooWnYHc2iBbk6hXCkMyv6ZtAXMQ0V0qJ8EW
         Lm3Ax3YYDNK/Gb3X4MeH+P3Eojjjsb9iu1yb+eVQndgmQFy3BliI9BbnXUHzfTfDKjB3
         OLqg==
X-Received: by 10.68.220.6 with SMTP id ps6mr267007958pbc.80.1358278866272;
        Tue, 15 Jan 2013 11:41:06 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id tq4sm10721802pbc.50.2013.01.15.11.41.05
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 15 Jan 2013 11:41:05 -0800 (PST)
Message-ID: <50F5B0D0.9010604@gmail.com>
Date:   Tue, 15 Jan 2013 11:41:04 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org, cernekee@gmail.com,
        kevink@paralogos.com
Subject: Re: [PATCH] [RFC] Proposed changes to eliminate 'union mips_instruction'
 type.
References: <1358230420-3575-1-git-send-email-sjhill@mips.com>
In-Reply-To: <1358230420-3575-1-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35449
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

On 01/14/2013 10:13 PM, Steven J. Hill wrote:
> From: "Steven J. Hill" <sjhill@mips.com>
>
> This patch shows the use of macros in place of 'union mips_instruction'
> type.

Why?  What are the benefits of doing this?

> I converted all usages of 'j_format' and 'r_format' to show how
> the code and macros could look and be defined. I have tested these
> changes on big and little endian platforms.
>
> I want input from everyone, please!!! I want consensus on the macro
> definitions, placement of parenthesis for them, spacing in the header
> file, etc. This is your chance to be completely anal and have fun
> arguments over how things should be. I would also like input on how
> the maintainers would like the patchsets to look like. For example:
>
>    [1/X] - Convert 'j_format'
>    [2/X] - Convert 'r_format'
>    [3/X] - Convert 'f_format'
>    [4/X] - Convert 'u_format'
>    ...
>    [X/X] - Remove usage of 'union mips_instruction' type completely.
>
> Also, I noticed 'p_format' is not used anywhere. Can we kill it? Be
> picky and help with this conversion. Thanks.
>
> Signed-off-by: Steven J. Hill <sjhill@mips.com>
> ---
>   arch/mips/include/asm/inst.h   |   66 +++++++++++-----------------------------
>   arch/mips/kernel/branch.c      |   13 ++++----
>   arch/mips/kernel/jump_label.c  |   10 +++---
>   arch/mips/kernel/kgdb.c        |   10 ++----
>   arch/mips/kernel/kprobes.c     |   18 +++++------
>   arch/mips/kernel/process.c     |   10 +++---
>   arch/mips/oprofile/backtrace.c |    2 +-
>   7 files changed, 46 insertions(+), 83 deletions(-)
>
> diff --git a/arch/mips/include/asm/inst.h b/arch/mips/include/asm/inst.h
> index ab84064..856b14e 100644
> --- a/arch/mips/include/asm/inst.h
> +++ b/arch/mips/include/asm/inst.h
> @@ -192,15 +192,27 @@ enum lx_func {
>   	lbx_op	= 0x16,
>   };
>
> +#define INSN_OPCODE(insn)		(insn >> 26)
> +#define INSN_RS(insn)			((insn >> 21) & 0x1f)
> +#define INSN_RT(insn)			((insn >> 16) & 0x1f)
> +#define INSN_RD(insn)			((insn >> 11) & 0x1f)
> +#define INSN_RE(insn)			((insn >> 6) & 0x1f)
> +#define INSN_FUNC(insn)			(insn & 0x0000003f)
> +
> +#define J_INSN(op,target)		((op << 26) | target)

What is the type of J_INSN()?  What happens if target overflows into the 
'op' field?


> +#define J_INSN_TARGET(insn)		(insn & 0x03ffffff)
> +#define R_INSN(op,rs,rt,rd,re,func)	((op << 26) | (rs << 21) |	\
> +					 (rt << 16) | (rd << 11) |	\
> +					 (re << 6) | func)
> +#define F_INSN(op,fmt,rt,rd,re,func)	R_INSN(op,fmt,rt,rd,re,func)
> +#define F_INSN_FMT(insn)		INSN_RS(insn)
> +#define U_INSN(op,rs,uimm)		((op << 26) | (rs << 21) | uimmediate)
[...]
> +	unsigned int n_insn = insn.word;

I don't like that the width of an insn is not obvious by looking at the 
code.

Can we, assuming we merge something like this, make it something like 
u32, or insn_t?  I'm not sure which is better.


[...]

David Daney
