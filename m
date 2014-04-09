Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Apr 2014 12:15:56 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:54176 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822312AbaDIKPyPFM2Z (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Apr 2014 12:15:54 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id D46232841EC
        for <linux-mips@linux-mips.org>; Wed,  9 Apr 2014 12:15:07 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-qg0-f49.google.com (mail-qg0-f49.google.com [209.85.192.49])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 48FDB28069F
        for <linux-mips@linux-mips.org>; Wed,  9 Apr 2014 12:15:07 +0200 (CEST)
Received: by mail-qg0-f49.google.com with SMTP id e89so2034975qgf.22
        for <linux-mips@linux-mips.org>; Wed, 09 Apr 2014 03:15:51 -0700 (PDT)
X-Received: by 10.140.41.200 with SMTP id z66mr7109159qgz.102.1397038551024;
 Wed, 09 Apr 2014 03:15:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.109.97 with HTTP; Wed, 9 Apr 2014 03:15:30 -0700 (PDT)
In-Reply-To: <1396981642-407998-1-git-send-email-manuel.lauss@gmail.com>
References: <1396981642-407998-1-git-send-email-manuel.lauss@gmail.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Wed, 9 Apr 2014 12:15:30 +0200
Message-ID: <CAOiHx=kP6JctAztiUVqpRDvpe-SSpgt068KQu+maM6gi7+RUgQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] MIPS: optional floating point support
To:     Manuel Lauss <manuel.lauss@gmail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39743
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

On Tue, Apr 8, 2014 at 8:27 PM, Manuel Lauss <manuel.lauss@gmail.com> wrote:
> This small patch makes the floating point support and the FPU-emulator
> optional.  A Warning will be printed once when first use of floating
> point is detected.
>
> Disabling fpu support shrinks vmlinux by about 54kBytes (32bit,
> optimizing for size), and it is mainly useful for embedded devices
> which have no need for float math (e.g. routers).
>
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>

From my of view, it looks good now.


Regards
Jonas
