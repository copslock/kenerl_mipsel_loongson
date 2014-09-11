Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2014 12:03:51 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60681 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008712AbaIKKDtHIzlt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Sep 2014 12:03:49 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 5B42455494F5C;
        Thu, 11 Sep 2014 11:03:40 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 11 Sep 2014 11:03:41 +0100
Received: from [192.168.154.67] (192.168.154.67) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 11 Sep
 2014 11:03:41 +0100
Message-ID: <5411737D.4070801@imgtec.com>
Date:   Thu, 11 Sep 2014 11:03:41 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
MIME-Version: 1.0
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        <linux-mips@linux-mips.org>, <nbd@openwrt.org>,
        <james.hogan@imgtec.com>, <jchandra@broadcom.com>,
        <paul.burton@imgtec.com>, <david.daney@cavium.com>,
        <linux-kernel@vger.kernel.org>, <ralf@linux-mips.org>,
        <macro@linux-mips.org>, <manuel.lauss@gmail.com>,
        <jerinjacobk@gmail.com>, <chenhc@lemote.com>, <blogic@openwrt.org>
Subject: Re: [PATCH V2] MIPS: bugfix of coherentio variable default setup
References: <20140908191002.13852.47842.stgit@linux-yegoshin>
In-Reply-To: <20140908191002.13852.47842.stgit@linux-yegoshin>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.67]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42514
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

Hi Leonid,

On 09/08/2014 08:10 PM, Leonid Yegoshin wrote:
> Patch commit b6d92b4a6bdb880b39789c677b952c53a437028d
> 
>     MIPS: Add option to disable software I/O coherency.
> 
>     Some MIPS controllers have hardware I/O coherency. This patch
>     detects those and turns off software coherency. A new kernel
>     command line option also allows the user to manually turn
>     software coherency on or off.
> 
> in fact enforces L2 cache flushes even on systems with IOCU.
> The default value of coherentio is 0 and is not changed even with IOCU.
> It is a serious performance problem because it destroys all IOCU performance
> advantages.
> 
> It is fixed by setting coherentio to tri-state with default value as (-1) and
> setup a final value during platform coherency setup.
> 
> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> [...]
> diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
> index db7c9e5..48039fd 100644
> --- a/arch/mips/mti-malta/malta-setup.c
> +++ b/arch/mips/mti-malta/malta-setup.c
> @@ -147,13 +147,17 @@ static void __init plat_setup_iocoherency(void)
>  	if (plat_enable_iocoherency()) {
>  		if (coherentio == 0)
>  			pr_info("Hardware DMA cache coherency disabled\n");
> -		else
> +		else {
> +			coherentio = 1;
>  			pr_info("Hardware DMA cache coherency enabled\n");
> +		}
>  	} else {
>  		if (coherentio == 1)
>  			pr_info("Hardware DMA cache coherency unsupported, but enabled from command line!\n");
> -		else
> +		else {
> +			coherentio = 0;
>  			pr_info("Software DMA cache coherency enabled\n");
> +		}

This is not acceptable coding style for the kernel. See
Documentation/CodingStyle, Chapter 3. Since you are adding braces in the
"else" case, you should also add them in the "if" case as well.

-- 
markos
