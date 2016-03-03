Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Mar 2016 22:16:00 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:33091 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27024634AbcCCVP7JDTu1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 Mar 2016 22:15:59 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id B2AA52039E;
        Thu,  3 Mar 2016 21:15:56 +0000 (UTC)
Received: from mail-yw0-f178.google.com (mail-yw0-f178.google.com [209.85.161.178])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3017920392;
        Thu,  3 Mar 2016 21:15:55 +0000 (UTC)
Received: by mail-yw0-f178.google.com with SMTP id b72so26176852ywe.0;
        Thu, 03 Mar 2016 13:15:55 -0800 (PST)
X-Gm-Message-State: AD7BkJLOiQAtN/5gpC8IIs0Y6JP+KFhi70FmtACs/EqtPSDmwUQw1kVC3xlo/CRfEVcoxJJRvmLJzyQs25ieIg==
X-Received: by 10.129.80.2 with SMTP id e2mr2759976ywb.198.1457039754466; Thu,
 03 Mar 2016 13:15:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.129.41.139 with HTTP; Thu, 3 Mar 2016 13:15:35 -0800 (PST)
In-Reply-To: <20160303210712.GA7692@rob-hp-laptop>
References: <1456507177-5502-1-git-send-email-joshua.henderson@microchip.com> <20160303210712.GA7692@rob-hp-laptop>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 3 Mar 2016 15:15:35 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL7Ez9uXFU1+9pRmpmXihffHyXFHMccJ3Zj9oTy9jQLVQ@mail.gmail.com>
Message-ID: <CAL_JsqL7Ez9uXFU1+9pRmpmXihffHyXFHMccJ3Zj9oTy9jQLVQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt/bindings: Add bindings for PIC32 watchdog peripheral
To:     Joshua Henderson <joshua.henderson@microchip.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52438
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Thu, Mar 3, 2016 at 3:07 PM, Rob Herring <robh@kernel.org> wrote:
> On Fri, Feb 26, 2016 at 10:19:27AM -0700, Joshua Henderson wrote:
>> Document the devicetree bindings for the watchdog peripheral found on
>> Microchip PIC32 SoC class devices.
>>
>> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
>> Cc: Ralf Baechle <ralf@linux-mips.org>
>> ---
>> Note: Please merge this patch series through the MIPS tree.
>
> Acked-by: Rob Herring <robh@kernel.org>

My mail to Joshua bounced, so I wouldn't merge until that is sorted:

<joshua.henderson@microchip.com>: host mx.microchip.com[198.175.253.14] said:
    550 Mailbox unavailable or access denied - <joshua.henderson@microchip.com>
    (in reply to RCPT TO command)

Rob
