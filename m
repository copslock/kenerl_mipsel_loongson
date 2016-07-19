Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jul 2016 23:19:57 +0200 (CEST)
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38530 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993200AbcGSVTtrOGoQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jul 2016 23:19:49 +0200
Received: by mail-wm0-f49.google.com with SMTP id o80so42044325wme.1
        for <linux-mips@linux-mips.org>; Tue, 19 Jul 2016 14:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KKUdQIqaU5nhXObYV3siChNfxeePXhtso337VQmsPI8=;
        b=kYjVNZ2f5Uq6m+7B3Cyw0IrgDMdLvvYCumSX2Lbny4oDrNbJxnHsg/g67cexI7C2EK
         tr00M/xZWN0JX5TtQgBhmVszEkZF5S7mh98kbRpNOKGGfakH2mm8NsbEsiNkQB/cE6GC
         TKYkuysD0rwT3BIinLaLXIYF8c6ZkzLWFlFD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KKUdQIqaU5nhXObYV3siChNfxeePXhtso337VQmsPI8=;
        b=XoIIB8A6VipDv0MNKxWnSwygExYjVU209S9BVe6tbEGBFm1ztRj6m868FAI+BYajn5
         NFWpG8WY+e88ZEVOIYBS7xRW4mzC/CXlBTnvAkNqT3v06PdBj3mKtcuOxOMSTfdyeM73
         tOQTpTi3gUNZpGkGuLQK4rlKm8aTkWPd/NSCWpQIHumiJlWkMMzr+tdjCzu7LqLzKLWl
         Q2J8D9e7fVG+L1eX0OMJi8XFUAEaNjCQgz4nRh0FZS7+cbCGUp/IZvkjwy3V90S8QUNk
         /xFZk2BvTJ8/Sa/qaiaS/TkATuV5dcq99zkwdHjDtUarnCuuapDxeealUlMrPzE/BFNp
         bbqA==
X-Gm-Message-State: ALyK8tIRfwErEJimO543bxlrhnr8++x+k62wlhEH7/mwMx4VRO/KcIzfdoMT6qOeUOOJQb/AGjXkNV58KxBKBkjs
X-Received: by 10.28.167.80 with SMTP id q77mr7132311wme.62.1468963184343;
 Tue, 19 Jul 2016 14:19:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.25.233 with HTTP; Tue, 19 Jul 2016 14:19:43 -0700 (PDT)
In-Reply-To: <578E71E6.2020700@caviumnetworks.com>
References: <57853474.9050108@cavium.com> <578E71E6.2020700@caviumnetworks.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 19 Jul 2016 23:19:43 +0200
Message-ID: <CAPDyKFqb-7LLM0XPtVWj1qHib991E2dHt+6W0UPgbXnukGkmXA@mail.gmail.com>
Subject: Re: [PATCH V8 2/2] mmc: OCTEON: Add host driver for OCTEON MMC controller.
To:     "Steven J. Hill" <Steven.Hill@caviumnetworks.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-mips@linux-mips.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <ulf.hansson@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54349
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ulf.hansson@linaro.org
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

On 19 July 2016 at 20:31, Steven J. Hill <Steven.Hill@caviumnetworks.com> wrote:
> On 07/12/2016 01:18 PM, Steven J. Hill wrote:
>>
>> The OCTEON MMC controller is currently found on cn61XX and cn71XX
>> devices. Device parameters are configured from device tree data.
>> eMMC, MMC and SD devices are supported. Tested on Rhino labs UTM8
>> and Cavium CN7130 board.
>>
>> Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
>> Acked-by: David Daney <david.daney@cavium.com>
>>
> Has anyone reviewed the driver or have any comments? Thanks.

Sorry I need more time, been partly out of office lately.
I intend to review this prior rc1 is out, but no promises.

Kind regards
Uffe
