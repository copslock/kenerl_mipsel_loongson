Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Sep 2014 11:36:08 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:37011 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008572AbaI2JgGgHQbF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 29 Sep 2014 11:36:06 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 342B028BF2C;
        Mon, 29 Sep 2014 11:35:22 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-qg0-f48.google.com (mail-qg0-f48.google.com [209.85.192.48])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 0B63128BE17;
        Mon, 29 Sep 2014 11:35:19 +0200 (CEST)
Received: by mail-qg0-f48.google.com with SMTP id i50so1476917qgf.35
        for <multiple recipients>; Mon, 29 Sep 2014 02:36:01 -0700 (PDT)
X-Received: by 10.224.37.69 with SMTP id w5mr29038394qad.67.1411983361470;
 Mon, 29 Sep 2014 02:36:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.101.178 with HTTP; Mon, 29 Sep 2014 02:35:41 -0700 (PDT)
In-Reply-To: <1411929195-23775-3-git-send-email-ryazanov.s.a@gmail.com>
References: <1411929195-23775-1-git-send-email-ryazanov.s.a@gmail.com> <1411929195-23775-3-git-send-email-ryazanov.s.a@gmail.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Mon, 29 Sep 2014 11:35:41 +0200
Message-ID: <CAOiHx==vwHX59bbpcRBzj_6-jEiSKOV3qAjsh1WsLfGHh9AL+w@mail.gmail.com>
Subject: Re: [PATCH 02/16] MIPS: ar231x: add basic AR5312 SoC support
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42881
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
> Add basic support for Atheros AR5312/AR2312 SoCs: registers definition
> file and initial setup code.

For the whole file: please use the style

do_foo()
{
  if (is_ar5312())
      ar5312_foo();
}

instead of

do_foo()
{
  ar5312_foo();
}

ar5312_foo()
{
  if (!is_ar5312())
    return;
}

also same comments regarding naming (ar531x instead of ar5312).

Regards
Jonas
