Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2016 17:47:28 +0100 (CET)
Received: from exsmtp03.microchip.com ([198.175.253.49]:54840 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27012028AbcBHQr023sMP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Feb 2016 17:47:26 +0100
Received: from [10.14.4.125] (10.10.76.4) by chn-sv-exch03.mchp-main.com
 (10.10.76.49) with Microsoft SMTP Server id 14.3.181.6; Mon, 8 Feb 2016
 09:47:15 -0700
Subject: Re: [PATCH v6 2/2] pinctrl: pinctrl-pic32: Add PIC32 pin control
 driver
To:     Linus Walleij <linus.walleij@linaro.org>
References: <1454366916-10925-1-git-send-email-joshua.henderson@microchip.com>
 <1454366916-10925-2-git-send-email-joshua.henderson@microchip.com>
 <CACRpkdYfBNgX8sqOdUfU=qfJkm8MyO88c3PwiOVex=Gpu3s3gg@mail.gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
From:   Joshua Henderson <joshua.henderson@microchip.com>
Message-ID: <56B8C6A8.2030301@microchip.com>
Date:   Mon, 8 Feb 2016 09:47:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdYfBNgX8sqOdUfU=qfJkm8MyO88c3PwiOVex=Gpu3s3gg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51853
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joshua.henderson@microchip.com
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

On 02/05/2016 03:57 PM, Linus Walleij wrote:
> On Mon, Feb 1, 2016 at 11:48 PM, Joshua Henderson
> <joshua.henderson@microchip.com> wrote:
> 
>> Add a driver for the pin controller present on the Microchip PIC32
>> including the specific variant PIC32MZDA. This driver provides pinmux
>> and pinconfig operations as well as GPIO and IRQ chips for the GPIO
>> banks.
>>
>> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
>> Cc: Ralf Baechle <ralf@linux-mips.org>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> Changes since v5:
> 
> Patch applied.

Thanks Linus.

Josh
