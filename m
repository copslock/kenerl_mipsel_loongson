Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 12:29:23 +0100 (CET)
Received: from mail-lb0-f170.google.com ([209.85.217.170]:65087 "EHLO
        mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010623AbbAPL3VUWqNq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 12:29:21 +0100
Received: by mail-lb0-f170.google.com with SMTP id 10so17983615lbg.1
        for <linux-mips@linux-mips.org>; Fri, 16 Jan 2015 03:29:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=p6LjVqJVQ+A4rFZ1RNN7TSEOtwb4Ps/BN+2fuSpU/e8=;
        b=DT0uopQRaf0Vs5kndW/wK3l1+dt1vOghmiV+RtOZbFUx7p6tcdxdBHa0litUjU3Opp
         LQ/BZ/AP2FcXJsRYQyXaNrqZdBdSP2rGCOJVVePboLXDRDFhv/buSr5F18Xe3Xh54bhL
         BcIGmH39rRRecdgDojYFXTTqM8Bo+2IPqiyF5CNGl54mtJiqD324X8h9sYNXw+0fTSij
         xYPITg/awkRBtHM0C2e6Ebde73YbWmVpPrpMFyubf93vfhkng9KPGk5gXLIXsldtlzOa
         c78/h2VYBCW2VqqeSjx6jvE9qBgys4BdBMRBL7BEHy9Z9fl3m0hRFZ8An3AOCH3NILhe
         8pkg==
X-Gm-Message-State: ALoCoQn2KtdlZf8Pwa33v0yntt582UlOD6HnpkKFKcMpbc3qOsrnYBRahp3FJhrILBSxF0T1mKlg
X-Received: by 10.152.3.100 with SMTP id b4mr14542507lab.68.1421407755619;
        Fri, 16 Jan 2015 03:29:15 -0800 (PST)
Received: from [192.168.3.68] (ppp17-235.pppoe.mtu-net.ru. [81.195.17.235])
        by mx.google.com with ESMTPSA id lh6sm1382170lab.49.2015.01.16.03.29.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jan 2015 03:29:14 -0800 (PST)
Message-ID: <54B8F609.90509@cogentembedded.com>
Date:   Fri, 16 Jan 2015 14:29:13 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [PATCH RFC v2 05/70] MIPS: mm: uasm: Add signed 9-bit immediate
 related macros
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-6-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1421405389-15512-6-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45216
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

On 1/16/2015 1:48 PM, Markos Chandras wrote:

> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

> MIPS R6 redefines several instructions and reduces the immediate
> field to 9-bits so add related macros for the microassembler.

> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>   arch/mips/mm/uasm.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)

> diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
> index 4adf30284813..6596b6898637 100644
> --- a/arch/mips/mm/uasm.c
> +++ b/arch/mips/mm/uasm.c
[...]
> @@ -41,6 +42,8 @@ enum fields {
>   #define FUNC_SH		0
>   #define SET_MASK	0x7
>   #define SET_SH		0
> +#define SIMM9_SH	7
> +#define SIMM9_MASK	0x1ff
>
>   enum opcode {
>   	insn_invalid,
> @@ -116,6 +119,14 @@ static inline u32 build_scimm(u32 arg)
>   	return (arg & SCIMM_MASK) << SCIMM_SH;
>   }
>
> +static inline u32 build_scimm9(s32 arg)
> +{
> +	WARN((arg > 0x1ff || arg < -0x200),

    Not 0xFF and -0x100? The values above don't fit into 9 bits...

> +	       KERN_WARNING "Micro-assembler field overflow\n");
> +
> +	return (arg & SIMM9_MASK) << SIMM9_SH;
> +}
> +
[...]

WBR, Sergei
