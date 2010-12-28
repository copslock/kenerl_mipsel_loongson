Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Dec 2010 16:45:51 +0100 (CET)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:39578 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491020Ab0L1Pps (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Dec 2010 16:45:48 +0100
Received: by ewy20 with SMTP id 20so4226417ewy.36
        for <multiple recipients>; Tue, 28 Dec 2010 07:45:46 -0800 (PST)
Received: by 10.213.12.197 with SMTP id y5mr6744514eby.14.1293551145745;
        Tue, 28 Dec 2010 07:45:45 -0800 (PST)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru [213.79.90.226])
        by mx.google.com with ESMTPS id x54sm9798753eeh.23.2010.12.28.07.45.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 07:45:44 -0800 (PST)
Message-ID: <4D1A05D9.9050707@mvista.com>
Date:   Tue, 28 Dec 2010 18:44:25 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     David Daney <ddaney@caviumnetworks.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] MIPS: Use WARN() in uasm for better diagnostics.
References: <1293502709-11454-1-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <1293502709-11454-1-git-send-email-ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28735
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

David Daney wrote:

> On the off chance that uasm ever warns about overflow, there is no way
> to know what the offending instruction is.

> Change the printks to WARNs, so we can get a nice stack trace.  It has
> the added benefit of being much more noticeable than the short single
> line warning message, so is less likely to be ignored.

> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
>  arch/mips/mm/uasm.c |   40 ++++++++++++++++------------------------
>  1 files changed, 16 insertions(+), 24 deletions(-)

> diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
> index 357916d..4008c79 100644
> --- a/arch/mips/mm/uasm.c
> +++ b/arch/mips/mm/uasm.c
> @@ -156,91 +156,83 @@ static struct insn insn_table[] __uasminitdata = {
[...]
>  static inline __uasminit u32 build_jimm(u32 arg)
>  {
> -	if (arg & ~((JIMM_MASK) << 2))
> -		printk(KERN_WARNING "Micro-assembler field overflow\n");
> +	WARN(arg & ~((JIMM_MASK) << 2),

    Could drop parens around JIMM_MASK while at it...

WBR, Sergei
