Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Jan 2015 14:24:22 +0100 (CET)
Received: from mail-la0-f50.google.com ([209.85.215.50]:52514 "EHLO
        mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009651AbbAQNYUSsv2N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Jan 2015 14:24:20 +0100
Received: by mail-la0-f50.google.com with SMTP id pn19so22833112lab.9
        for <linux-mips@linux-mips.org>; Sat, 17 Jan 2015 05:24:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=/N8Nd6eV4zOnMKkgHE9b5TJAWuwMRe4VoXbHpu9S5Y0=;
        b=IIm1tweYoHqyl1WtTMIusvyEf5wEswGHgOqW9u4VK/977Tl166LMYa7C//onIZ4B6S
         i0qXNb4rL1Gfd+bbrTHSVYFM35NJ6m9+NfnKkxlUv1WRYMDg4yagxwuUsJMpW3WpUmpK
         B0jv7rdQGKfb4tqi+oYkKD7D4ajBGdRWUuwco9iaSueSLdPLv2RvjiHiWd7YUVa4tjAu
         CBv6lYli3Pu82SWL98cb02Py2BtrAj1dyEle9eSFq1jsqIPpekUPB9EmaPIS18Ac732J
         6Xk+NewywsGoQ5x05fYLP2njueW8kvSUAIuA07gwsEM1+W/G8Aex+fHefZIbAfOzl1x0
         tSfQ==
X-Gm-Message-State: ALoCoQliQzgusa03xerTXzg/R43PqdfcMVEI3xzx+99+LsMIDEcTtJyMLoSc5cBAGsI3ydSW1uCt
X-Received: by 10.152.27.130 with SMTP id t2mr20289995lag.28.1421501054367;
        Sat, 17 Jan 2015 05:24:14 -0800 (PST)
Received: from [192.168.3.68] (ppp30-219.pppoe.mtu-net.ru. [81.195.30.219])
        by mx.google.com with ESMTPSA id q9sm1546839lbo.29.2015.01.17.05.24.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Jan 2015 05:24:13 -0800 (PST)
Message-ID: <54BA627C.7070105@cogentembedded.com>
Date:   Sat, 17 Jan 2015 16:24:12 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH RFC v2 57/70] MIPS: Emulate the new MIPS R6 BOVC, BEQC
 and BEQZALC instructions
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-58-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1421405389-15512-58-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45242
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

On 1/16/2015 1:49 PM, Markos Chandras wrote:

> MIPS R6 uses the <R6 ADDI opcode for the new BOVC, BEQC and
> BEQZALC instructions.

> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>

[...]

> diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
> index bf82ec302cff..c084b38e727b 100644
> --- a/arch/mips/kernel/branch.c
> +++ b/arch/mips/kernel/branch.c
> @@ -808,6 +808,17 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
>   		}
>   		regs->cp0_epc += 8;
>   		break;
> +	case cbcond0_op:
> +		/* Only valid for MIPS R6 */
> +		if (!cpu_has_mips_r6) {
> +			ret = -SIGILL;
> +			break;
> +		}
> +		/* Compact branches: bovc, beqc, beqzalc */
> +		if (insn.i_format.rt && !insn.i_format.rs)
> +			regs->regs[31] = epc + 4;

    Hm, so this instruction doesn't have delay slot?

> +		regs->cp0_epc += 8;

    Then why 8 here?

WBR, Sergei
