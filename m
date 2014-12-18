Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 16:31:34 +0100 (CET)
Received: from smtp-out-207.synserver.de ([212.40.185.207]:1059 "EHLO
        smtp-out-207.synserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012934AbaLRP35NUIW1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 16:29:57 +0100
Received: (qmail 20366 invoked by uid 0); 18 Dec 2014 15:29:54 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@metafoo.de
X-SynServer-PPID: 19850
Received: from ppp-82-135-76-235.dynamic.mnet-online.de (HELO ?192.168.178.23?) [82.135.76.235]
  by 217.119.54.96 with AES128-SHA encrypted SMTP; 18 Dec 2014 15:29:53 -0000
Message-ID: <5492F2DE.60201@metafoo.de>
Date:   Thu, 18 Dec 2014 16:29:34 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.3.0
MIME-Version: 1.0
To:     Brian Norris <computersforpeace@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: JZ4740: fixup #include's (sparse)
References: <1418870341-16618-1-git-send-email-computersforpeace@gmail.com>
In-Reply-To: <1418870341-16618-1-git-send-email-computersforpeace@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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

On 12/18/2014 03:39 AM, Brian Norris wrote:
> Fixes sparse warnings:
>
>    arch/mips/jz4740/irq.c:63:6: warning: symbol 'jz4740_irq_suspend' was not declared. Should it be static?
>    arch/mips/jz4740/irq.c:69:6: warning: symbol 'jz4740_irq_resume' was not declared. Should it be static?
>
> Also, I've seen some elusive build errors on my automated build test
> where JZ4740_IRQ_BASE and NR_IRQS are missing, but I can't reproduce
> them manually for some reason. Anyway, mach-jz4740/irq.h should help us
> avoid relying on some implicit include.
>
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.
