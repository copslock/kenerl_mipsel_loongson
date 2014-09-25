Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Sep 2014 03:37:01 +0200 (CEST)
Received: from mail-pa0-f50.google.com ([209.85.220.50]:50650 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009723AbaIYBhA2Dvy1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Sep 2014 03:37:00 +0200
Received: by mail-pa0-f50.google.com with SMTP id lj1so1400735pab.37
        for <linux-mips@linux-mips.org>; Wed, 24 Sep 2014 18:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=NuiVuAtL7prrdVcw8VmS5t8zKCNtiFhnPonXYM3tLfw=;
        b=rnw3hxYmq6eHo6/0lEhsliXLF5HMvCgeXvziTIUW9cCtt+OAjx1gppkS75V9eWwqK/
         NdzlRXa+GYjwOlilVlUf+jJ9utvXB1l2GXry15kyjiR8dF1LLmUAVUlXXLRRjXdr8arZ
         mmPtG9cavZPUS/7qhNGaBnIrpBR16JyLhbiW5q74gxa5lWL2C24j32j3QbFegrS5rFCi
         zv6E8b5U7/iXcxMaKEmA/5vAwMlXlUCt90eHF+mPe9wAoEwwztIb3aMo2Wzrrsli+zSo
         f9fVZj0bz9N3271/Ok06VCY0Fey3f2ils+XGtoky63Lfdppefj1i//sRo0um5hWPcDjG
         FUvQ==
X-Received: by 10.69.19.202 with SMTP id gw10mr13814807pbd.106.1411609014007;
        Wed, 24 Sep 2014 18:36:54 -0700 (PDT)
Received: from [10.12.164.252] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id ns9sm472244pbb.70.2014.09.24.18.36.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Sep 2014 18:36:53 -0700 (PDT)
Message-ID: <542371A3.8020003@gmail.com>
Date:   Wed, 24 Sep 2014 18:36:35 -0700
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
MIME-Version: 1.0
To:     "Jayachandran C." <jchandra@broadcom.com>
CC:     linux-mips@linux-mips.org, ganesanr@broadcom.com
Subject: Re: [PATCH 0/2] MIPS: Netlogic: modular build fixes
References: <1411581311-6458-1-git-send-email-f.fainelli@gmail.com> <20140925012514.GA3703@jayachandranc.netlogicmicro.com>
In-Reply-To: <20140925012514.GA3703@jayachandranc.netlogicmicro.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42774
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 09/24/2014 06:25 PM, Jayachandran C. wrote:
> On Wed, Sep 24, 2014 at 10:55:09AM -0700, Florian Fainelli wrote:
>> Hello Ralf, Jayachandran, Ganesan
>>
>> Here are two small fixes for modular USB and AHCI builds that I encountered
>> while playing with a FVP board.
>>
>> These are based off upstream-sfr/mips-for-linux-next
> 
> We have a slightly different fix for this in our internal repository, I
> was planning to submit it soon:
> 
> 
> index be358a8..5c876d3 100644
> --- a/arch/mips/netlogic/xlp/Makefile
> +++ b/arch/mips/netlogic/xlp/Makefile
> @@ -1,6 +1,6 @@
>  obj-y				+= setup.o nlm_hal.o cop2-ex.o dt.o
>  obj-$(CONFIG_SMP)		+= wakeup.o
> -obj-$(CONFIG_USB)		+= usb-init.o
> -obj-$(CONFIG_USB)		+= usb-init-xlp2.o
> -obj-$(CONFIG_SATA_AHCI)		+= ahci-init.o
> -obj-$(CONFIG_SATA_AHCI)		+= ahci-init-xlp2.o
> +obj-$(subst m,y,$(CONFIG_USB))	+= usb-init.o
> +obj-$(subst m,y,$(CONFIG_USB))	+= usb-init-xlp2.o
> +obj-$(subst m,y,$(CONFIG_SATA_AHCI))	+= ahci-init.o
> +obj-$(subst m,y,$(CONFIG_SATA_AHCI))	+= ahci-init-xlp2.o
> 
> This will add the init code when USB or SATA is enabled as module or
> is built-in, so I think this is be a better solution.

Not sure which one is "better" than the other since they both solve the
same problem, but whatever works for you also works for me! The tree
seems to have a mix of both approaches.

Thanks!
--
Florian
