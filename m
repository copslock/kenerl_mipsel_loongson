Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2015 21:30:49 +0100 (CET)
Received: from mail-wi0-f176.google.com ([209.85.212.176]:61362 "EHLO
        mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011712AbbASUar7H5wB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Jan 2015 21:30:47 +0100
Received: by mail-wi0-f176.google.com with SMTP id em10so699375wid.3;
        Mon, 19 Jan 2015 12:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=EuRMYXriPza5V+TxHfVWFW2/cfIvtyG2rgqc9Us1PJw=;
        b=GSlc6FTwanpsdqy/mlSGrAg9/7Y/i8poAcqM9LdKFWYqS2g9pTH9L7Vm7ST3CXAFsK
         gVe1uvVHA7TSxuGvo8laUfUxLt0aZNwSjLp8WZ5QQQhzNpum1eaLOiTwnxQHYZwfZGgR
         04wUnN+XA/SVkZfxYPj+fD1TBl30Vcqsa7GHpsU3nA6C3xptwmFO+xLRIMTiwTa85pel
         VtO2ItlYBgx5otf3REtRh61JWcuqpRZbeJFnblfGQ3zdWySlUFCBKwahjIjOYCsG72qx
         T2r7lql7VEzdX28qwIGm+dC4YhnhtXxM3N4ZHLCEYfCaLbMIJy0uA2H6Pjr1iLcgsqEk
         2BjA==
X-Received: by 10.180.198.209 with SMTP id je17mr38590589wic.17.1421699442835;
 Mon, 19 Jan 2015 12:30:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.194.59.199 with HTTP; Mon, 19 Jan 2015 12:30:22 -0800 (PST)
In-Reply-To: <54BD580C.6030701@gmail.com>
References: <1421681040-3392-1-git-send-email-aleksey.makarov@auriga.com>
 <20150119154357.GH21553@leverpostej> <54BD580C.6030701@gmail.com>
From:   Rob Herring <robherring2@gmail.com>
Date:   Mon, 19 Jan 2015 14:30:22 -0600
Message-ID: <CAL_JsqKq22K3kk7m09J1GZn9xXB+0tCUe75u3x+S3oWC0kyDcw@mail.gmail.com>
Subject: Re: [PATCH] SATA: OCTEON: support SATA on OCTEON platform
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Anton Vorontsov <avorontsov@ru.mvista.com>,
        Vinita Gupta <vgupta@caviumnetworks.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <Pawel.Moll@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>, Tejun Heo <tj@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45333
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robherring2@gmail.com
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

On Mon, Jan 19, 2015 at 1:16 PM, David Daney <ddaney.cavm@gmail.com> wrote:
> On 01/19/2015 07:43 AM, Mark Rutland wrote:
>>
>> On Mon, Jan 19, 2015 at 03:23:58PM +0000, Aleksey Makarov wrote:
>>>
>>> The OCTEON SATA controller is currently found on cn71XX devices.

[...]

>>> +
>>> +       /* Set a good dma_mask */
>>> +       pdev->dev.coherent_dma_mask = DMA_BIT_MASK(64);
>>> +       pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
>>
>>
>> I thought a dma-ranges property in the DT could be used to set up the
>> DMA mask appropriately?
>
>
> The DT contains no dma-ranges property, and we know a priori, that it should
> be 64-bits.

Neither this code nor dma-ranges should be necessary. The AHCI core
code will set the mask to 32 or 64 bits based on the AHCI Capabilities
register.

Rob
