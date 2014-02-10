Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Feb 2014 02:07:41 +0100 (CET)
Received: from mailout1.samsung.com ([203.254.224.24]:20862 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822672AbaBJBHgKiJ0I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Feb 2014 02:07:36 +0100
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0R0079K9S94W80@mailout1.samsung.com>; Mon,
 10 Feb 2014 10:07:21 +0900 (KST)
Received: from epcpsbgm2.samsung.com ( [203.254.230.49])
        by epcpsbgr2.samsung.com (EPCPMTA) with SMTP id B3.A1.09028.94628F25; Mon,
 10 Feb 2014 10:07:21 +0900 (KST)
X-AuditID: cbfee68e-b7f566d000002344-ed-52f826491427
Received: from epmmp2 ( [203.254.227.17])       by epcpsbgm2.samsung.com (EPCPMTA)
 with SMTP id 74.B5.28157.84628F25; Mon, 10 Feb 2014 10:07:21 +0900 (KST)
Received: from DOJG1HAN03 ([12.23.120.99])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0N0R00EL79S80B70@mmp2.samsung.com>; Mon,
 10 Feb 2014 10:07:20 +0900 (KST)
Sun-Java-System-SMTP-Warning: Lines longer than SMTP allows found and wrapped.
From:   Jingoo Han <jg1.han@samsung.com>
To:     'Arnd Bergmann' <arnd@arndb.de>,
        'Ralf Baechle' <ralf@linux-mips.org>,
        'Dmitry Torokhov' <dmitry.torokhov@gmail.com>,
        'Thierry Reding' <thierry.reding@gmail.com>
Cc:     'Linus Walleij' <linus.walleij@linaro.org>,
        'Russell King - ARM Linux' <linux@arm.linux.org.uk>,
        'Eric Miao' <eric.y.miao@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, linux-input@vger.kernel.org,
        linux-pwm@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
Subject: [PATCH 0/7] Remove HAVE_PWM config option
Date:   Mon, 10 Feb 2014 10:07:20 +0900
Message-id: <003901cf25fc$73002790$590076b0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-index: Ac8l/GYGhOsBgXmsQoSPhLhnprg0iA==
Content-language: ko
x-cr-hashedpuzzle: N9PW OlII XFJ4 oRAv sjHo slBk 2arq 3t8d 8wT5 ADKMxQ==
 ADgiZA== AE6eSg== AG1Pww== AIArWg== ALQi3Q==
 ATF6kw==;13;YQByAG4AZABAAGEAcgBuAGQAYgAuAGQAZQA7AGQAbQBpAHQAcgB5AC4AdABvAHIAbwBrAGgAbwB2AEAAZwBtAGEAaQBsAC4AYwBvAG0AOwBlAHIAaQBjAC4AeQAuAG0AaQBhAG8AQABnAG0AYQBpAGwALgBjAG8AbQA7AGoAZwAxAC4AaABhAG4AQABzAGEAbQBzAHUAbgBnAC4AYwBvAG0AOwBsAGkAbgB1AHMALgB3AGEAbABsAGUAaQBqAEAAbABpAG4AYQByAG8ALgBvAHIAZwA7AGwAaQBuAHUAeAAtAGEAcgBtAC0AawBlAHIAbgBlAGwAQABsAGkAcwB0AHMALgBpAG4AZgByAGEAZABlAGEAZAAuAG8AcgBnADsAbABpAG4AdQB4AC0AaQBuAHAAdQB0AEAAdgBnAGUAcgAuAGsAZQByAG4AZQBsAC4AbwByAGcAOwBsAGkAbgB1AHgALQBrAGUAcgBuAGUAbABAAHYAZwBlAHIALgBrAGUAcgBuAGUAbAAuAG8AcgBnADsAbABpAG4AdQB4AC0AbQBpAHAAcwBAAGwAaQBuAHUAeAAtAG0AaQBwAHMALgBvAHIAZwA7AGwAaQBuAHUAeAAtAHAAdwBtAEAAdgBnAGUAcgAuAGsAZQByAG4AZQBsAC4AbwByAGcAOwBsAGkAbgB1AHgAQABhAHIAbQAuAGwAaQBuAHUAeAAuAG8AcgBnAC4AdQBrADsAcgBhAGwAZgBAAGwAaQBuAHUAeAAtAG0AaQBwAHMALgBvAHIAZwA7AHQAaABpAGUAcgByAHkALgByAGUAZABpAG4AZwBAAGcAbQBhAGkAbAAuAGMAbwBtAA==;Sosha1_v1;7;{F49D30DC-CBAF-416D-
        8104-0ACDE382620A};agBnADEALgBoAGEAbgBAAHMAYQBtAHMAdQBuAGcALgBjAG8AbQA=;Mon,
 10 Feb 2014 01:06:59
 GMT;WwBQAEEAVABDAEgAIAAwAC8ANwBdACAAUgBlAG0AbwB2AGUAIABIAEEAVgBFAF8AUABXAE0AIABjAG8AbgBmAGkAZwAgAG8AcAB0AGkAbwBuAA==
x-cr-puzzleid: {F49D30DC-CBAF-416D-8104-0ACDE382620A}
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsVy+t8zQ11PtR9BBrdauCz+TjrGbnF40QtG
        ix1tx9ksLi+8xGox5c9yJotNj6+xWtz89I3V4vKuOWwWE6ZOYre4e3cVo8Xty7wWl/aoWPzc
        NY/FgdejpbmHzeP3r0mMHjtn3WX3uHNtD5vH0ZVrmTw2L6n36NuyitHj8ya5AI4oLpuU1JzM
        stQifbsErowzF3MKzgpUzL+xkr2B8SNPFyMnh4SAicTZ8y+ZIGwxiQv31rN1MXJxCAksY5TY
        8vk7I0zRgVtLWCES0xklTn5aygzh/GKUmLBqJxtIlbCAn0TTnEnMIDabgJrEly+H2UGKRARW
        Mko8eXkVbC6zwFkmif33LzJBdBhJHFrbBGRzcLAIqEq83ZoDEuYVsJU4/6iHEcIWlPgx+R4L
        iM0soCWxfudxJghbXmLzmrfMIK0SAuoSj/7qgoRFBPQkFnbeZYcoEZHY9+Id1Ad3OCXWXLGB
        sE0lrt/qBHtAQmAHh8TShm1gM1kEBCS+TT7EAjFTVmLTAWaIekmJgytusExglJyF5KJZSC6a
        heSiWUhWL2BkWcUomlqQXFCclF5kpFecmFtcmpeul5yfu4kRkir6djDePGB9iDEZaP1EZinR
        5HxgqskriTc0NjOyMDUxNTYytzQjTVhJnHfRw6QgIYH0xJLU7NTUgtSi+KLSnNTiQ4xMHJxS
        DYy2LS+LRbdWGp0L++zMrr2h3/rnkTOiPLM1ZQ22bV+3PFs74EOgtadZrdOCN5UT4txLrndy
        pFTOteeVF2TiEfVPe/7msUn2hgkKt0WUF4az57itsV9wQ+XbjqUcyu9krj5MStL/wbjGYs8j
        dh7m4626PW3G68xDVoWv/Wi0rfz/NasLmy9vNFRiKc5INNRiLipOBABARBpIKwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKKsWRmVeSWpSXmKPExsVy+t9jQV1PtR9BBpvuslj8nXSM3eLwoheM
        FjvajrNZXF54idViyp/lTBabHl9jtbj56RurxeVdc9gsJkydxG5x9+4qRovbl3ktLu1Rsfi5
        ax6LA69HS3MPm8fvX5MYPXbOusvucefaHjaPoyvXMnlsXlLv0bdlFaPH501yARxRDYw2GamJ
        KalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUAXKymUJeaUAoUC
        EouLlfTtME0IDXHTtYBpjND1DQmC6zEyQAMJ6xgzzlzMKTgrUDH/xkr2BsaPPF2MnBwSAiYS
        B24tYYWwxSQu3FvP1sXIxSEkMJ1R4uSnpcwQzi9GiQmrdrKBVAkL+Ek0zZnEDGKzCahJfPly
        mB2kSERgJaPEk5dXwdqZBc4ySey/f5EJosNI4tDaJiCbg4NFQFXi7dYckDCvgK3E+Uc9jBC2
        oMSPyfdYQGxmAS2J9TuPM0HY8hKb17xlBmmVEFCXePRXFyQsIqAnsbDzLjtEiYjEvhfvGCE+
        uMMpseaKDYRtKnH9VifzBEbhWUg2zEKyYRaSDbOQjFrAyLKKUTS1ILmgOCk910ivODG3uDQv
        XS85P3cTIzgRPZPewbiqweIQowAHoxIP744/34OEWBPLiitzDzFKcDArifC+vAsU4k1JrKxK
        LcqPLyrNSS0+xJgM9P9EZinR5HxgkswriTc0NjEzsjQyszAyMTcnTVhJnPdgq3WgkEB6Yklq
        dmpqQWoRzBYmDk6pBsaNEmIPBYtvtcYlO7ilaogH9f9R7IsNVpcxnLtrp8fL+44vTpxpeHki
        4oOtQIxk0/cej0712hNy3nl7E+3K2t8kGu5xepM0R0mfv9n7zA69epus8tsOZeJBlv68x5ir
        a6qmMig92/B1+a71f+um/l/S/Vs1TFDASif14K+ZO0xs0uMlDI+HKrEUZyQaajEXFScCAITD
        q+iIAwAA
DLP-Filter: Pass
X-MTR:  20000000000000000@CPGS
X-CFilter-Loop: Reflected
Return-Path: <jg1.han@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39260
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jg1.han@samsung.com
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

The HAVE_PWM symbol is only for legacy platforms that provide
the PWM API without using the generic framework, while PWM symbol
is used for PWM drivers using the generic PWM framework.

I looked at all HAVE_PWMs in the latest mainline kernel 3.14-rc1.
Three platforms are still using HAVE_PWM as below:

1. ARM - PXA
  ./arch/arm/mach-pxa/Kconfig

2. ARM - NXP LPC32XX
  ./arch/arm/Kconfig
  config ARCH_LPC32XX
  	select HAVE_PWM

3. MIPS - Ingenic JZ4740 based machines
  ./arch/mips/Kconfig
  config MACH_JZ4740
  	select HAVE_PWM

However, the legacy PWM drivers for PXA, LPC32XX, and JZ474 were
already moved to the generic PWM framework.
  ./drivers/pwm/pwm-pxa.c
  ./drivers/pwm/pwm-lpc32xx.c
  ./drivers/pwm/pwm-jz4740.c

In conclusion, HAVE_PWM should be removed, because HAVE_PWM is
NOT required anymore.

Jingoo Han (7):
      ARM: pxa: don't select HAVE_PWM
      ARM: lpc32xx: don't select HAVE_PWM
      ARM: remove HAVE_PWM config option
      MIPS: jz4740: don't select HAVE_PWM
      Input: max8997_haptic: remove HAVE_PWM dependencies
      Input: pwm-beepe: remove HAVE_PWM dependencies
      pwm: don't use IS_ENABLED(CONFIG_HAVE_PWM)

 arch/arm/Kconfig           |    4 ----
 arch/arm/mach-pxa/Kconfig  |   15 ---------------
 arch/mips/Kconfig          |    1 -
 drivers/input/misc/Kconfig |    4 ++--
 include/linux/pwm.h        |    2 +-
 5 files changed, 3 insertions(+), 23 deletions(-)

I would like to merge these patches as below:

1. Through arm-soc tree
  [PATCH 1/7] ARM: pxa: don't select HAVE_PWM
  [PATCH 2/7] ARM: lpc32xx: don't select HAVE_PWM
  [PATCH 3/7] ARM: remove HAVE_PWM config option

2. Through MIPS tree
  [PATCH 4/7] MIPS: jz4740: don't select HAVE_PWM

3. Through Input tree
  [PATCH 5/7] Input: max8997_haptic: remove HAVE_PWM dependencies
  [PATCH 6/7] Input: pwm-beepe: remove HAVE_PWM dependencies

4. Through PWM tree
  [PATCH 7/7] pwm: don't use IS_ENABLED(CONFIG_HAVE_PWM)

After merging these patches, all HAVE_PWM will be removed from
the mainline kernel. Thank you. :-)

Best regards,
Jingoo Han
