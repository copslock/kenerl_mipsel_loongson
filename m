Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2011 08:26:35 +0200 (CEST)
Received: from newsmtp5.atmel.com ([204.2.163.5]:56888 "EHLO
        sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1490948Ab1FFG0a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jun 2011 08:26:30 +0200
Received: from csomb01.corp.atmel.com ([10.95.30.150])
        by sjogate2.atmel.com (8.13.6/8.13.6) with ESMTP id p566LoQ5011998;
        Sun, 5 Jun 2011 23:21:57 -0700 (PDT)
Received: from hammb01.corp.atmel.com ([10.142.130.20]) by csomb01.corp.atmel.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 6 Jun 2011 00:24:50 -0600
Received: from [10.191.255.186] ([10.191.255.186]) by hammb01.corp.atmel.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 6 Jun 2011 07:24:48 +0100
Subject: Re: [PATCH] Fix build warning of the defconfigs
From:   Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
To:     Wanlong Gao <wanlong.gao@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        linux@arm.linux.org.uk, vapier@gentoo.org, ralf@linux-mips.org,
        benh@kernel.crashing.org, paulus@samba.org, lethal@linux-sh.org,
        gxt@mprc.pku.edu.cn, david.woodhouse@intel.com,
        akpm@linux-foundation.org, u.kleine-koenig@pengutronix.de,
        mingo@elte.hu, rientjes@google.com, w.sang@pengutronix.de,
        sam@ravnborg.org, manuel.lauss@googlemail.com, anton@samba.org,
        arnd@arndb.de
In-Reply-To: <1306945763-6583-1-git-send-email-wanlong.gao@gmail.com>
References: <1306945763-6583-1-git-send-email-wanlong.gao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: Atmel Corporation
Date:   Mon, 06 Jun 2011 08:24:45 +0200
Message-ID: <1307341485.3104.0.camel@hcegtvedt.norway.atmel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Jun 2011 06:24:48.0479 (UTC) FILETIME=[6F740EF0:01CC2412]
X-archive-position: 30237
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hans-christian.egtvedt@atmel.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3842

On Thu, 2011-06-02 at 00:29 +0800, Wanlong Gao wrote:
> RTC_CLASS is changed to bool.
> So value 'm' is invalid.
> 
> Signed-off-by: Wanlong Gao <wanlong.gao@gmail.com>

<snipp>

>  arch/avr32/configs/atngw100_mrmt_defconfig |    2 +-
>

For the AVR32 related changes.

Acked-by: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>

<snipp>

-- 
Hans-Christian Egtvedt
