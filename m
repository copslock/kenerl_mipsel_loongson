Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Feb 2013 21:20:51 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:52338 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827665Ab3BOUUuzJ54k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Feb 2013 21:20:50 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id A40228F60;
        Fri, 15 Feb 2013 21:20:49 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4QCMKBSUVLgW; Fri, 15 Feb 2013 21:20:41 +0100 (CET)
Received: from [IPv6:2001:470:1f0b:447:6453:c44e:14a5:63c1] (unknown [IPv6:2001:470:1f0b:447:6453:c44e:14a5:63c1])
        by hauke-m.de (Postfix) with ESMTPSA id 013BC85EA;
        Fri, 15 Feb 2013 21:20:40 +0100 (CET)
Message-ID: <511E9896.9010502@hauke-m.de>
Date:   Fri, 15 Feb 2013 21:20:38 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To:     Hauke Mehrtens <hauke@hauke-m.de>
CC:     john@phrozen.org, ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 2/2] ssb: add gpio_to_irq again
References: <1355275031-19297-1-git-send-email-hauke@hauke-m.de> <1355275031-19297-2-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1355275031-19297-2-git-send-email-hauke@hauke-m.de>
X-Enigmail-Version: 1.4.6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 35780
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 12/12/2012 02:17 AM, Hauke Mehrtens wrote:
> The old code had support for gpio_to_irq, but the new code did not
> provide this function, but returned -ENXIO all the time. This patch
> adds the missing function.
> 
> arch/mips/bcm47xx/wgt634u.c calls gpio_to_irq() and got the correct irq
> number with the old gpio handling code. With this patch the code in
> wgt634u.c should work again. I do not have a wgt634u to test this.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Please drop these two patches

They will cause merge problems. After I talked to blogic and after that
I send these patches to John Linville for inclusion into the wireless tree.

Hauke
