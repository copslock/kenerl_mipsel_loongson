Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Dec 2014 13:02:59 +0100 (CET)
Received: from mail-la0-f50.google.com ([209.85.215.50]:32852 "EHLO
        mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008738AbaLSMC5dIRhS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Dec 2014 13:02:57 +0100
Received: by mail-la0-f50.google.com with SMTP id pn19so700473lab.37
        for <linux-mips@linux-mips.org>; Fri, 19 Dec 2014 04:02:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=O7g+HsPkv4YUZpj1UQrHWsriMskNQ7BznJAziVULK4s=;
        b=B0zjisBpKbE3PGJ420IelR17bx6FHDB4u3Z5iNMp6ealw/ZC2E5V4sQZy20pErStxK
         YCZd809YILaSo/0+b5Pweom2lM5cVISM0y3Cb4aDAHMYFwz3B1rfzSZbI9RwK5PpJ+Xj
         JkCDz7aWvzRc1bsMJZLMw9MExdOD++BZ2Umw0nNGPUGerqtG6Gkmsz5k+GPxbY6MtNSH
         RhtOzkvqjfspJE8WZLanrPXeC7Gbd82ZjBiUOmomqTWaa++Q2MyUl9kj3uGTLH48l3JG
         vp+po3el7t1TL1IXMVNCQNbKKiY/6aOXXqRvMHPjq4uMQb4VOfLjSiwlBfy6mWO8bnj9
         WYhg==
X-Gm-Message-State: ALoCoQk6lPnKQpe3NkNJEmZ8kfZ1KFkbTpLsq6teGqqenSlNd8JE9AAZAOU39TYt40G6hA4eO1Kd
X-Received: by 10.112.47.135 with SMTP id d7mr868179lbn.54.1418990572115;
        Fri, 19 Dec 2014 04:02:52 -0800 (PST)
Received: from [192.168.3.154] (ppp83-237-251-130.pppoe.mtu-net.ru. [83.237.251.130])
        by mx.google.com with ESMTPSA id vu9sm2658439lbb.36.2014.12.19.04.02.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Dec 2014 04:02:51 -0800 (PST)
Message-ID: <549413EB.60303@cogentembedded.com>
Date:   Fri, 19 Dec 2014 15:02:51 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH RFC 54/67] MIPS: kernel: branch: Add new MIPS R6 B{L,G}TZ{AL,}C
 emulation
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com> <1418915416-3196-55-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1418915416-3196-55-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44838
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

On 12/18/2014 6:10 PM, Markos Chandras wrote:

> MIPS R6 added the following four instructions which share the
> BGTZ and BGTZL opcode:

> BLTZALC: Compact branch-and-link if GPR rt is < to zero
> BGEZALC: Compact branch-and-link if GPR rt is > to zero

    Not BGTZALC?

> BGTZL: Compact branch if GPR rt is < to zero

    Not BLTZC?

> BGEZL: Compact branch if GPR rt is > to zero

    Not BGTZC?

> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>   arch/mips/kernel/branch.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)

> diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
> index 7bc2df026b51..ca102557fa3c 100644
> --- a/arch/mips/kernel/branch.c
> +++ b/arch/mips/kernel/branch.c
> @@ -648,6 +648,19 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
>   			ret = -SIGILL;
>   			break;
>   		}
> +		/* bgtzalc, bltzalc, bgtzc, bltzc */
> +		if (cpu_has_mips_r6) {
> +			if (insn.i_format.rt) {
> +				if (insn.i_format.opcode == blez_op)
> +					if (insn.i_format.rs ==
> +					    insn.i_format.rt ||
> +					    !insn.i_format.rs)
> +						regs->regs[31] = epc + 4;
> +				regs->cp0_epc += 8;
> +				break;

   Why not collapse the *if* statements here as well?

> +			}
> +		}
> +
[...]

WBR, Sergei
