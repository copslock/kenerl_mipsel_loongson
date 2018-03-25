Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Mar 2018 16:39:34 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:36438 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991025AbeCYOj1cWWNw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 25 Mar 2018 16:39:27 +0200
Date:   Sun, 25 Mar 2018 11:38:27 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] MIPS: Fix build with DEBUG_ZBOOT and MACH_JZ4770
To:     James Hogan <jhogan@kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Message-Id: <1521988707.2054.0@smtp.crapouillou.net>
In-Reply-To: <20180322102606.GE13126@saruman>
References: <20180317201109.2000-1-paul@crapouillou.net>
        <20180322102606.GE13126@saruman>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1521988766; bh=jimNXq7CLO1bWagJf0bj5p2AQkk8yxBaTGtNSvPoMPo=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=mqsO+WUnkCAaFCVSvFqRFp+0FrTjrTRwa8OTtylJIZ9rs8IxDMJrDTz8CbBCHPYuoSP5kD+AjKFC5UCc/XjhIFDUH+gh2vyp+tWSoFBwuzlhwhTWq4Xdgh1Miq4PCt/O3hm6BL+6kAjuTphfFLXRr3uYuit5d9pAZvzbIcUEqIE=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63224
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

Hi,

Le jeu. 22 mars 2018 à 7:26, James Hogan <jhogan@kernel.org> a écrit :
> On Sat, Mar 17, 2018 at 09:11:09PM +0100, Paul Cercueil wrote:
>>  Since the UART addresses are the same across all Ingenic SoCs, we 
>> just
>>  use a #ifdef CONFIG_MACH_INGENIC instead of checking for indifidual
>>  Ingenic SoCs.
> 
> s/indifidual/individual/
> 
>>  --- a/arch/mips/boot/compressed/uart-16550.c
>>  +++ b/arch/mips/boot/compressed/uart-16550.c
>>  @@ -18,9 +18,9 @@
>>   #define PORT(offset) (CKSEG1ADDR(AR7_REGS_UART0) + (4 * offset))
>>   #endif
>> 
>>  -#if defined(CONFIG_MACH_JZ4740) || defined(CONFIG_MACH_JZ4780)
>>  -#include <asm/mach-jz4740/base.h>
>>  -#define PORT(offset) (CKSEG1ADDR(JZ4740_UART0_BASE_ADDR) + (4 * 
>> offset))
>>  +#if CONFIG_MACH_INGENIC
> 
> I think you meant #ifdef there.
> 
> Cheers
> James

Oops. Will fix in V2.

-Paul
