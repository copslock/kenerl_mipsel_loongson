Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Sep 2014 11:50:42 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:37536 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008572AbaI2JulHYGL3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 29 Sep 2014 11:50:41 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id DC22228BE17;
        Mon, 29 Sep 2014 11:49:54 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-qc0-f171.google.com (mail-qc0-f171.google.com [209.85.216.171])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 61E3F28BEE0;
        Mon, 29 Sep 2014 11:49:49 +0200 (CEST)
Received: by mail-qc0-f171.google.com with SMTP id i17so1827680qcy.16
        for <multiple recipients>; Mon, 29 Sep 2014 02:50:30 -0700 (PDT)
X-Received: by 10.224.165.1 with SMTP id g1mr213244qay.97.1411984230742; Mon,
 29 Sep 2014 02:50:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.101.178 with HTTP; Mon, 29 Sep 2014 02:50:10 -0700 (PDT)
In-Reply-To: <1411929195-23775-4-git-send-email-ryazanov.s.a@gmail.com>
References: <1411929195-23775-1-git-send-email-ryazanov.s.a@gmail.com> <1411929195-23775-4-git-send-email-ryazanov.s.a@gmail.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Mon, 29 Sep 2014 11:50:10 +0200
Message-ID: <CAOiHx=nxZ+R6iiGiNJpDnOVieCgz5YH+i4WAuvb=gA6GNPTp9g@mail.gmail.com>
Subject: Re: [PATCH 03/16] MIPS: ar231x: add basic AR2315 SoC support
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42882
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On Sun, Sep 28, 2014 at 8:33 PM, Sergey Ryazanov <ryazanov.s.a@gmail.com> wrote:
> Add basic support for Atheros AR2315+ SoCs: registers definition file
> and initial setup code.

Same comment regarding the style of checking the SoC family as for patch 2.


Regards
Jonas
