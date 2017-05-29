Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 May 2017 18:40:31 +0200 (CEST)
Received: from mail-it0-x22a.google.com ([IPv6:2607:f8b0:4001:c0b::22a]:35524
        "EHLO mail-it0-x22a.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993950AbdE2QkX0e1bn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 May 2017 18:40:23 +0200
Received: by mail-it0-x22a.google.com with SMTP id c15so29359154ith.0;
        Mon, 29 May 2017 09:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=KRNe3UjYyEylHEADpYPhBOlUBRcnrhdTCUxdwdiPcoY=;
        b=ahGIRpmhjlqRgxXR0t0MMfPboHW9gmyCoOu3KNsZmykrUbckcLbBHxwVhFYSQp8atM
         PMAagNOkraGkKUaxAq00E0VXrsfG5vvq7xdYYxU1xIriUzL7Oi9ZMfG9OGATs6qy4IA7
         BbeNnzCGvAaKPAb5wBEqd1K+mSGJqkTJpmCAJlSEDmHc80TbIYAi6w2rToyG96kcbC2L
         pMFDe+gJLMLzfIwNSCL/6PRsixm4+2Ic5Xwn5tbWsQqzJgfsZ3ma7URTYNe2XOz0L9pi
         T0C0RpyhKc0JXlxNYDad/C0qwPsH3+4qhJ7SGbranZqdS95VLcJdR0Hvi3xXFloVgH7e
         AYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=KRNe3UjYyEylHEADpYPhBOlUBRcnrhdTCUxdwdiPcoY=;
        b=WDquuLVFeAbXunho83J7xDpIHbmYdpg6DzVAIKyhZKdnuT7E5MAAtC/ZGhDZfvi6fm
         9WAIsTIZcA38QzaO06JtOnv7QDU5FJ8pPnrMKp3h7y9gna+N9Xmk20UBU9JQWDlPqx0k
         nhavQsI2eK4icss4LrHI9g1OMtETZVGAQ54xIKupD7Hk0VZ5ZTOuywcqSHYgVzZE65r+
         o+66o+BerzRvvQmskZhx2yXyWO6rKkl/ps+KedSpAJ2YSf0y1Yd+Q47Nm6m1+bU6C//e
         LvIH/5YdsDUj8jSASEOL6tQQI0NC4aemEsc2BgBx8+U0jf66djmPm1aD8lx0cIyJRXuY
         zXgg==
X-Gm-Message-State: AODbwcCG4D3g7xcAqiH8apZ4YLjwTY/M2Ri4EAPJI23cGbPnP8Ph+yJO
        SeyGRkQ7p+grLzlu6BnOIq/ypAHd8Q==
X-Received: by 10.36.26.18 with SMTP id 18mr14115647iti.103.1496076017641;
 Mon, 29 May 2017 09:40:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.168.65 with HTTP; Mon, 29 May 2017 09:40:16 -0700 (PDT)
In-Reply-To: <20170529072207.16130-1-vegard.nossum@oracle.com>
References: <20170529072207.16130-1-vegard.nossum@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 May 2017 09:40:16 -0700
X-Google-Sender-Auth: O6Z-HNBUNJntF1oKFElVzN3TPz4
Message-ID: <CA+55aFw4AmyMDbquM9Lm2yGT0pM07386ykLzdaO2X5zyMSSb3Q@mail.gmail.com>
Subject: Re: [PATCH] kthread: fix boot hang (regression) on MIPS/OpenRISC
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Stafford Horne <shorne@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org, Oleg Nesterov <oleg@redhat.com>,
        Jamie Iles <jamie.iles@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <linus971@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58070
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

On Mon, May 29, 2017 at 12:22 AM, Vegard Nossum
<vegard.nossum@oracle.com> wrote:
> This fixes a regression in commit 4d6501dce079 where I didn't notice
> that MIPS and OpenRISC were reinitialising p->{set,clear}_child_tid to
> NULL after our initialisation in copy_process().

Ok, I'll just take this directly, since it's such an odd set of architectures.

I guess it could come in through the next "misc fixes" pull request
from the -tip tree (which is where the change that broke this came
from), but ..

             Linus
