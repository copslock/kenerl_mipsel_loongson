Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jul 2014 18:50:35 +0200 (CEST)
Received: from smtp-out-066.synserver.de ([212.40.185.66]:1094 "EHLO
        smtp-out-065.synserver.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6860995AbaGHQuc39BAy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Jul 2014 18:50:32 +0200
Received: (qmail 351 invoked by uid 0); 8 Jul 2014 16:50:31 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@metafoo.de
X-SynServer-PPID: 314
Received: from p4fe631a0.dip0.t-ipconnect.de (HELO ?192.168.0.108?) [79.230.49.160]
  by 217.119.54.81 with AES128-SHA encrypted SMTP; 8 Jul 2014 16:50:31 -0000
Message-ID: <53BC2157.1090809@metafoo.de>
Date:   Tue, 08 Jul 2014 18:50:31 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.6.0
MIME-Version: 1.0
To:     Stefan Agner <stefan@agner.ch>
CC:     linux-mips@linux-mips.org
Subject: Re: dma: jz4740: Null pointer dereference
References: <82522335fb2ef700d5a94f9217cbdff6@agner.ch>
In-Reply-To: <82522335fb2ef700d5a94f9217cbdff6@agner.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41087
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

On 07/08/2014 06:41 PM, Stefan Agner wrote:
> Hi Lars,
>
> While looking through different DMA drivers, just stumbled upon this
> inside jz4740_dma_chan_irq:
>
> if (chan->next_sg == chan->desc->num_sgs) {
> 	chan->desc = NULL;
> 	vchan_cookie_complete(&chan->desc->vdesc);
>                                           ^ null pointer dereference
> }
>
> I'm not sure what the correct fix is, hence I thought I report it to you
> as author of the driver.

Hi,

Thanks for the report. Yes this is a bug and I have a fix for it. Currently 
that codepath is not exercised though (no non-cyclic users of the JZ4740 
dmaengine driver), so the fix is not critical. It will be sent upstream soon 
together which a couple of other patches for this driver.

- Lars
