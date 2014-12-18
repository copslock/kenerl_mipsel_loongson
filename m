Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 20:11:03 +0100 (CET)
Received: from mail-ie0-f174.google.com ([209.85.223.174]:46477 "EHLO
        mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008789AbaLRTLCPC-De (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 20:11:02 +0100
Received: by mail-ie0-f174.google.com with SMTP id rl12so1676319iec.5
        for <linux-mips@linux-mips.org>; Thu, 18 Dec 2014 11:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=yV1ukgtofLOvKsOfcgqezlypRAEwWseLm5pRQbGqQ7o=;
        b=u4wGTUdr9EKvx9jOH+IOfxzvX+SnR5lVczjbkLCxctA12hsSRaTZ6DEItHwhn/tKzI
         83ApFmi0G76yLRCfZSyDrziOg1d8n/jyJw5fThY4riqcXmE0jDhFzOKihgsuOcuduRFG
         6EwEhCJ5HJvG7b+cY67jxP7j/R24/IxPdMtXTCrur6shuQbjtOpTuhCCxKvaLoBSYl/a
         6jj5sm5SSCPlsY4fsV7Lv+TLvZAhJT6Af8XnB1x+dxfQJMP+on4mwHU80PeALMTAFoA9
         STMNHbOyUy+SjZYwq09jojPFbvZpAnQmkIut1Jjx6IAHyNQq40UR+AXKYVHKSuuAbq72
         4eUQ==
X-Received: by 10.42.130.194 with SMTP id w2mr3435805ics.12.1418929856457;
        Thu, 18 Dec 2014 11:10:56 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id p137sm3520862ioe.29.2014.12.18.11.10.55
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 18 Dec 2014 11:10:56 -0800 (PST)
Message-ID: <549326BF.7050605@gmail.com>
Date:   Thu, 18 Dec 2014 11:10:55 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>
CC:     linux-mips@linux-mips.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [PATCH RFC 01/67] MIPS: Add generic QEMU R6 PRid and cpu type
 identifiers
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com> <1418915416-3196-2-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1418915416-3196-2-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44815
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

On 12/18/2014 07:09 AM, Markos Chandras wrote:
> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>
> Latest versions of QEMU added support for mips32r6-generic and
> mips64r6-generic cpu types so add related definitions in preparation
> of MIPS R6 support.
>
> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>   arch/mips/include/asm/cpu.h | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
> index dfdc77ed1839..23a5dbc0ee06 100644
> --- a/arch/mips/include/asm/cpu.h
> +++ b/arch/mips/include/asm/cpu.h
> @@ -93,6 +93,7 @@
>    * These are the PRID's for when 23:16 == PRID_COMP_MIPS
>    */
>
> +#define PRID_IMP_QEMUR6		0x0000

Why not have a value for a real R6 CPU, and then have QEMU emulate that?


>   #define PRID_IMP_4KC		0x8000
>   #define PRID_IMP_5KC		0x8100
>   #define PRID_IMP_20KC		0x8200
> @@ -311,6 +312,8 @@ enum cpu_type_enum {
>   	CPU_LOONGSON3, CPU_CAVIUM_OCTEON, CPU_CAVIUM_OCTEON_PLUS,
>   	CPU_CAVIUM_OCTEON2, CPU_CAVIUM_OCTEON3, CPU_XLR, CPU_XLP,
>
> +	CPU_QEMUR6,
> +
>   	CPU_LAST
>   };
>
>
