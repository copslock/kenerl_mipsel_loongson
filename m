Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Dec 2017 11:12:28 +0100 (CET)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:40166
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990412AbdL2KMWZlb2f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Dec 2017 11:12:22 +0100
Received: by mail-wm0-x241.google.com with SMTP id f206so47275022wmf.5
        for <linux-mips@linux-mips.org>; Fri, 29 Dec 2017 02:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OZDKQObnogCo43/g0ZefdMeItSxZ/d1jpfe8RdFWxFc=;
        b=A1dyY1BvC81xdajAaWe5z6Iod6eMrkXkCitK1deR7L6htbFsYIvEK/HdbyI6HodMKZ
         sbn5FwmNuHKzpKbfV0hH/O4ObLYRlUQjxosVGUMMRq+StM8KaucLTwmd/4eTI8pnosCv
         O3z7n7OvBMWKS2DppdyEiK6rhNS3qNU3z4kP+t+auEYs9M5Oqcvwo0I9k2DLfbmwV//2
         sqWGOCudUxtlua44JMnRNsk4xFZpM6Z6ZB/tpbniEd9ha1qDcOzmTs6+yJEzuBtzqHIY
         GImtxUK4KKmUt+oISe07ZXBZePl0GTQ8J+nT/kInjx2jj+fmacU+mE4gKOSjW5l8Z0H0
         ri6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OZDKQObnogCo43/g0ZefdMeItSxZ/d1jpfe8RdFWxFc=;
        b=V0ybGVnFAyUQHlHJmC/hdqqSju0WSBFmKNp8sXHOWzQ7mfVnXRC0vDkF2bUF8mKKd5
         j57HilkP/HdxogHIUl24NTEaq+wFWZgKQ+pubSRn70alp+aNDn/CIkPLSkeWKvfQFnYJ
         I6jYnxREXIppjMzlEuk7/q+qgNcBpRgJ+jAV+j0/wkXvEQg0jMmAXwhMNNrscUhBWzkV
         nFB9TT0gIpEK5YNlXkeHfsw0R+jT1oYFM9YtNhGbXCbpWkdemmoGj8b22IF/N6eP3WyD
         6NdCNLws6x/rkPGLfEfmdgh4bvaCm7BzuQaNEz06iXNenfRV1TXo5/dYPgyKD2utDunK
         DFKw==
X-Gm-Message-State: AKGB3mJLqmM0CrQ3oBANutyC3h7NexZyjBLqduPJBdvN22Rs8CZ80SuY
        cOHQvft2PvWDIMhkhlpgosTyxeIRq3iKMgXLj+s=
X-Google-Smtp-Source: ACJfBosLJCIjjyZdEo2TG9SRtMNEVoq6KpqimhlUTIaKQq3elGsw6/PWwHHbb6+Xm8+4TOM09Ngu876BshXxDLd1Gw0=
X-Received: by 10.28.46.136 with SMTP id u130mr30846598wmu.127.1514542336990;
 Fri, 29 Dec 2017 02:12:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.153.163 with HTTP; Fri, 29 Dec 2017 02:11:56 -0800 (PST)
In-Reply-To: <20171229081911.2802-18-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de> <20171229081911.2802-18-hch@lst.de>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Fri, 29 Dec 2017 21:11:56 +1100
Message-ID: <CAGRGNgW1qwLcCAvU2Jc=3_7b-0Bu016to3cQUgVsc+ca0No_6g@mail.gmail.com>
Subject: Re: [PATCH 17/67] microblaze: rename dma_direct to dma_microblaze
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        patches@groups.riscv.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org,
        linux-arch@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <julian.calaby@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61765
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: julian.calaby@gmail.com
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

Hi Christoph,

On Fri, Dec 29, 2017 at 7:18 PM, Christoph Hellwig <hch@lst.de> wrote:
> This frees the dma_direct_* namespace for a generic implementation.

Don't you mean "dma_nommu" not "dma_microblaze" in the subject line?

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
