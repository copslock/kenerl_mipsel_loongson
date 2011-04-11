Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Apr 2011 08:12:01 +0200 (CEST)
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:60779
        "EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1490982Ab1DKGL6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Apr 2011 08:11:58 +0200
Received: from [62.90.235.247] (port=59178 helo=zimbra-mta.compulab.co.il)
        by softlayer.compulab.co.il with esmtp (Exim 4.69)
        (envelope-from <grinberg@compulab.co.il>)
        id 1Q9AL0-0000eq-G9; Mon, 11 Apr 2011 09:11:02 +0300
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra-mta.compulab.co.il (Postfix) with ESMTP id 5DE4A7E91FF;
        Mon, 11 Apr 2011 09:11:01 +0300 (IDT)
X-Virus-Scanned: amavisd-new at compulab.co.il
Received: from zimbra-mta.compulab.co.il ([127.0.0.1])
        by localhost (zimbra-mta.compulab.co.il [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Yuy1LUAuTvwF; Mon, 11 Apr 2011 09:11:00 +0300 (IDT)
Received: from [10.1.1.13] (grinberg-pc.compulab.local [10.1.1.13])
        by zimbra-mta.compulab.co.il (Postfix) with ESMTP id 567E77E91EF;
        Mon, 11 Apr 2011 09:11:00 +0300 (IDT)
Message-ID: <4DA29B75.4090401@compulab.co.il>
Date:   Mon, 11 Apr 2011 09:11:01 +0300
From:   Igor Grinberg <grinberg@compulab.co.il>
Organization: CompuLab Ltd.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en; rv:1.9.2.13) Gecko/20101211 Lightning/1.0b2 Thunderbird/3.1.7
MIME-Version: 1.0
To:     wanlong.gao@gmail.com
CC:     linux@arm.linux.org.uk, hans-christian.egtvedt@atmel.com,
        ralf@linux-mips.org, benh@kernel.crashing.org, paulus@samba.org,
        david.woodhouse@intel.com, akpm@linux-foundation.org,
        u.kleine-koenig@pengutronix.de, mingo@elte.hu, rientjes@google.com,
        nicolas.ferre@atmel.com, eric@eukrea.com, tony@atomide.com,
        santosh.shilimkar@ti.com, khilman@deeprootsystems.com,
        ben-linux@fluff.org, sam@ravnborg.org, manuel.lauss@googlemail.com,
        galak@kernel.crashing.org, anton@samba.org,
        grant.likely@secretlab.ca, sfr@canb.auug.org.au,
        jwboyer@linux.vnet.ibm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] fix build warnings on defconfigs
References: <1302375858-11253-1-git-send-email-wanlong.gao@gmail.com>
In-Reply-To: <1302375858-11253-1-git-send-email-wanlong.gao@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - softlayer.compulab.co.il
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - compulab.co.il
Return-Path: <grinberg@compulab.co.il>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29731
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grinberg@compulab.co.il
Precedence: bulk
X-list: linux-mips

On 04/09/11 22:04, wanlong.gao@gmail.com wrote:

> From: Wanlong Gao <wanlong.gao@gmail.com>
>
> Change the BT_L2CAP and BT_SCO defconfigs from 'm' to 'y',
> since BT_L2CAP and BT_SCO had changed to bool configs.
>
> Signed-off-by: Wanlong Gao <wanlong.gao@gmail.com>
> ---

For:

>  arch/arm/configs/cm_x2xx_defconfig         |    4 ++--
>  arch/arm/configs/cm_x300_defconfig         |    4 ++--
>  arch/arm/configs/em_x270_defconfig         |    4 ++--

Acked-by: Igor Grinberg <grinberg@compulab.co.il>

-- 
Regards,
Igor.
