Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2010 20:25:05 +0100 (CET)
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:51407 "HELO
        na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1491930Ab0KWTZB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Nov 2010 20:25:01 +0100
Received: from source ([209.85.160.52]) by na3sys009aob101.postini.com ([74.125.148.12]) with SMTP
        ID DSNKTOwVAG4ku809BDnZwXq8ammSUGbHiF3j@postini.com; Tue, 23 Nov 2010 11:25:01 PST
Received: by mail-pw0-f52.google.com with SMTP id 5so2506263pwi.11
        for <multiple recipients>; Tue, 23 Nov 2010 11:24:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.229.95.11 with SMTP id b11mr6679718qcn.174.1290540287790; Tue,
 23 Nov 2010 11:24:47 -0800 (PST)
Received: by 10.220.194.74 with HTTP; Tue, 23 Nov 2010 11:24:47 -0800 (PST)
In-Reply-To: <1290524800-21419-10-git-send-email-juhosg@openwrt.org>
References: <1290524800-21419-1-git-send-email-juhosg@openwrt.org>
        <1290524800-21419-10-git-send-email-juhosg@openwrt.org>
Date:   Tue, 23 Nov 2010 14:24:47 -0500
Message-ID: <AANLkTinoOOU=yWvF2HQV9-Rp9NBxNDUO=G+kT7y=9MrY@mail.gmail.com>
Subject: Re: [PATCH 09/18] input: add input driver for polled GPIO buttons
From:   Ben Gardiner <bengardiner@nanometrics.ca>
To:     Gabor Juhos <juhosg@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kaloz@openwrt.org, "Luis R. Rodriguez" <lrodriguez@atheros.com>,
        Cliff Holden <Cliff.Holden@atheros.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mike Frysinger <vapier@gentoo.org>, linux-input@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <bengardiner@nanometrics.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28501
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bengardiner@nanometrics.ca
Precedence: bulk
X-list: linux-mips

Hi Gabor,

On Tue, Nov 23, 2010 at 10:06 AM, Gabor Juhos <juhosg@openwrt.org> wrote:
> The existing gpio-keys driver can be usable only for GPIO lines with
> interrupt support. Several devices have buttons connected to a GPIO
> line which is not capable to generate interrupts. This patch adds a
> new input driver using the generic GPIO layer and the input-polldev
> to support such buttons.
>
> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Mike Frysinger <vapier@gentoo.org>
> Cc: linux-input@vger.kernel.org

I'm excited to see this patch posted. As I understand it, this
"separate polling gpio button driver" approach is preferred to the
"polling extensions in gpio-keys approach". I'm sorry I missed the RFC
[1] : I posted a revised version of Alex Clouter's and Paul Mundt's
polling gpio-keys support [2]. But now I can try integrating this
driver. :)

I will be posting a version of the patch shortly that is still using
the polling-gpio-keys support -- because there are discussions in the
machine-specific parts. Then I will try to integrate this driver into
the series.

Best Regards,
Ben Gardiner

[1] http://article.gmane.org/gmane.linux.kernel.input/16468
[2] http://article.gmane.org/gmane.linux.kernel.input/16587

---
Nanometrics Inc.
http://www.nanometrics.ca
