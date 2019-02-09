Return-Path: <SRS0=Wred=QQ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98ABCC282C4
	for <linux-mips@archiver.kernel.org>; Sat,  9 Feb 2019 20:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 559532192C
	for <linux-mips@archiver.kernel.org>; Sat,  9 Feb 2019 20:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OpskMWYl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfBIUHG (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 9 Feb 2019 15:07:06 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38085 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfBIUHG (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sat, 9 Feb 2019 15:07:06 -0500
Received: by mail-lf1-f66.google.com with SMTP id n15so857811lfe.5
        for <linux-mips@vger.kernel.org>; Sat, 09 Feb 2019 12:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8vb4C3aX8zjyQE4WmbsbWFOJ/c/oqkCYyt4SzWNfLt0=;
        b=OpskMWYlxvW6LfngtaOgcHi9FtqlJJx1fUXPcLWAsGaPcPyWjMyHUHm5SUxjUF5YNr
         oOTpOHP+mNiuKQUam1dmF+MUfnXHPgeiut56cGPOWSIQW1jo6rRkuvh5VbQDZ5svSwaJ
         JF3VlOGW/M57adagskBpeX1auLMGoaVrE7HT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8vb4C3aX8zjyQE4WmbsbWFOJ/c/oqkCYyt4SzWNfLt0=;
        b=n4ngYKKibeolR590XxRefG6nxu6O7B7OinwgoivxGpevveoyM/YXONbuLfVOD/HP7u
         3YuKx6bYiApjAY+69xA451Vdle/kWqyTPWWhBgCQ/yQ0LNVRO9i7ia4a/T48a1nMzeSa
         1eRIc2blMrcp3Pz8r8U520YsEiEcUtpDrjHVayxsTegqM8X4v3+TlIjWZ4X2JKfHpA98
         mIpBv3kGcUo2dvWI0f9+dXtd/+fGDq5gHIAgUpxZGaXwb25mYDVJ+CAGpZjKcpv9Eqw2
         ul2D8aVG8kJuzTMClImmHEikLoM65A7rxWhjp4D05k8dMbvJrLeQdrzFCTpCm9/6mH07
         5VYQ==
X-Gm-Message-State: AHQUAuZ+PJDjYK3ofw30Nps1+eUpAVv2GZ3nbV6yuyw5A/lW1Kl+lrlT
        UU9mJLgqG4tBmRCtyHvKpRMClfPYC78=
X-Google-Smtp-Source: AHgI3IZH9xamnNiSJ2HrCTqaxKRoUcYtPaeYdqvRXlhxYp2GOPorKU2+KkRVdHyS4X1AiVGs2K7Xxw==
X-Received: by 2002:a19:9813:: with SMTP id a19mr17389816lfe.103.1549742824208;
        Sat, 09 Feb 2019 12:07:04 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id i127-v6sm1193196lji.67.2019.02.09.12.07.02
        for <linux-mips@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 12:07:03 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id l10so4955803lfh.9
        for <linux-mips@vger.kernel.org>; Sat, 09 Feb 2019 12:07:02 -0800 (PST)
X-Received: by 2002:ac2:4191:: with SMTP id z17mr17205855lfh.117.1549742822546;
 Sat, 09 Feb 2019 12:07:02 -0800 (PST)
MIME-Version: 1.0
References: <20190209194718.1294-1-paul.burton@mips.com>
In-Reply-To: <20190209194718.1294-1-paul.burton@mips.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 9 Feb 2019 12:06:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgnfMwrP-KRGKW76uE1jBdDae6auRMke+tFmz5shvkvYA@mail.gmail.com>
Message-ID: <CAHk-=wgnfMwrP-KRGKW76uE1jBdDae6auRMke+tFmz5shvkvYA@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Fix access_ok() for the last byte of user space
To:     Paul Burton <paul.burton@mips.com>
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Sat, Feb 9, 2019 at 11:47 AM Paul Burton <paul.burton@mips.com> wrote:
>
> Fix MIPS in the same way as alpha & SH, by subtracting one from the addr
> + size condition when size is non-zero. With this the access_ok() calls
> above return 1 indicating that the access may be valid.

You might want to update the comment above that thing too..

            Linus
