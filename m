Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2016 00:12:12 +0200 (CEST)
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35513 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27033324AbcEWWMKabo2f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 May 2016 00:12:10 +0200
Received: by mail-pf0-f193.google.com with SMTP id f144so5029066pfa.2
        for <linux-mips@linux-mips.org>; Mon, 23 May 2016 15:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gimpelevich-san-francisco-ca-us.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ySrvE2zwvqNNsSW5VytG5NLHfHqiZ1q6L+VSa9Cq5MA=;
        b=j6QhOypwNPpT3AavqyKX4x4PtxujdxXOst8Byhisp/gP3Dw0m3mBWTl7j0RiDGd5Tz
         nO5P59xqI21n2vZa6geOCyRtabuJ9sN9Rt+hAosjizLgJfum9wINESE3atQrVCTLxqvX
         DRP6K1stXg0mTHxQvc0w4meNHWJBPuxURQ/Zlp4nBhN0bTzu5B8t7MoMzlJ3fk9mQkD0
         fXblpLyGbvO2SROswF8ZsWQm7cdROSaXpYIzpdx6paT2xCi8YYTcSD1J0Zocp31FT8YD
         5cbZRQdBYRW+CqwUdvkbm2z8deONhgJKhSL5Uip3UQ8EKeV1Lrjb7L9xRBl7v7zliRrg
         kZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ySrvE2zwvqNNsSW5VytG5NLHfHqiZ1q6L+VSa9Cq5MA=;
        b=FTLGCAEy18u6UEo/AVSgo6lZmSww2ACapNqOc0BafAopO5ipw9FTLMZVrKMFHS6bfN
         w2ehRyJNDn+4OMCx913+TxRpTjaceeWz2RELAZu4TbSgqwTmTqB1dCd8/M3tIDIwxVYd
         WnLGxkfGgW81nqLK+yo1QLiQorcvjNvo5Qm3lW6kZ3VSOMH5eeaNFo1eGBSsligKnT4w
         PmMezCixUxz83EYa6AcYc421E2r5NY34OtR7UtHBBprKTtZuD851rSd/r4c6i9Tyx2Qg
         mbSuwGIYt5ADhysdThCE3wz9a8pS0ZwnN3xyHugaE4EE8FN5K/pECpCuHrMn5y3/BPZq
         oMwQ==
X-Gm-Message-State: ALyK8tJCrmFx0IXnNS/+KZ38ZL0490U434307VvjQS3dS41kWJsmtYTzzuhy1f7BjGC1fw==
X-Received: by 10.98.78.199 with SMTP id c190mr1633953pfb.7.1464041524136;
        Mon, 23 May 2016 15:12:04 -0700 (PDT)
Received: from ?IPv6:2601:645:c200:33:f988:b006:b1e6:ee57? ([2601:645:c200:33:f988:b006:b1e6:ee57])
        by smtp.gmail.com with ESMTPSA id k71sm76130pfb.50.2016.05.23.15.12.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 May 2016 15:12:03 -0700 (PDT)
Message-ID: <1464041521.5475.18.camel@chimera>
Subject: Re: Adding support for device tree and command line
From:   Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linux-mips@linux-mips.org, Jonas Gorski <jogo@openwrt.org>,
        Mathias Kresin <openwrt@kresin.me>
Date:   Mon, 23 May 2016 15:12:01 -0700
In-Reply-To: <5743777F.9060801@hauke-m.de>
References: <574372CD.1060201@hauke-m.de> <5743777F.9060801@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <daniel@gimpelevich.san-francisco.ca.us>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53629
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@gimpelevich.san-francisco.ca.us
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

On Mon, 2016-05-23 at 23:34 +0200, Hauke Mehrtens wrote:
> On 05/23/2016 11:14 PM, Hauke Mehrtens wrote:
> > Section 3 of this document defines some interfaces how a boot loader
> > could forward a command line *or* a device tree to the kernel:
> > http://wiki.prplfoundation.org/w/images/4/42/UHI_Reference_Manual.pdf
> > This allows only a device tree *or* a command line, not both.
> > 
> > The Linux kernel also supports an appended device tree. In this case the
> > early code overwrites the fw_args to look like the boot loader added a
> > device tree. This is done when CONFIG_MIPS_RAW_APPENDED_DTB is activated.
> > 
> > The problem is when we use an appended device tree and the boot loader
> > adds some important information in the kernel command line. In this case
> > the command line gets overwritten and we do not get this information.
> > This is the case for some lantiq devices were the boot loader provides
> > the mac address to the kernel via the kernel command line.
> > 
> > My proposal to solve this problem is to extend the interface and add a
> > option to provide the kernel command line *and* a device tree from the
> > boot loader to the kernel.
> > 
> > a) use fw_arg0 ($a0) = -2 and fill the unused registers fw_arg2 ($a2)
> > and fw_arg3 ($a3) with argv and envp.
> > 
> > b) add a new boot protocol $a0 = -3 with $a1 = DT address, $a2 = argv
> > and $a3 = envp.
> 
> I just looked a little bit more closely and saw that the command line
> uses 3 args. One for the count, one argv and one envp.
> 
> I would then only support device tree + count and argv, so the new
> interface would not support envp.
> 
> > 
> > I would prefer solution b).
> > 
> > This way we would not loose the kernel command line when appending a
> > device tree and this could also be used by the boot loader if someone
> > wants to.
> > 
> > Should I send a patch for this?
> > 
> > Hauke

It was because I looked through the above-linked UHI spec that I became
concerned about CONFIG_MIPS_RAW_APPENDED_DTB only mimicking, rather than
fully implementing, real UHI. In the upstream kernel, the new $a0 == -2
code can be a starting point for adding UHI argv/envp parsing for when a
UHI-compliant bootloader is used. However, on the head.S side, what I
propose for the lantiq target is to remove CONFIG_MIPS_RAW_APPENDED_DTB
from the kernel config, and reintroduce this as a platform patch:
https://github.com/openwrt/openwrt/blob/b3158f781f24ac2ec1c0da86479bfc156c52c80b/target/linux/lantiq/patches-4.4/0036-owrt-generic-dtb-image-hack.patch
The brcm63xx target could then retain CONFIG_MIPS_RAW_APPENDED_DTB, or
not, depending on bootloader specifics there, which I have not
investigated, and likewise the various other targets to which
CONFIG_MIPS_RAW_APPENDED_DTB has since been extended even though it was
apparently initially only an expedient hack only for brcm63xx.

Using $a0 = -3 is expressly prohibited in the above UHI document, and
using $a2/$a3 "would risk becoming incompatible with existing UHI
compliant implementations."
