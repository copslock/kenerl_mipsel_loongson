Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Sep 2013 20:48:26 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:42014 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823068Ab3IASsZG1O4F (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 1 Sep 2013 20:48:25 +0200
Message-ID: <52238BEC.6020702@phrozen.org>
Date:   Sun, 01 Sep 2013 20:48:12 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: ralink: add RESET_CONTROLLER to the defconfig
References: <1378057127-21984-1-git-send-email-blogic@openwrt.org> <52238B08.3020408@openwrt.org>
In-Reply-To: <52238B08.3020408@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37733
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

On 01/09/13 20:44, Gabor Juhos wrote:
> 2013.09.01. 19:38 keltezéssel, John Crispin írta:
>> Without this symbol being set, we get an undefined symbol compile error.
>
> The reset framework is unconditionally used by the ralink platform code. So I
> assume that the compile error is also present on rt288x, rt3883 and mt7620.
>
> Maybe it would be better to add a 'select RESET_CONTROLLER' for the RALINK
> symbol in 'arch/mips/Kconfig'?
>
> BTW, I have looked into your 'MIPS: ralink: add support for reset-controller
> API' patch [1] again. That adds a 'select ARCH_HAS_RESET_CONTROLLER' to the
> MACH_VR41XX symbol instead of RALINK.
>

thanks, i will look into it

	John



> -Gabor
>
> 1. https://patchwork.linux-mips.org/patch/5668/
>
>
