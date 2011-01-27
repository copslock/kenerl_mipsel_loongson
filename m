Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jan 2011 18:50:50 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:18829 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491014Ab1A0Rur (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Jan 2011 18:50:47 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d41b0a70000>; Thu, 27 Jan 2011 09:51:35 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 27 Jan 2011 09:50:45 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 27 Jan 2011 09:50:45 -0800
Message-ID: <4D41B06F.8070804@caviumnetworks.com>
Date:   Thu, 27 Jan 2011 09:50:39 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Coly Li <bosong.ly@taobao.com>
CC:     linux-kernel@vger.kernel.org, Wang Cong <xiyou.wangcong@gmail.com>,
        Yong Zhang <yong.zhang0@gmail.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 1/7] MIPS: add unlikely() to BUG_ON()
References: <1296130356-29896-1-git-send-email-bosong.ly@taobao.com> <1296130356-29896-2-git-send-email-bosong.ly@taobao.com>
In-Reply-To: <1296130356-29896-2-git-send-email-bosong.ly@taobao.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Jan 2011 17:50:45.0114 (UTC) FILETIME=[B904ADA0:01CBBE4A]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29100
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Please Cc: linux-mips@linux-mips.org for MIPS patches.

On 01/27/2011 04:12 AM, Coly Li wrote:
> Current BUG_ON() in arch/mips/include/asm/bug.h does not use unlikely(),
> in order to get better branch predict result, source code should call
> BUG_ON() with unlikely() explicitly. This is not a suggested method to
> use BUG_ON().
>
> This patch adds unlikely() inside BUG_ON implementation on MIPS code,
> callers can use BUG_ON without explicit unlikely() now.
>
> I have no usable MIPS hardware to build and test the fix, any test result
> of this patch is welcome.
>
> Signed-off-by: Coly Li<bosong.ly@taobao.com>
> Cc: David Daney<ddaney@caviumnetworks.com>
> Cc: Wang Cong<xiyou.wangcong@gmail.com>
> Cc: Yong Zhang<yong.zhang0@gmail.com>
> ---
>   arch/mips/include/asm/bug.h |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/mips/include/asm/bug.h b/arch/mips/include/asm/bug.h
> index 540c98a..6771c07 100644
> --- a/arch/mips/include/asm/bug.h
> +++ b/arch/mips/include/asm/bug.h
> @@ -30,7 +30,7 @@ static inline void  __BUG_ON(unsigned long condition)
>   			     : : "r" (condition), "i" (BRK_BUG));
>   }
>
> -#define BUG_ON(C) __BUG_ON((unsigned long)(C))
> +#define BUG_ON(C) __BUG_ON((unsigned long)unlikely(C))
>

NAK.

__BUG_ON() expands to a single instruction.  Frobbing about with 
unlikely() will have no effect on the generated code and is thus 
gratuitous code churn.

David Daney
