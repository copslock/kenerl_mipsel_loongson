Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Apr 2015 18:52:16 +0200 (CEST)
Received: from mail-qc0-f172.google.com ([209.85.216.172]:33208 "EHLO
        mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025644AbbDQQwOG5oIl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Apr 2015 18:52:14 +0200
Received: by qcrf4 with SMTP id f4so27070775qcr.0
        for <linux-mips@linux-mips.org>; Fri, 17 Apr 2015 09:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=hQUPSrgtkNQ7sGGj0ZowGM8sUFxWlcToUZLBqqf2JHA=;
        b=AO84HO9aNKSCEpl8QEaAiEOWlk+cIrhjm9NqMxbQYYCKG8aIFze7yX8OuXDvOcse21
         zy8bf7bQ5vQUG+coXMYW8zktIXM6pZAR0Hav+zS4158lRKwktuitA84frXKlV3Lrc7aF
         QdJx7O+M88BWx4nUGwyowrj1/9ZXfuWvbymwrSkO+bzHj3jW6HmZyOGV1byNzRCdxpKq
         xjR/TO1BLvZYY3bW/WjdSTl4C+Ab0kjeMs2FuW0HupD0wmxE1v9gfB7A75hY1CBfjNch
         nRlIGy/3WQQD2xr1zuBt7k2PXlKPQpsoD7zJrzdnp7VGXdYgqqGHmRzz9v25Rfs7jHiA
         puBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=hQUPSrgtkNQ7sGGj0ZowGM8sUFxWlcToUZLBqqf2JHA=;
        b=Fm0M66CDh9SfRWyVPAixR4kztPBcBcm94nGAVlP0lqmw+yPW3HpUe+21kgHtGqgHKx
         u7/hopkenQ2o7OETBihk6+9F7bsIqpkLIAt+O6lKGc2LRiXq4rRgmWS5cwHZksHHIZgZ
         RNtSniF9mt+wz3xOf/1YY83zuaJZ6SRrsOKbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=hQUPSrgtkNQ7sGGj0ZowGM8sUFxWlcToUZLBqqf2JHA=;
        b=XBTs8CsK5jzjTkNSuSd5MxVpNnpX4TwtAQjVCB+PhDn6NConOwFA1gnig518OzSV/M
         xAOv8t/QjK/iz1UMyYboa1aWFegL38wU4RAw6+xCjsvVxRtdIcznTqq968zIt8M7MkM3
         1xtw7iRfWTWJWnRiUGyEH5aTaxmKiHRxbGNgW4128/tQpqZGzG3WRROcwslrMFmXp0Yv
         jE1gOanvW37hg1zj1QnugoJ5nSI//Dc/Y+y6sVLtNJ66MYMCb0QnY/2C7IUenYEnW4hF
         AgjnGudqC3Gs6gPZ1csn+nSOGRi9/pFK86/S4eJ7hWkZEwAZL5SczUd1Sv71DvrHD2IY
         r1uA==
X-Gm-Message-State: ALoCoQnYhcuWLY1IXpmGWFqbW2B1hWABKBL0D1bBoz9Dk/t5qDnJPiPM25sErCebFwGAp8QgVOJJ
MIME-Version: 1.0
X-Received: by 10.55.31.168 with SMTP id n40mr7616631qkh.56.1429289529962;
 Fri, 17 Apr 2015 09:52:09 -0700 (PDT)
Received: by 10.140.19.104 with HTTP; Fri, 17 Apr 2015 09:52:09 -0700 (PDT)
In-Reply-To: <1429263856-30471-3-git-send-email-james.hogan@imgtec.com>
References: <1429263856-30471-1-git-send-email-james.hogan@imgtec.com>
        <1429263856-30471-3-git-send-email-james.hogan@imgtec.com>
Date:   Fri, 17 Apr 2015 09:52:09 -0700
X-Google-Sender-Auth: acq_YIM8T8qamP8QLktIA1h2eNM
Message-ID: <CAL1qeaH_c7eK--7xdLwyWDQfO3QxTcXRD4kKD2VOj5qfo+6bQg@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: Pistachio: Support CDMM & Fast Debug Channel
From:   Andrew Bresticker <abrestic@chromium.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hartley <james.hartley@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

Hi James,

On Fri, Apr 17, 2015 at 2:44 AM, James Hogan <james.hogan@imgtec.com> wrote:
> Implement the mips_cdmm_phys_base() platform callback to provide a
> default Common Device Memory Map (CDMM) physical base address for the
> Pistachio SoC. This allows the CDMM in each VPE to be configured and
> probed for devices, such as the Fast Debug Channel (FDC).
>
> The physical address chosen is just below the default CPC address, which
> appears to also be unallocated.
>
> The FDC IRQ is also usable on Pistachio, and is routed through the GIC,
> so implement the get_c0_fdc_int() platform callback using
> gic_get_c0_fdc_int(), so the FDC driver doesn't have to fall back to
> polling.
>
> Signed-off-by: James Hogan <james.hogan@imgtec.com>

Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
