Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Mar 2015 22:45:40 +0100 (CET)
Received: from mail-yk0-f180.google.com ([209.85.160.180]:32781 "EHLO
        mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008811AbbCYVpjTLsdu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Mar 2015 22:45:39 +0100
Received: by ykek76 with SMTP id k76so20119120yke.0;
        Wed, 25 Mar 2015 14:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=//hfPc0H4bHO/rjNvQC93T26N/tlsqBcZgXZVB+r23c=;
        b=YT3Gm3+cUPnY7T49NBMOa/dtL8I3BEpsdYKUU8y3Qfq8vaBa3Ok39OESJbiwqKEH/Q
         QJQqs8KRgfudFduF2+9d/sJQ0yLUAZeqTOq2nXcf/chP1JfWzgVxmw3ihmCrcLUyLQLP
         nHulXqBV2DTZAyv/BFyLUa1gWhd04lfIw/OW+mZRVeRc69tClTjS/dTCZGPEU+oBJ+Vp
         v4SmJGDYhG/D7QMXexH9auiQk7TEoKT6PjL6CCqxY16HRnUCWMOCzN0AxLfHzf2q7WFf
         5cZ6d84dQDBuiCbkBj1iJROpOEqeF2qhMg4hWpYIUKBXMcOp/QVWTjhnOOeGRRSfP+as
         RKWw==
MIME-Version: 1.0
X-Received: by 10.170.165.5 with SMTP id h5mr13957556ykd.98.1427319934556;
 Wed, 25 Mar 2015 14:45:34 -0700 (PDT)
Received: by 10.170.120.16 with HTTP; Wed, 25 Mar 2015 14:45:34 -0700 (PDT)
In-Reply-To: <20150320132821.GL2869@sirena.org.uk>
References: <1426853793-24454-1-git-send-email-bert@biot.com>
        <1426853793-24454-3-git-send-email-bert@biot.com>
        <20150320132821.GL2869@sirena.org.uk>
Date:   Wed, 25 Mar 2015 23:45:34 +0200
Message-ID: <CAHp75VeGo8MT+p8eSAsZ8s+Re_qyd_v+BfE2yzNhOXsViOT5cA@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: Add driver for the CPLD chip on Mikrotik RB4xx boards
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bert Vermeulen <bert@biot.com>, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <andy.shevchenko@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46529
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andy.shevchenko@gmail.com
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

On Fri, Mar 20, 2015 at 3:28 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Mar 20, 2015 at 01:16:33PM +0100, Bert Vermeulen wrote:
>> The CPLD is connected to the NAND flash chip and five LEDs. Access to
>> those devices goes via this driver.
>
> None of this driver looks like a SPI controller - this appears to be a
> MFD so should have a core in drivers/mfd with function drivers for the
> individual features in the relevant subsystem directories.

I can add that even in this case better to use devm_* API, remove
unneded lines an so on. Seems like driver really far from modern
kernel API (2010 was written and mostly wasn't changed?).

-- 
With Best Regards,
Andy Shevchenko
