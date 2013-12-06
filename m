Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Dec 2013 17:32:19 +0100 (CET)
Received: from mail-ie0-f180.google.com ([209.85.223.180]:33479 "EHLO
        mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6820116Ab3LFQcQDvhj5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Dec 2013 17:32:16 +0100
Received: by mail-ie0-f180.google.com with SMTP id tp5so1630494ieb.11
        for <linux-mips@linux-mips.org>; Fri, 06 Dec 2013 08:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=nptTMQ47E32W3kzuKUvACLjpIaJkmBJfmZuW5GqoiCI=;
        b=aSxokZK/81mScRL1NsGIpIg/gjbTWkgvR1YWsVmWE3Vtjw2Ev6a+ekx5HZxHipO88Q
         8z4UXQADCkinPwzF80zlDoTdXXdtDTzesKix07+49WgNFSRB4byDkNnpuhQIREpOlNKp
         lj8foEWBf0NhONAV7skbt3s4udEwKcLBS+PPoMCjpMmUgNp37iuPtiRRszURO9d4RTdZ
         O16NYdKu3jJxWWqPptZX/1P6Khbd3J0gNsWdM1H623sJlNdRnq4avfPp7rH8DvnbFht1
         rum7Sj19zUON5icxxZAvyXczGsoNaHum/mwbw6u/kPqPTa7uC+5hKwdX5ZBbRnPIHy9h
         JUnA==
X-Received: by 10.50.128.72 with SMTP id nm8mr3626670igb.10.1386347529548;
        Fri, 06 Dec 2013 08:32:09 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id v2sm4330275igz.3.2013.12.06.08.32.08
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 06 Dec 2013 08:32:08 -0800 (PST)
Message-ID: <52A1FC07.8030902@gmail.com>
Date:   Fri, 06 Dec 2013 08:32:07 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Qais Yousef <qais.yousef@imgtec.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] mips/include/asm/mipsregs.h: s/u16/unsigned short/
References: <1386321659-30073-1-git-send-email-qais.yousef@imgtec.com>
In-Reply-To: <1386321659-30073-1-git-send-email-qais.yousef@imgtec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38674
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

On 12/06/2013 01:20 AM, Qais Yousef wrote:
> I was getting this error when including this header in my driver:
>
>    arch/mips/include/asm/mipsregs.h:644:33: error: unknown type name ‘u16’
>
> since the use of u16 is not really necessary, convert it to unsigned short.
>
> Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
> Reviewed-by: Steven J. Hill <Steven.Hill@imgtec.com>

NAK.

Just #include <linux/types.h> at the top of asm/mipsregs.h instead.

David Daney


> ---
>   arch/mips/include/asm/mipsregs.h |    4 ++--
>   1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
> index e033141..0a2d6ef 100644
> --- a/arch/mips/include/asm/mipsregs.h
> +++ b/arch/mips/include/asm/mipsregs.h
> @@ -641,9 +641,9 @@
>    * microMIPS instructions can be 16-bit or 32-bit in length. This
>    * returns a 1 if the instruction is 16-bit and a 0 if 32-bit.
>    */
> -static inline int mm_insn_16bit(u16 insn)
> +static inline int mm_insn_16bit(unsigned short insn)
>   {
> -	u16 opcode = (insn >> 10) & 0x7;
> +	unsigned short opcode = (insn >> 10) & 0x7;
>
>   	return (opcode >= 1 && opcode <= 3) ? 1 : 0;
>   }
>
