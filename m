Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jun 2012 07:20:48 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:33806 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903686Ab2F1FUl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Jun 2012 07:20:41 +0200
Message-ID: <4FEBE95B.8060501@openwrt.org>
Date:   Thu, 28 Jun 2012 07:19:23 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     ralf@linux-mips.org
CC:     Roland Stigge <stigge@antcom.de>, jkosina@suse.cz,
        standby24x7@gmail.com, bhelgaas@google.com,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        grant.likely@secretlab.ca, linus.walleij@stericsson.com
Subject: Re: [PATCH RESEND] mips: pci-lantiq: Fix check for valid gpio
References: <1340836617-21666-1-git-send-email-stigge@antcom.de>
In-Reply-To: <1340836617-21666-1-git-send-email-stigge@antcom.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 33862
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

On 28/06/12 00:36, Roland Stigge wrote:
> This patch fixes two checks for valid gpio number, formerly (wrongly)
> considering zero as invalid, now using gpio_is_valid().
>
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: John Crispin <blogic@openwrt.org>



Hi Ralf,

can you take this via your tree ?

Thanks,
John
