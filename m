Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Feb 2011 18:35:52 +0100 (CET)
Received: from mail.vyatta.com ([76.74.103.46]:56754 "EHLO mail.vyatta.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491832Ab1BXRfo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 24 Feb 2011 18:35:44 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.vyatta.com (Postfix) with ESMTP id 0694218290E5;
        Thu, 24 Feb 2011 09:35:38 -0800 (PST)
X-Virus-Scanned: amavisd-new at tahiti.vyatta.com
Received: from mail.vyatta.com ([127.0.0.1])
        by localhost (mail.vyatta.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jXMnmw95Ks8H; Thu, 24 Feb 2011 09:35:37 -0800 (PST)
Received: from nehalam (pool-74-107-135-205.ptldor.fios.verizon.net [74.107.135.205])
        by mail.vyatta.com (Postfix) with ESMTPSA id 1785A18290DE;
        Thu, 24 Feb 2011 09:35:37 -0800 (PST)
Date:   Thu, 24 Feb 2011 09:35:35 -0800
From:   Stephen Hemminger <shemminger@vyatta.com>
To:     "Anoop P.A" <anoop.pa@gmail.com>
Cc:     davem@davemloft.net, khilman@deeprootsystems.com, cyril@ti.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] Network driver for PMC-Sierra MSP71xx TSMAC.
Message-ID: <20110224093535.744ebaf7@nehalam>
In-Reply-To: <1298548660-10546-1-git-send-email-anoop.pa@gmail.com>
References: <1298548660-10546-1-git-send-email-anoop.pa@gmail.com>
Organization: Vyatta
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.22.0; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <shemminger@vyatta.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29281
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shemminger@vyatta.com
Precedence: bulk
X-list: linux-mips

On Thu, 24 Feb 2011 17:27:40 +0530
"Anoop P.A" <anoop.pa@gmail.com> wrote:
> +const char version[] = "pmcmsp_tsmac.c:v2.0 01/09/2007, PMC-Sierra\n";
> +const char cardname[] = "pmcmsp_tsmac";

All data and functions that are only used by this driver should be marked static.

> +const char drv_reldate[] = "$Date: 2010/07/15 07:38:59 $";
> +const char drv_file[] = __FILE__;

This is bogus noise.


-- 
