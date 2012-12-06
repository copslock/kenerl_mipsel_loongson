Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Dec 2012 20:17:11 +0100 (CET)
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:30852 "EHLO
        tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6831898Ab2LFTRJzkZ31 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Dec 2012 20:17:09 +0100
Received: from mail175-tx2-R.bigfish.com (10.9.14.244) by
 TX2EHSOBE012.bigfish.com (10.9.40.32) with Microsoft SMTP Server id
 14.1.225.23; Thu, 6 Dec 2012 19:17:06 +0000
Received: from mail175-tx2 (localhost [127.0.0.1])      by
 mail175-tx2-R.bigfish.com (Postfix) with ESMTP id 0B60532019C; Thu,  6 Dec
 2012 19:17:06 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:157.56.236.213;KIP:(null);UIP:(null);IPV:NLI;H:BY2PRD0711HT002.namprd07.prod.outlook.com;RD:none;EFVD:NLI
X-SpamScore: -4
X-BigFish: PS-4(zzbb2dI98dI9371I1432Izz1de0h1202h1d1ah1d2ahzz8275bh8275dhz2dh2a8h668h839h947hd25he5bhf0ah1288h12a5h12a9h12bdh137ah13b6h1441h14ddh1504h1537h153bh162dh1631h1155h)
Received: from mail175-tx2 (localhost.localdomain [127.0.0.1]) by mail175-tx2
 (MessageSwitch) id 1354821424347728_19019; Thu,  6 Dec 2012 19:17:04 +0000
 (UTC)
Received: from TX2EHSMHS038.bigfish.com (unknown [10.9.14.241]) by
 mail175-tx2.bigfish.com (Postfix) with ESMTP id 4917030019D;   Thu,  6 Dec 2012
 19:17:04 +0000 (UTC)
Received: from BY2PRD0711HT002.namprd07.prod.outlook.com (157.56.236.213) by
 TX2EHSMHS038.bigfish.com (10.9.99.138) with Microsoft SMTP Server (TLS) id
 14.1.225.23; Thu, 6 Dec 2012 19:17:03 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.88.165) with Microsoft SMTP Server (TLS) id 14.16.245.2; Thu, 6 Dec
 2012 19:17:01 +0000
Message-ID: <50C0EF2C.3080705@caviumnetworks.com>
Date:   Thu, 6 Dec 2012 11:17:00 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     David Daney <david.daney@cavium.com>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Check BITS_PER_LONG instead of __SIZEOF_LONG__
References: <1354821137-7562-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1354821137-7562-1-git-send-email-geert@linux-m68k.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-OriginatorOrg: caviumnetworks.com
X-archive-position: 35199
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
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

On 12/06/2012 11:12 AM, Geert Uytterhoeven wrote:
> When building a 32-bit kernel for RBTX4927 with gcc version 4.1.2 20061115
> (prerelease) (Ubuntu 4.1.1-21), I get:
>
> arch/mips/lib/delay.c:24:5: warning: "__SIZEOF_LONG__" is not defined
>
> As a consequence, __delay() always uses the 64-bit "dsubu" instruction.
>
> Replace the check for "__SIZEOF_LONG__ == 4" by "BITS_PER_LONG == 32" to
> fix this.
>
> Introduced by commit 5210edcd527773c227465ad18e416a894966324f ("MIPS: Make
> __{,n,u}delay declarations match definitions and generic delay.h")
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: David Daney <david.daney@cavium.com>

> --
> Untested on real hardware.
> Ralf, is this sufficient to prevent you from nuking RBTX4927 support? ;-)
> ---
>   arch/mips/lib/delay.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/mips/lib/delay.c b/arch/mips/lib/delay.c
> index dc81ca8..288f795 100644
> --- a/arch/mips/lib/delay.c
> +++ b/arch/mips/lib/delay.c
> @@ -21,7 +21,7 @@ void __delay(unsigned long loops)
>   	"	.set	noreorder				\n"
>   	"	.align	3					\n"
>   	"1:	bnez	%0, 1b					\n"
> -#if __SIZEOF_LONG__ == 4
> +#if BITS_PER_LONG == 32
>   	"	subu	%0, 1					\n"
>   #else
>   	"	dsubu	%0, 1					\n"
>
