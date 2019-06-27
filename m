Return-Path: <SRS0=H4b7=U2=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85230C4321A
	for <linux-mips@archiver.kernel.org>; Thu, 27 Jun 2019 22:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DCF0208E3
	for <linux-mips@archiver.kernel.org>; Thu, 27 Jun 2019 22:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQ895OV9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfF0W3o (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 27 Jun 2019 18:29:44 -0400
Received: from mail-yb1-f178.google.com ([209.85.219.178]:36134 "EHLO
        mail-yb1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbfF0W3n (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 27 Jun 2019 18:29:43 -0400
Received: by mail-yb1-f178.google.com with SMTP id e197so2437769ybb.3
        for <linux-mips@vger.kernel.org>; Thu, 27 Jun 2019 15:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G7aKWVoPQW5aboFA52Ik/8upoX4NWb/FP6JJmNoL4ts=;
        b=iQ895OV9zAj1Ynd7jHk303QKPCXVZjGOIRnC8swyxy8re9+fnvAms0xPBcPuAqat4E
         Yn7MkPxB3gGSp4+L4J/+B6Wsz6/FKS3ZulCjcL17N+6+INRCiV00MpMrme06pUhiebqf
         yiEqZn3ont87C0hhGHoJDRSlwzAAd5tyP4cumNeAV+MCycTIHgCHDSV/zL2zm2lZcdBA
         hgVuLOcVhTX60vm3fLKJMHpyqiVqRnv0r6Y2Uk2XM586lG8rM7AKxjq/xeegmWrACZyc
         Ll1W+5Z5+CX6bCxW3e3VPsoKla16zXgtGc4Ckc2O1Ki5f8D9/D2vj7SoQEClAo4xjbLx
         XcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G7aKWVoPQW5aboFA52Ik/8upoX4NWb/FP6JJmNoL4ts=;
        b=nQlU65qMXYoUTUbvpT6LfBS1YKU2FjiC/zq3/PLQfcoWMj3KKazBQL788G6vT8pBc1
         qKOSDodRfCG+tr8bLas7NWK4y9AfIQsDqNPa8zDqCoNbxGOpbCQGvJB3Jcl+Bfm4FvR2
         a+xXd0yHHW9WGHRRhBSLIs2zrZaji8KzgkhHKIFOmAowOqmChWkGkOmcYSa2jJ3rJlLC
         sDYin+5QOC4v5zGJdidj8j0qPlkvKZcfoAlVo+hF3Yu03C4qcIYv0hht1uAfBk5qRNw1
         sL6BbO2ehHAXDDcUdeC4ok0cd6tBUKOVunOs+UsLC//TM/7FR2z9KldW1lND6NllN94J
         58Hw==
X-Gm-Message-State: APjAAAUQkclGdYo8CcYnSdF9BpHjbRP/e+3e1byTTI+sDkZCx3sKuLev
        iszcbff45b4VRTvAN/sqf/QWzkXYRn2vVbJ8DXs=
X-Google-Smtp-Source: APXvYqy+YfK99W5z5Xf3abNuc8xaIHWhBThHc5oLRW1gukux+wVd9Qji4Rfze+YB+KbNqPR5/Jenw4l3C9kHtCboJ7E=
X-Received: by 2002:a25:8306:: with SMTP id s6mr4316443ybk.382.1561674582593;
 Thu, 27 Jun 2019 15:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <b201c33a-5beb-3dfb-b99b-d9b8fc6c2c64@hauke-m.de>
 <CA+QBN9A3JmvfCZkXZ2-Yd=nkQCQD48OgYEpe+Po4MuZFpmnPrQ@mail.gmail.com>
 <20190624175553.2tpepq5zsamovrra@pburton-laptop> <060345a6-bef2-ec17-e264-eccda29f5c8b@gentoo.org>
 <CAEdQ38F6gG1Ee5h6PXZ-wuxuOxAycaWBD_+hTNRjtfQHNw696g@mail.gmail.com>
In-Reply-To: <CAEdQ38F6gG1Ee5h6PXZ-wuxuOxAycaWBD_+hTNRjtfQHNw696g@mail.gmail.com>
From:   Carlo Pisani <carlojpisani@gmail.com>
Date:   Fri, 28 Jun 2019 00:29:21 +0200
Message-ID: <CA+QBN9DO9sAadwFU6kpAfBxZuTVEx8_9DUYFBs6fTA6==cVDwQ@mail.gmail.com>
Subject: Re: SGI-IP30
To:     Matt Turner <mattst88@gmail.com>
Cc:     Joshua Kinard <kumba@gentoo.org>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactcode.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

> Rene Rebe (cc'd) has a YouTube channel [0] where he posts interesting
> videos about old hardware, including the Octane

it's based on kernel 4.12, I have tried it, and it doesn't add
anything to the Gentoo kernel + patches. Perhaps some improvements on
the GFX. I have recently asked exactly *what* his patches do improve,
no reply.

This request is for understanding if/where my team has to be focused
on testing since there are too many things to care about. E.g. PCI?
SMP? R14k stability? etc
