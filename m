Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Oct 2015 14:54:27 +0200 (CEST)
Received: from smtp-out-240.synserver.de ([212.40.185.240]:1114 "EHLO
        smtp-out-240.synserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009479AbbJEMyKIM6A8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Oct 2015 14:54:10 +0200
Received: (qmail 20694 invoked by uid 0); 5 Oct 2015 12:54:08 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@metafoo.de
X-SynServer-PPID: 20471
Received: from 149-13-247-10.c.wicklowbroadband.com (HELO ?10.128.45.80?) [149.13.247.10]
  by 217.119.54.96 with AES128-SHA encrypted SMTP; 5 Oct 2015 12:54:06 -0000
Message-ID: <561272EC.2080602@metafoo.de>
Date:   Mon, 05 Oct 2015 14:54:04 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
MIME-Version: 1.0
To:     Thierry Reding <thierry.reding@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: jz4740: qi_lb60: Remove unused linux/leds_pwm.h
 include
References: <1444048957-29486-1-git-send-email-thierry.reding@gmail.com>
In-Reply-To: <1444048957-29486-1-git-send-email-thierry.reding@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49439
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

On 10/05/2015 02:42 PM, Thierry Reding wrote:
> The board code never sets up a leds-pwm device, so including the header
> is not necessary.
>
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks
