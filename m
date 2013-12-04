Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Dec 2013 15:28:55 +0100 (CET)
Received: from 0.mx.nanl.de ([217.115.11.12]:49841 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6815989Ab3LDO2uEXRA6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 Dec 2013 15:28:50 +0100
Received: from mail-vc0-f175.google.com (mail-vc0-f175.google.com [209.85.220.175])
        by mail.nanl.de (Postfix) with ESMTPSA id D21274607B;
        Wed,  4 Dec 2013 14:27:45 +0000 (UTC)
Received: by mail-vc0-f175.google.com with SMTP id ld13so11263375vcb.6
        for <multiple recipients>; Wed, 04 Dec 2013 06:28:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gJqWdwcesVlk7M4wtkJLi5glsavE+w+p3URzkRi4WP8=;
        b=fmv9wvG6Ko2Az0fEEBpVwL3Dbwr0ubZGhAKkUKeVSrUG7vl8bZ0tU9UbLOXR9JVQfV
         kS9VWf4OrctR6QQePk4uHpKUGz4zZGowSRQMw1FbWBsmMO0AtOi3mCawhGD7zhmPFpM+
         HcoYyBcAjkFeOUXjwzS2HJpJuxTOjmXzLHjm68qoC9S6LZKNoks5TAcHjnIuj2umz05t
         XMRxI6IY2ikBor/Wvb+vPoEvK/F3RQJp+v82REF62CenpK6uqyPKhG6M3nZiv2qKvm29
         +/86/IkIlnUtJjwyibLg0Ze9VW6439J2PPcRsJaCg3Eej1lCw/eCzcxz2irUhLJq+Kqh
         LK9A==
X-Received: by 10.220.159.4 with SMTP id h4mr58918304vcx.1.1386167325496; Wed,
 04 Dec 2013 06:28:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.220.208.136 with HTTP; Wed, 4 Dec 2013 06:28:25 -0800 (PST)
In-Reply-To: <20131204140853.GU29268@sirena.org.uk>
References: <1385811726-6746-1-git-send-email-jogo@openwrt.org>
 <1385811726-6746-6-git-send-email-jogo@openwrt.org> <20131204133823.GS29268@sirena.org.uk>
 <CAOiHx==utbmYUS4BLoSaaGi91Kw5voQ2vFiA97GLmwn8yU19Dw@mail.gmail.com> <20131204140853.GU29268@sirena.org.uk>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Wed, 4 Dec 2013 15:28:25 +0100
Message-ID: <CAOiHx==Lp7FFCCWaSiohvdAyzErBuz5n7sUVs1+A4S1axD9qCA@mail.gmail.com>
Subject: Re: [PATCH 5/5] spi: add bcm63xx HSSPI driver
To:     Mark Brown <broonie@kernel.org>
Cc:     MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-spi@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Maxime Bizon <mbizon@freebox.fr>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38638
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On Wed, Dec 4, 2013 at 3:08 PM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Dec 04, 2013 at 03:04:48PM +0100, Jonas Gorski wrote:
>> On Wed, Dec 4, 2013 at 2:38 PM, Mark Brown <broonie@kernel.org> wrote:
>
>> > This ought to be disable_unprepare().  It would also be better to move
>> > this to runtime PM (you can set auto_runtime_pm to have the core manage
>> > the enable and disable for you) since that will save a bit of power.
>
>> I already set auto_runtime_pm to true. I basically copied what's
>> currently in spi-bcm63xx.c *coughs*. Is there anything else needed
>> besides what you mentioned?
>
> You'll need to call pm_runtime_enable() and so on to turn on runtime PM
> in probe() and reverse that in remove() but otherwise no, just adding
> the runtime callbacks should be fine.

I see. Looks like I just copied your oversight from
5355d96d6fb56507761f261a23c0831f67fa0e0f ("spi/bcm63xx: Convert to
core runtime PM") :P I'll add that to my list of things to fix.

Grepping through drivers/spi, I see a few drivers not calling
pm_runtime_enable(), but setting auto_runtime_pm to true, and a few
doing the opposite. These should probably aligned, too.


Regards
Jonas
