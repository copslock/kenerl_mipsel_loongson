Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Nov 2018 23:25:09 +0100 (CET)
Received: from mail-lj1-x243.google.com ([IPv6:2a00:1450:4864:20::243]:44129
        "EHLO mail-lj1-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990406AbeKIWZGdoFry (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Nov 2018 23:25:06 +0100
Received: by mail-lj1-x243.google.com with SMTP id k19-v6so2876066lji.11
        for <linux-mips@linux-mips.org>; Fri, 09 Nov 2018 14:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TzEdo8JsgxJCcekWTN9wAAWCa6iOvL0SIegP7qF/U9o=;
        b=YeoZZLrJ+P4wIWi1P1kScvcO4nD9aO+W4A9SJHrzLGrymXCC92uNM7v3/vRh67oROq
         TJCdWaSIj2DhpMvf4602IZYu9JQCaR1aZ78q2akNugM5RR6Hd7C7YobQUbE0WiR/VILP
         IgUiOXO3LCyXbIGZfP/Jj16Q5SJKDjdD6xlqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TzEdo8JsgxJCcekWTN9wAAWCa6iOvL0SIegP7qF/U9o=;
        b=RQ5mLFsdFwX+jAy36PynoT/iHOlbfSD9Xb63P/okCW95EwimSERvcVsGJup/V1y+Ha
         0AnKyUxaLCcZYyVd1Yzo2HPNY1l0mXMDRbhj495YWM2p3KNy3zme4o2ja6NG1moQRx6U
         Arc0upkQYKqYjW9Cg9hvKAL6+lTDQdv+chFPCr8aqB7h3snB02ZSO6NF90aNY8nFgd7L
         B6g0yV5LhgwVKmfW2HVlmJ58Fjs8N2aFh8b/vobnI7HVK9d/o1QqYoY3khz3ZUIxfe/o
         S2xmy5wo/A4J10ufSENgLnKhJGm3H6UZBmDThDh+iAODzEt6R8r5g6B6Ux6GVNNNhKYk
         vHFg==
X-Gm-Message-State: AGRZ1gLz8eiy0+zCcIpfMVyGzSqKFW8oRabICXV1UV1X/8fZx2dta76k
        xVUiJiNHbByqxrL5SoQWx2e1+9OIg28=
X-Google-Smtp-Source: AJdET5dVU8bnHTJG5lWuA5I++DWphuzSpw01yLMLTgopIHxIgKeu1oztg4gcVe8+vNn2RWQ/XnPIiA==
X-Received: by 2002:a2e:98c9:: with SMTP id s9-v6mr1672328ljj.166.1541802305483;
        Fri, 09 Nov 2018 14:25:05 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id r27-v6sm1716303lja.65.2018.11.09.14.25.04
        for <linux-mips@linux-mips.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 14:25:04 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id e5-v6so2908351lja.4
        for <linux-mips@linux-mips.org>; Fri, 09 Nov 2018 14:25:04 -0800 (PST)
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr7248377lji.133.1541802303958;
 Fri, 09 Nov 2018 14:25:03 -0800 (PST)
MIME-Version: 1.0
References: <20181109185053.p4hy6whjtdj3gq4o@pburton-laptop>
In-Reply-To: <20181109185053.p4hy6whjtdj3gq4o@pburton-laptop>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 9 Nov 2018 16:24:48 -0600
X-Gmail-Original-Message-ID: <CAHk-=wgyGKdXbp6oU7ULc3QPYrVb61A_rRzDmhEXwNCFk14CRQ@mail.gmail.com>
Message-ID: <CAHk-=wgyGKdXbp6oU7ULc3QPYrVb61A_rRzDmhEXwNCFk14CRQ@mail.gmail.com>
Subject: Re: [GIT PULL] MIPS fixes for v4.20-rc2
To:     paul.burton@mips.com
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org, jhogan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <torvalds@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67214
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

On Fri, Nov 9, 2018 at 12:51 PM Paul Burton <paul.burton@mips.com> wrote:
>
> Here are a couple of small MIPS fixes for 4.20 - please pull.

This is a "I pulled", but if you cc linux-kernel, you should now be
getting those messages automatically when I push out.  I will be
stopping my manual pull acks because of the automation. So if you care
about it, start cc'ing linux-kernel too.

[ Maybe linux-mips is being archived by lore.kernel.org too and gets
that automation too, but I don't think that's the case currently. I
might be wrong ]

           Linus
