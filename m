Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Sep 2013 11:51:36 +0200 (CEST)
Received: from Smtp1.Lantiq.com ([195.219.66.200]:57217 "EHLO smtp1.lantiq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817237Ab3IBJvbwe5yl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Sep 2013 11:51:31 +0200
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AqAEANteJFIKQLW9/2dsb2JhbABahA3AdIE4dIIlAQEEOj8QAgEIDRUUEDIlAgQBDQ3BG49OMQeDHYEAA55IjjOCKg
X-IronPort-AV: E=McAfee;i="5400,1158,7185"; a="2257965"
Received: from unknown (HELO MUCSVECH044.lantiq.com) ([10.64.181.189])
  by smtp1.lantiq.com with ESMTP; 02 Sep 2013 11:51:25 +0200
Received: from MUCSE039.lantiq.com ([169.254.3.108]) by MUCSVECH044.lantiq.com
 ([10.64.181.189]) with mapi id 14.02.0247.003; Mon, 2 Sep 2013 11:51:25 +0200
From:   <thomas.langer@lantiq.com>
To:     <blogic@openwrt.org>, <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: RE: [PATCH] MIPS: lantiq: add defconfig for xway SoC
Thread-Topic: [PATCH] MIPS: lantiq: add defconfig for xway SoC
Thread-Index: AQHOpzORPfxaeaxWk0S7uKVopF9vJpmyNJNQ
Date:   Mon, 2 Sep 2013 09:51:24 +0000
Message-ID: <593AEF6C47F46446852B067021A273D6D983C8C9@MUCSE039.lantiq.com>
References: <1378054268-4722-1-git-send-email-blogic@openwrt.org>
In-Reply-To: <1378054268-4722-1-git-send-email-blogic@openwrt.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.64.175.92]
x-tm-as-product-ver: SMEX-10.0.0.1412-7.000.1014-20122.006
x-tm-as-result: No--35.484400-0.000000-31
x-tm-as-user-approved-sender: Yes
x-tm-as-user-blocked-sender: No
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <thomas.langer@lantiq.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37736
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.langer@lantiq.com
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

Hello John,

> +CONFIG_SERIAL_8250=y
> +CONFIG_SERIAL_8250_CONSOLE=y
> +CONFIG_SERIAL_8250_RUNTIME_UARTS=2

I think this is wrong. Instead I would expect CONFIG_SERIAL_LANTIQ=y somewhere.


Best Regards,
Thomas
