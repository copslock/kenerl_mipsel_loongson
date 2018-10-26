Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Oct 2018 23:44:53 +0200 (CEST)
Received: from mail-lj1-x22c.google.com ([IPv6:2a00:1450:4864:20::22c]:38848
        "EHLO mail-lj1-x22c.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993070AbeJZVouY1lZ4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Oct 2018 23:44:50 +0200
Received: by mail-lj1-x22c.google.com with SMTP id k11-v6so2474990lja.5
        for <linux-mips@linux-mips.org>; Fri, 26 Oct 2018 14:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/6uaXpECa/aYnHF17c8/9fNocsDR31Q2sd0EegIMyKU=;
        b=KDI6mgWw0Zys95ATOut3in3zBv5v/22byfRqSZJdG4yv5BjscsTFUch5uqYxUEYxV4
         Auqe/jlCq1ftiVJR3qgii9FMJKcPEKic967JTkMzU8Pjcy2bwDgp7l4H+CTP7kf6sHaT
         Uw5g64rUk+BqWWjyVmSx17CK8MzDciSrF9ZSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/6uaXpECa/aYnHF17c8/9fNocsDR31Q2sd0EegIMyKU=;
        b=VlmqMvdw/MU3Lxgz+I5e9ZuUSS0bCHyO8x0SULV6k8jqdONliowEv9Vpdw1OSNif9L
         MCrepfUxB9mLoQuYuRlbALfQg+tBpIxp7Ve7xN2546ujKarD4IyvluKMlFmL+0dSRlHk
         kHdspzPdKgQUZ0iMEmMiASnQkyWAEKnWeL5OCaz1RYAO/S59ywRjcO651EBmEQ4Ov1uJ
         rXNsAntJwftoX/iRuST7u78pF3hXFWWx+wDAnqM4yy8jj6zH7H7K2z0Qew6Xva2sXB5f
         HyQPjEtI5A5NmmW9uZjoJw7PqwM+CesdGrefQGp9BMKLJyYhXGW24R6e64+IfzHCzECH
         J2pw==
X-Gm-Message-State: AGRZ1gKRk7hLl9eD3/qMobGCwHrO+XtHDeEv7hEOM/ggOq6oJafXrxU+
        hxc+/3N3BItiyDilIcn2OB9yCGlfdd+o6Q==
X-Google-Smtp-Source: AJdET5cx9+P0ES3DYRPufs6Nmi6s/lSZsBS+lwDN3TUyZKIPnJkqGuym9gC+2dJY4o3CpIitoRIzrA==
X-Received: by 2002:a2e:4408:: with SMTP id r8-v6mr3803223lja.21.1540590284442;
        Fri, 26 Oct 2018 14:44:44 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id a8-v6sm1702695ljd.6.2018.10.26.14.44.43
        for <linux-mips@linux-mips.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 14:44:44 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id c4-v6so2472163lja.4
        for <linux-mips@linux-mips.org>; Fri, 26 Oct 2018 14:44:43 -0700 (PDT)
X-Received: by 2002:a2e:9d89:: with SMTP id c9-v6mr3165653ljj.120.1540590282826;
 Fri, 26 Oct 2018 14:44:42 -0700 (PDT)
MIME-Version: 1.0
References: <20181026190756.fqk2ozm2ruhmwwex@pburton-laptop>
In-Reply-To: <20181026190756.fqk2ozm2ruhmwwex@pburton-laptop>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Oct 2018 14:44:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgbDdxdHmnBMamB7hFbaWqz41XArmgebamuEwhSGupY7w@mail.gmail.com>
Message-ID: <CAHk-=wgbDdxdHmnBMamB7hFbaWqz41XArmgebamuEwhSGupY7w@mail.gmail.com>
Subject: Re: [GIT PULL] MIPS changes for 4.20
To:     paul.burton@mips.com
Cc:     jhogan@kernel.org, ralf@linux-mips.org, linux-mips@linux-mips.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <torvalds@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66962
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: torvalds@linux-foundation.org
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

On Fri, Oct 26, 2018 at 12:08 PM Paul Burton <paul.burton@mips.com> wrote:
>
> Here are the main MIPS changes for 4.20. Please pull.

Pulled (along with the fixes pull request),

                   Linus
