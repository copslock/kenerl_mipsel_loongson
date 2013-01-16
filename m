Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jan 2013 23:24:36 +0100 (CET)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:48967 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6832241Ab3APWYf2GgRB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Jan 2013 23:24:35 +0100
Received: by mail-pa0-f42.google.com with SMTP id rl6so1049332pac.15
        for <multiple recipients>; Wed, 16 Jan 2013 14:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=xTjGF6BNRU/liX+6gyfa74qGWG1QFfl28GWN0yGLXJA=;
        b=0HpGoH1fe3kG1aJ0+WBXnx1A9ifbPrEXVmw42TKY9KbJ1SYh+rLZDD1+buYVpQifXr
         /H6g+FqfOCZg1xrbzMO4OL1aqtM0Uhp5SPnT50zFWLVF0W9FwoULcvS0bfVAIiG3QFzO
         wofhdY0L4y5LsxCw4kOYTLDD0Vbmk0dNbUtw8wXfWehVvQ04Dz4J0gCVo9Wq16Yk2N37
         cDJxTDpenentcF7oavz/O8jaDdymAAkplgO0sYzGm2i8GHAo9AlB4k4gVNvXodna/wHG
         aYWo7w9qGnq1lh2zaJ+8g1TNL97wOh1Y5i8PRN3gdb+3SPyCOweghMXh2fvz/rWd3T+A
         teUA==
X-Received: by 10.68.203.198 with SMTP id ks6mr7063136pbc.35.1358375068553;
        Wed, 16 Jan 2013 14:24:28 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id oj1sm12990330pbb.19.2013.01.16.14.24.27
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 16 Jan 2013 14:24:27 -0800 (PST)
Message-ID: <50F7289A.3000102@gmail.com>
Date:   Wed, 16 Jan 2013 14:24:26 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     "Hill, Steven" <sjhill@mips.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "cernekee@gmail.com" <cernekee@gmail.com>,
        "kevink@paralogos.com" <kevink@paralogos.com>
Subject: Re: [PATCH] [RFC] Proposed changes to eliminate 'union mips_instruction'
 type.
References: <1358230420-3575-1-git-send-email-sjhill@mips.com> <50F5B0D0.9010604@gmail.com> <31E06A9FC96CEC488B43B19E2957C1B801146C51CC@exchdb03.mips.com> <50F5DA93.2080706@gmail.com> <20130116141618.GC26569@linux-mips.org>
In-Reply-To: <20130116141618.GC26569@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35474
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

On 01/16/2013 06:16 AM, Ralf Baechle wrote:
> On Tue, Jan 15, 2013 at 02:39:15PM -0800, David Daney wrote:
>
> So this should be fairly readable, far less code and in especially no
> more variants for endianess except a single simple macro.
>
> What do you think?

Very tricky.  I like it.

However, a small change is needed...

[...]
> +#define BITFIELD_FIELD(field, more)					\
> +	field;								\
> +	more
>
>   #elif defined(__MIPSEL__)
>
[...]
> +#define BITFIELD_FIELD(field, more)					\
> +	more								\
> +	field;
>
>   #else /* !defined (__MIPSEB__) && !defined (__MIPSEL__) */
>   #error "MIPS but neither __MIPSEL__ nor __MIPSEB__?"
>   #endif
>
> +struct j_format {
> +	BITFIELD_FIELD(unsigned int opcode : 6,	/* Jump format */
> +	BITFIELD_FIELD(unsigned int target : 26,

... In the very last BITFIELD_FIELD(), you need a valid token as the 
second parameter, otherwise (according to Pinski) C90 behavior is undefined.

Use a ';'



> +	))
> +};
> +
> +struct i_format {			/* signed immediate format */
> +	BITFIELD_FIELD(unsigned int opcode : 6,
> +	BITFIELD_FIELD(unsigned int rs : 5,
> +	BITFIELD_FIELD(unsigned int rt : 5,
> +	BITFIELD_FIELD(signed int simmediate : 16,
> +	))))
> +};
> +
> +struct u_format {			/* unsigned immediate format */
> +	BITFIELD_FIELD(unsigned int opcode : 6,
> +	BITFIELD_FIELD(unsigned int rs : 5,
> +	BITFIELD_FIELD(unsigned int rt : 5,
> +	BITFIELD_FIELD(unsigned int uimmediate : 16,
> +	))))
> +};
> +
> +struct c_format {			/* Cache (>= R6000) format */
> +	BITFIELD_FIELD(unsigned int opcode : 6,
> +	BITFIELD_FIELD(unsigned int rs : 5,
> +	BITFIELD_FIELD(unsigned int c_op : 3,
> +	BITFIELD_FIELD(unsigned int cache : 2,
> +	BITFIELD_FIELD(unsigned int simmediate : 16,
> +	)))))
> +};
> +
> +struct r_format {			/* Register format */
> +	BITFIELD_FIELD(unsigned int opcode : 6,
> +	BITFIELD_FIELD(unsigned int rs : 5,
> +	BITFIELD_FIELD(unsigned int rt : 5,
> +	BITFIELD_FIELD(unsigned int rd : 5,
> +	BITFIELD_FIELD(unsigned int re : 5,
> +	BITFIELD_FIELD(unsigned int func : 6,
> +	))))))
> +};
> +
> +struct p_format {		/* Performance counter format (R10000) */
> +	BITFIELD_FIELD(unsigned int opcode : 6,
> +	BITFIELD_FIELD(unsigned int rs : 5,
> +	BITFIELD_FIELD(unsigned int rt : 5,
> +	BITFIELD_FIELD(unsigned int rd : 5,
> +	BITFIELD_FIELD(unsigned int re : 5,
> +	BITFIELD_FIELD(unsigned int func : 6,
> +	))))))
> +};BITFIELD_FIELD(
> +
> +struct f_format { 			/* FPU register format */
> +	BITFIELD_FIELD(unsigned int opcode : 6,
> +	BITFIELD_FIELD(unsigned int : 1,
> +	BITFIELD_FIELD(unsigned int fmt : 4,
> +	BITFIELD_FIELD(unsigned int rt : 5,
> +	BITFIELD_FIELD(unsigned int rd : 5,
> +	BITFIELD_FIELD(unsigned int re : 5,
> +	BITFIELD_FIELD(unsigned int func : 6,
> +	)))))))
> +};
> +
> +struct ma_format {		/* FPU multiply and add format (MIPS IV) */
> +	BITFIELD_FIELD(unsigned int opcode : 6,
> +	BITFIELD_FIELD(unsigned int fr : 5,
> +	BITFIELD_FIELD(unsigned int ft : 5,
> +	BITFIELD_FIELD(unsigned int fs : 5,
> +	BITFIELD_FIELD(unsigned int fd : 5,
> +	BITFIELD_FIELD(unsigned int func : 4,
> +	BITFIELD_FIELD(unsigned int fmt : 2,
> +	)))))))
> +};
> +
> +struct b_format {			/* BREAK and SYSCALL */
> +	BITFIELD_FIELD(unsigned int opcode : 6,
> +	BITFIELD_FIELD(unsigned int code : 20,
> +	BITFIELD_FIELD(unsigned int func : 6,
> +	)))
> +};
> +
>   union mips_instruction {
>   	unsigned int word;
>   	unsigned short halfword[2];
> @@ -353,6 +299,7 @@ union mips_instruction {
>   	struct u_format u_format;
>   	struct c_format c_format;
>   	struct r_format r_format;
> +	struct p_format p_format;
>   	struct f_format f_format;
>   	struct ma_format ma_format;
>   	struct b_format b_format;
>
>
