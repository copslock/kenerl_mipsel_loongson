Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 22:20:54 +0100 (CET)
Received: from mail-wi0-f170.google.com ([209.85.212.170]:60383 "EHLO
        mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013413AbaKLVUvGEmcc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 22:20:51 +0100
Received: by mail-wi0-f170.google.com with SMTP id r20so6262830wiv.3
        for <linux-mips@linux-mips.org>; Wed, 12 Nov 2014 13:20:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:subject:to:cc:in-reply-to:references
         :date:message-id;
        bh=bpF2LVw9a/eM0JSl2DA87CXDGZKMcGt3KMz96XNgWI0=;
        b=EFzPBGUQSKB0EkHBbgkoivM+y9AmbB0sChfdTiJqScmXh/gpBdioT4U58EYV4gp20+
         CRmXtUi252MZysBQ+xzIjyDcOXDsQuWeM+ixQPi6yuX8LXzVsDzmFlFN+pflDg/d8NZQ
         lkXriObaI/wMaQe8bE+iJAj3VzT1NShvtwhHbdElNhxqow7PIpA++Tw399E3GC+CNzeh
         iUfTDJggnOhVxCg8LW+MhNmw6gTSticPG6PwtcSCHDfUgrk6UD3W0aKbtTg9v6vpRg86
         lKsxYYxhahAKs361UzhzmeZJckTc3jCfDNLT+1018e0PqMTmbiHRaMXqEaD8Z1hV9AEC
         sJ+Q==
X-Gm-Message-State: ALoCoQkFBJ49+wzt5R4uK8TKtL5pGCrlAUyhSsBV+VKOyzsLVGu1yb9wsb/vO2QgU6m0tKtAylQx
X-Received: by 10.180.221.72 with SMTP id qc8mr192959wic.19.1415827245729;
        Wed, 12 Nov 2014 13:20:45 -0800 (PST)
Received: from trevor.secretlab.ca (host86-166-83-112.range86-166.btcentralplus.com. [86.166.83.112])
        by mx.google.com with ESMTPSA id jw2sm23118787wid.3.2014.11.12.13.20.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Nov 2014 13:20:44 -0800 (PST)
Received: by trevor.secretlab.ca (Postfix, from userid 1000)
        id 672A3C41CF4; Wed, 12 Nov 2014 17:12:09 +0000 (GMT)
From:   Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH 1/2] of: Fix crash if an earlycon driver is not found
To:     Rob Herring <robh@kernel.org>, Kevin Cernekee <cernekee@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxime Bizon <mbizon@freebox.fr>,
        Jonas Gorski <jogo@openwrt.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        stable@vger.kernel.org
In-Reply-To: <CAL_Jsq+iVfFGYEF575spQ5MaYPzo1QSfLUZP1M=TpH0+HdGS6A@mail.gmail.com>
References: <1415523348-4631-1-git-send-email-cernekee@gmail.com>
        <CAL_Jsq+iVfFGYEF575spQ5MaYPzo1QSfLUZP1M=TpH0+HdGS6A@mail.gmail.com>
Date:   Wed, 12 Nov 2014 17:12:09 +0000
Message-Id: <20141112171209.672A3C41CF4@trevor.secretlab.ca>
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44088
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@linaro.org
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

On Mon, 10 Nov 2014 08:14:01 -0600
, Rob Herring <robh@kernel.org>
 wrote:
> On Sun, Nov 9, 2014 at 2:55 AM, Kevin Cernekee <cernekee@gmail.com> wrote:
> > __earlycon_of_table_sentinel.compatible is a char[128], not a pointer, so
> > it will never be NULL.  Checking it against NULL causes the match loop to
> > run past the end of the array, and eventually match a bogus entry, under
> > the following conditions:
> >
> >  - Kernel command line specifies "earlycon" with no parameters
> >  - DT has a stdout-path pointing to a UART node
> >  - The UART driver doesn't use OF_EARLYCON_DECLARE (or maybe the console
> >    driver is compiled out)
> >
> > Fix this by checking to see if match->compatible is a non-empty string.
> >
> > Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> > Cc: <stable@vger.kernel.org> # 3.16+
> 
> Thanks. I'll queue this up.
> 
> BTW, you should not add stable CC when submitting for review, but
> rather add a note for the maintainer to apply to stable. Only if a
> commit is in mainline already and not flagged for stable, then you
> send the patch with the stable tag to get the commit added to stable.
> It's a bit confusing...


Oops, since you've picked it up I'll drop it from my tree. I'll let you
send the pull req to Linus.

g.
