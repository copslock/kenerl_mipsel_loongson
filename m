Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Apr 2015 09:24:27 +0200 (CEST)
Received: from mail-wi0-f174.google.com ([209.85.212.174]:32893 "EHLO
        mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008877AbbDRHYZPkpUi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 18 Apr 2015 09:24:25 +0200
Received: by wiax7 with SMTP id x7so47671514wia.0
        for <linux-mips@linux-mips.org>; Sat, 18 Apr 2015 00:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=+p6HHmBnXAhyICOrJGkJpgIxRwqtl4QD/UElLb1v4w4=;
        b=MCW7pUpqxjsG1QejSCYqLpKFKWCuKwb0jYAWDjDSVFNlGYurzAU9BVRQvYE/bMhzV5
         rMvERLDrD5s8MxOjLA0p5hk30UX2hVH4ixPlkGKRmqPiPWXd6fKC0prGQ4YU++TmE8o0
         M9iHmj/glIeE+IrUnkfGTi5vFQm2ge5WAlq/4h0E+KI7bNO2axfljGi/4lU3mnFGq5EL
         sKUOZllyuq/lw6i6TR9wI9LvwHg/WjEkRdei505kaTG/gtbsJ3Shbnc88PbgdBxmKVvf
         MNWZJROUoOZI2daP9RoOLOQKEhmR0EjHGHpQDuRXgLuzlRtu7XJf8Y6WDnaAsnDxdx2U
         1A7Q==
X-Gm-Message-State: ALoCoQl4kuh1pU9lDiG5hFaa//K/nYe+paJihCqQps8YssbLXLqQoITLjX5tV/cQCBRwDO9Ia93f
X-Received: by 10.180.188.193 with SMTP id gc1mr7519628wic.7.1429341861568;
        Sat, 18 Apr 2015 00:24:21 -0700 (PDT)
Received: from gollum.lan (jahogan.plus.com. [212.159.75.221])
        by mx.google.com with ESMTPSA id kr5sm17776194wjc.1.2015.04.18.00.24.19
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 18 Apr 2015 00:24:20 -0700 (PDT)
In-Reply-To: <CAL1qeaH_c7eK--7xdLwyWDQfO3QxTcXRD4kKD2VOj5qfo+6bQg@mail.gmail.com>
References: <1429263856-30471-1-git-send-email-james.hogan@imgtec.com> <1429263856-30471-3-git-send-email-james.hogan@imgtec.com> <CAL1qeaH_c7eK--7xdLwyWDQfO3QxTcXRD4kKD2VOj5qfo+6bQg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 2/2] MIPS: Pistachio: Support CDMM & Fast Debug Channel
From:   James Hogan <james.hogan@imgtec.com>
Date:   Sat, 18 Apr 2015 08:24:16 +0100
To:     Andrew Bresticker <abrestic@chromium.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hartley <james.hartley@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Message-ID: <00480F21-6FA8-49FD-868E-F4ED7FBD6935@imgtec.com>
Return-Path: <james@albanarts.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46905
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

On 17 April 2015 17:52:09 BST, Andrew Bresticker <abrestic@chromium.org> wrote:
>Hi James,
>
>On Fri, Apr 17, 2015 at 2:44 AM, James Hogan <james.hogan@imgtec.com>
>wrote:
>> Implement the mips_cdmm_phys_base() platform callback to provide a
>> default Common Device Memory Map (CDMM) physical base address for the
>> Pistachio SoC. This allows the CDMM in each VPE to be configured and
>> probed for devices, such as the Fast Debug Channel (FDC).
>>
>> The physical address chosen is just below the default CPC address,
>which
>> appears to also be unallocated.
>>
>> The FDC IRQ is also usable on Pistachio, and is routed through the
>GIC,
>> so implement the get_c0_fdc_int() platform callback using
>> gic_get_c0_fdc_int(), so the FDC driver doesn't have to fall back to
>> polling.
>>
>> Signed-off-by: James Hogan <james.hogan@imgtec.com>
>
>Reviewed-by: Andrew Bresticker <abrestic@chromium.org>


Thanks for the reviews Andrew.

Cheers
James
