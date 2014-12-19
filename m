Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Dec 2014 12:59:55 +0100 (CET)
Received: from mail-la0-f51.google.com ([209.85.215.51]:46859 "EHLO
        mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009159AbaLSL7w7Y0eX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Dec 2014 12:59:52 +0100
Received: by mail-la0-f51.google.com with SMTP id ms9so690658lab.24
        for <linux-mips@linux-mips.org>; Fri, 19 Dec 2014 03:59:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=KhyPvqhC3bUZk49P5snAKmLVbypem8pbzVvRS9Orm9g=;
        b=dG3d8pH4MxS1XmjS4199wlWNg1nQMhxytWgmuvXURBwb28Rw/aw4ejxK+odYRuFsfG
         AxXKFEikLOSzMBoNtoYQ/jvakYM1A736XG2QkwO1DxhWTWAIviOX/lIlVvhSNqkxQ72x
         MapUINUc79iKuKEkbYslDFW7dTxuqAFxui0xBn5PXhP7c2ozaj5tYAa2vJKqr3Mpjz9d
         6aP0i4bHkjp6PArk4856bZs8x4giUB5lciBDAvnFpxhKIHLIUD57FpycikX1hdc0aeaH
         HcTufV9hIsFmRC77XLCx90lyv/SMqRdmpLYVOP0Egu4G7UF00u3tQxXsMAq9Ubd3WY7X
         gM+g==
X-Gm-Message-State: ALoCoQkXz23D+RdurOBH3cpnQAhVZHe8FU4QVqr/y2Ry/OF8QEqdad3rl+QcHPdlaCh0KqPn7/Fz
X-Received: by 10.152.3.9 with SMTP id 9mr2926909lay.54.1418990387451;
        Fri, 19 Dec 2014 03:59:47 -0800 (PST)
Received: from [192.168.3.154] (ppp83-237-251-130.pppoe.mtu-net.ru. [83.237.251.130])
        by mx.google.com with ESMTPSA id wq1sm2656570lbb.24.2014.12.19.03.59.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Dec 2014 03:59:46 -0800 (PST)
Message-ID: <54941332.8070908@cogentembedded.com>
Date:   Fri, 19 Dec 2014 14:59:46 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBSRkMgNTMvNjddIE1JUFM6IGtlcm5lbDogYnJhbmM=?=
 =?UTF-8?B?aDogQWRkIG5ldyBNSVBTIFI2IEJ7TCxHfc6VWntBTCx9QyBlbXVsYXRpb24=?=
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com> <1418915416-3196-54-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1418915416-3196-54-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44837
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 12/18/2014 6:10 PM, Markos Chandras wrote:

> MIPS R6 added the following four instructions which share the
> BLEZ and BLEZL opcodes:

> BLEZALC: Compact branch-and-link if GPR rt is <= to zero
> BGEZALC: Compact branch-and-link if GPR rt is >= to zero
> BLEZC: Compact branch if GPR rt is < to zero

    Not <=?

> BGEZC: Compact branch if GPR rt is > to zero

    Not >=?

> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>   arch/mips/kernel/branch.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)

> diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
> index e6d78ab52aa7..7bc2df026b51 100644
> --- a/arch/mips/kernel/branch.c
> +++ b/arch/mips/kernel/branch.c
> @@ -402,6 +402,16 @@ int __MIPS16e_compute_return_epc(struct pt_regs *regs)
>    * @returns:	-EFAULT on error and forces SIGBUS, and on success
>    *		returns 0 or BRANCH_LIKELY_TAKEN as appropriate after
>    *		evaluating the branch.
> + *
> + * MIPS R6 Compact branches and forbidden slots:
> + *	Compact branches do not throw exceptions because they do
> + *	not have delay slots. The forbidden slot instruction ($PC+4)
> + *	is only executed if the branch was not taken. Otherwise the
> + *	forbidden slot is skipped entirely. This means that they

    s/they/the/?

[...]
> @@ -609,6 +619,18 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
>   			ret = -SIGILL;
>   			break;
>   		}
> +		/* blezalc, bgezalc, blezc, bgezc */
> +		if (cpu_has_mips_r6) {
> +			if (insn.i_format.rt) {

     Perhaps those *if* statements can be collapsed to save on indentation?

> +				if (insn.i_format.opcode == blez_op)
> +					if ((insn.i_format.rs ==
> +					     insn.i_format.rt) ||
> +					    !insn.i_format.rs)
> +						regs->regs[31] = epc + 4;

    And these also?

> +				regs->cp0_epc += 8;
> +				break;
> +			}
> +		}
[...]

WBR, Sergei
