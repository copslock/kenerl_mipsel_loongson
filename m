Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Dec 2013 19:48:55 +0100 (CET)
Received: from mail-ie0-f176.google.com ([209.85.223.176]:49738 "EHLO
        mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827312Ab3LISsxfFSq8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Dec 2013 19:48:53 +0100
Received: by mail-ie0-f176.google.com with SMTP id at1so6768731iec.21
        for <linux-mips@linux-mips.org>; Mon, 09 Dec 2013 10:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=3eN/YZxGeaeMmxxXPNGJ5zmN+I7TIZ+41m0Vkvgx3SM=;
        b=LNzlIdMQtjk58M+wrmLn+PISYRJEAiG0lovWETec86YrszMc7XLknvE87T+f0Pzs4I
         u6g9tr6Xu86O+Jv6HHZh2OTorfv96JGnhNA1UeZs4lKoDp0JJ93H7iyHUfdaCfJbEfOe
         EE+pZcTJAk/q56LljS+M6GSb14c9q1BVFs6smepZTFUY+AxU2LI4tiEVf/qIgtXyQrcQ
         4nmki9fk6kY7i4utxovNGHLiHEYv1LOYMk2hAJ5WQTsik5ogdhuxngmdDwXUiPXWMIfg
         /A034v51McHo2qajSDb9gs5kMVmoLUv8fy/96o7BFXeoY8OOO36EuFrTfve22e3layDe
         LiZQ==
X-Received: by 10.42.142.129 with SMTP id s1mr14132412icu.30.1386614927778;
        Mon, 09 Dec 2013 10:48:47 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id f5sm15872824igc.4.2013.12.09.10.48.46
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 09 Dec 2013 10:48:47 -0800 (PST)
Message-ID: <52A6108D.4010701@gmail.com>
Date:   Mon, 09 Dec 2013 10:48:45 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Qais Yousef <qais.yousef@imgtec.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2] mips/include/asm/mipsregs.h: include linux/types.h
References: <1386582585-20867-1-git-send-email-qais.yousef@imgtec.com>
In-Reply-To: <1386582585-20867-1-git-send-email-qais.yousef@imgtec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38688
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

On 12/09/2013 01:49 AM, Qais Yousef wrote:
> The file uses u16 type but doesn't include its definition explicitly
>
> I was getting this error when including this header in my driver:
>
>    arch/mips/include/asm/mipsregs.h:644:33: error: unknown type name ‘u16’
>
> Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
> Reviewed-by: Steven J. Hill <Steven.Hill@imgtec.com>

Acked-by: David Daney <david.daney@cavium.com>

> ---
> changes since v1:
> 	- include linux/types.h instead of s/u16/unsigned short/
> 	- amend commit message accordingly
>
>   arch/mips/include/asm/mipsregs.h |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
> index e033141..86479bb 100644
> --- a/arch/mips/include/asm/mipsregs.h
> +++ b/arch/mips/include/asm/mipsregs.h
> @@ -14,6 +14,7 @@
>   #define _ASM_MIPSREGS_H
>
>   #include <linux/linkage.h>
> +#include <linux/types.h>
>   #include <asm/hazards.h>
>   #include <asm/war.h>
>
>
