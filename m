Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Nov 2015 21:49:42 +0100 (CET)
Received: from mout.kundenserver.de ([217.72.192.73]:58950 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012568AbbKUUtl07c2D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Nov 2015 21:49:41 +0100
Received: from wuerfel.localnet ([134.3.118.24]) by mrelayeu.kundenserver.de
 (mreue103) with ESMTPSA (Nemesis) id 0MNN9N-1ZyIDj3KvJ-006z9D; Sat, 21 Nov
 2015 21:49:22 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Joshua Henderson <joshua.henderson@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Purna Chandra Mandal <purna.mandal@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 03/14] DEVICETREE: Add PIC32 clock binding documentation
Date:   Sat, 21 Nov 2015 21:49:20 +0100
Message-ID: <7182714.6Xmo6Noc6V@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1448065205-15762-4-git-send-email-joshua.henderson@microchip.com>
References: <1448065205-15762-1-git-send-email-joshua.henderson@microchip.com> <1448065205-15762-4-git-send-email-joshua.henderson@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:qmcxxYClqX+xmUR5fIcAfZYxS/lxSOy8P0ypdRlSIO0ZbLhXngy
 TtRHiugBCglUyduu9EokUbFZ38nJ7HL2h2vcqpOYVdCaBYHnLMamDkCgDHo/e/V9uJ9U5MU
 NAeMeisVADpGI+GQnHsa1vGbkN8Na7Ct5IfpHbLJ6683FeIcXvzBRlvOA2LWu95a2oHaZBG
 4xG6i8+yK6TCewbmiunLQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZpsuAYhxVu8=:/AgHToNz4urt6buB3WGs5y
 1r46uJDHZHV3yrLvqTF+sTDfxWQQZYU26spq445S9lpap5sRBmxGqy91lKIKMsqoyrebdL+ze
 o2nmRpJeKBsTQWUmKmC3gKFW2Zg9/BrVo28P/0dJzqqJK3RyljtRcHeCGubsdxideyAQpSRiX
 wecvxmaT434JwiQ6aRomq9nwAoRGrPR94lFr9+eJ0f8J1WN2bfcx3AYiXDqq1V9U7jqXcgo2X
 neQHSoUXXkeosa4cioazdS5a6S0vrO5g+nWsv4xnt+z6EQFN6xDahq9mcvKkhoaNzJe13GAZO
 6aEtAQkmal98cX0SFkGBlMUdcXuqXWEV6YstopWhcB2uqOAYEVOaiMQEMl+TnUsnXfZEpuQlf
 KBwOJbOf2BTn89owhJS6k7SBZu3uc8SHu9ERV4L5J0w/BAcf+2jUhr7qDIwDi356P5+WFwAe8
 akJMwlER4CoLKahF55Jac+vwqAng1dpfTzjY68uXgikjPVpCCXAvJFlein7pAQjLaqhgu8dgW
 RXwln0hBr93jNbAA4ravMyYn87GLh0S93kDJWKD2MfsqX8AozCTRYfiNmKEAu0I2iIczEXvxz
 JHeopXD4tCe+i7oAywYUSmnEOTo2ATn3Z8Rc95ZACkmFpW1/0Kat4ZjsVA1S3iN76njK90RZq
 1+L9vDYcKW7xD+aZH2uuaisvS4EVyQGx2sa7QT6O9vBLxnxI/6t1G5H857PkZV1NUSUL3C6qE
 Xl5TQJ4yPJsgsVU/
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50032
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Friday 20 November 2015 17:17:15 Joshua Henderson wrote:
> +/* PIC32 specific clks */
> +pic32_clktree {
> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +       reg = <0x1f801200 0x200>;
> +       compatible = "microchip,pic32-clk";
> +       interrupts = <12>;
> +       ranges;
> +
> +       /* secondary oscillator; external input on SOSCI pin */
> +       SOSC:sosc_clk {
> +               #clock-cells = <0>;
> +               compatible = "microchip,pic32-sosc";
> +               clock-frequency = <32768>;
> +               reg = <0x1f801200 0x10   /* enable reg */
> +                       0x1f801390 0x10>; /* status reg */
> +               microchip,bit-mask = <0x02>; /* enable mask */
> +               microchip,status-bit-mask = <0x10>; /* status-mask*/
> +       };
> 

If you want to use the reg property in this way for each cell,
at least use a 'ranges' that only translates the actual registers
like this

	ranges = <0 0x1f801200 0x200>

	sosc_clk {
		...
		reg = <0x000 0x10>, <0x190 0x10>;
		...
	};

	Arnd
