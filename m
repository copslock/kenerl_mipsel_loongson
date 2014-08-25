Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Aug 2014 21:10:26 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:47348 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006599AbaHYTKZfa900 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Aug 2014 21:10:25 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 160CD28A5FC;
        Mon, 25 Aug 2014 21:10:12 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-qg0-f41.google.com (mail-qg0-f41.google.com [209.85.192.41])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 50BDD28B40C;
        Mon, 25 Aug 2014 21:10:02 +0200 (CEST)
Received: by mail-qg0-f41.google.com with SMTP id z107so10244871qgd.28
        for <multiple recipients>; Mon, 25 Aug 2014 12:10:13 -0700 (PDT)
X-Received: by 10.140.48.234 with SMTP id o97mr36714590qga.10.1408993813905;
 Mon, 25 Aug 2014 12:10:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.84.244 with HTTP; Mon, 25 Aug 2014 12:09:53 -0700 (PDT)
In-Reply-To: <20140825112754.GE27724@linux-mips.org>
References: <1408818808-18850-1-git-send-email-Julia.Lawall@lip6.fr>
 <1408818808-18850-5-git-send-email-Julia.Lawall@lip6.fr> <20140825112754.GE27724@linux-mips.org>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Mon, 25 Aug 2014 21:09:53 +0200
Message-ID: <CAOiHx=m_-GmRwAmPOWFg8w9pFMPU8Vn9U-UO+k=jDdDxNH7R3Q@mail.gmail.com>
Subject: Re: [PATCH 4/7] MIPS: BCM63xx: delete double assignment
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Julia Lawall <Julia.Lawall@lip6.fr>, joe@perches.com,
        kernel-janitors@vger.kernel.org,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42233
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

On Mon, Aug 25, 2014 at 1:27 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Sat, Aug 23, 2014 at 08:33:25PM +0200, Julia Lawall wrote:
>
>> Delete successive assignments to the same location.  In each case, the
>> duplicated assignment is modified to be in line with other nearby code.
>>
>> A simplified version of the semantic match that finds this problem is as
>> follows: (http://coccinelle.lip6.fr/)
>
> Looking good, applied.

Huh, somehow gmail decided the original emails were spam.

> Thanks,
>
>   Ralf

Also thanks from me for cleaning up behind me! These mistakes were
definitely mine.


Jonas
