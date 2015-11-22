Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Nov 2015 17:23:13 +0100 (CET)
Received: from exsmtp03.microchip.com ([198.175.253.49]:54814 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27011429AbbKVQXLZIL71 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 22 Nov 2015 17:23:11 +0100
Received: from [10.14.4.125] (10.10.76.4) by chn-sv-exch03.mchp-main.com
 (10.10.76.49) with Microsoft SMTP Server id 14.3.181.6; Sun, 22 Nov 2015
 09:23:01 -0700
Subject: Re: [PATCH 06/14] MIPS: Add support for PIC32MZDA platform
To:     Alban <albeu@free.fr>
References: <1448065205-15762-1-git-send-email-joshua.henderson@microchip.com>
 <1448065205-15762-7-git-send-email-joshua.henderson@microchip.com>
 <20151121123753.58eb6e80@tock>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
From:   Joshua Henderson <joshua.henderson@microchip.com>
Message-ID: <5651ED63.9090101@microchip.com>
Date:   Sun, 22 Nov 2015 09:29:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <20151121123753.58eb6e80@tock>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50050
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

On 11/21/2015 04:37 AM, Alban wrote:
> On Fri, 20 Nov 2015 17:17:18 -0700
> Joshua Henderson <joshua.henderson@microchip.com> wrote:
> 
>> This adds support for the Microchip PIC32 MIPS microcontroller with
>> the specific variant PIC32MZDA. PIC32MZDA is based on the MIPS m14KEc
>> core and boots using device tree.
>>
>> This includes an early pin setup and early clock setup needed prior to
>> device tree being initialized. In additon, an interface is provided to
>> synchronize access to registers shared across several peripherals.
>>
>> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
>>
>> [...]
>>
>> diff --git a/arch/mips/include/asm/mach-pic32/gpio.h
>> b/arch/mips/include/asm/mach-pic32/gpio.h new file mode 100644
> 
> Custom GPIO header are not used anymore, this file can be dropped.
> 
Ack.  Will drop.

Josh
