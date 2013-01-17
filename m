Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jan 2013 12:07:54 +0100 (CET)
Received: from mms1.broadcom.com ([216.31.210.17]:4931 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6832251Ab3AQLHwclWNi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jan 2013 12:07:52 +0100
Received: from [10.16.192.232] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Thu, 17 Jan 2013 03:05:33 -0800
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from SJEXCHCAS05.corp.ad.broadcom.com (10.16.203.13) by
 SJEXCHHUB02.corp.ad.broadcom.com (10.16.192.232) with Microsoft SMTP
 Server (TLS) id 8.2.247.2; Thu, 17 Jan 2013 03:07:29 -0800
Received: from SJEXCHMB13.corp.ad.broadcom.com (
 [fe80::9d40:1e86:a7dc:c46a]) by SJEXCHCAS05.corp.ad.broadcom.com (
 [::1]) with mapi id 14.01.0355.002; Thu, 17 Jan 2013 03:07:09 -0800
From:   "Arend Van Spriel" <arend@broadcom.com>
To:     "Ralf Baechle" <ralf@linux-mips.org>
cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "Hauke Mehrtens" <hauke@hauke-m.de>
Subject: RE: [PATCH] mips: bcm47xx: select GPIOLIB for BCMA on bcm47xx
 platform
Thread-Topic: [PATCH] mips: bcm47xx: select GPIOLIB for BCMA on bcm47xx
 platform
Thread-Index: AQHN6qa/v/GGymUgq0KH5rR7YPhodZhNb2Hj
Date:   Thu, 17 Jan 2013 11:07:08 +0000
Message-ID: <A47087626F2942499CF47E79803E771E04294E30@SJEXCHMB13.corp.ad.broadcom.com>
References: <1357323005-28008-1-git-send-email-arend@broadcom.com>
In-Reply-To: <1357323005-28008-1-git-send-email-arend@broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.9.208.53]
MIME-Version: 1.0
X-WSS-ID: 7CE905771ZS8202305-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-archive-position: 35477
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arend@broadcom.com
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

> From: Arend van Spriel [arend@broadcom.com]
> Sent: Friday, January 04, 2013 7:10 PM
> 
> The Kconfig items BCM47XX_BCMA and BCM47XX_SSB selected
> respectively BCMA_DRIVER_GPIO and SSB_DRIVER_GPIO. These
> options depend on GPIOLIB without explicitly selecting it
> so it results in a warning when GPIOLIB is not set:

Hi Ralf

Are you still intending to take this patch or did it slip by?

Gr. AvS

> scripts/kconfig/conf --oldconfig Kconfig
> warning: (BCM47XX_BCMA) selects BCMA_DRIVER_GPIO ... unmet direct
>         dependencies (BCMA_POSSIBLE && BCMA && GPIOLIB)
> warning: (BCM47XX_SSB) selects SSB_DRIVER_GPIO ... unmet direct
>         dependencies (SSB_POSSIBLE && SSB && GPIOLIB)
> 
> which subsequently results in compile errors.
> 
> Cc: Hauke Mehrtens <hauke@hauke-m.de>
> Signed-off-by: Arend van Spriel <arend@broadcom.com>
> ---
> Fixing a Kconfig issue in our nightly Jenkins build.
> 
> Gr. AvS
> ---
