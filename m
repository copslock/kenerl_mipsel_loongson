Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 May 2013 12:49:23 +0200 (CEST)
Received: from mail.nanl.de ([217.115.11.12]:43876 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823005Ab3ELKtUi-z0S (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 12 May 2013 12:49:20 +0200
Received: from mail-ve0-f182.google.com (mail-ve0-f182.google.com [209.85.128.182])
        by mail.nanl.de (Postfix) with ESMTPSA id 5333F45E84
        for <linux-mips@linux-mips.org>; Sun, 12 May 2013 10:48:58 +0000 (UTC)
Received: by mail-ve0-f182.google.com with SMTP id da11so3559552veb.41
        for <linux-mips@linux-mips.org>; Sun, 12 May 2013 03:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Ef+0DxgFSgKG1JIVlrtPXe9Sicth2lfhczve4Z7EYxY=;
        b=Dm0WgTIahGEK1F5+qF0z6IAm98cD6u871LMjvOMLPKq3Bm4R+anP3pTUV9Gt9mlOA3
         lf5V/Or7qaUD2WtLTRR5rSz/c8etjqtLNCUbtccVKmN1syUd8Ho+KPDCL0HgjxS0Evk+
         ZGqNP3xnAhGz11Dn0epYcLik4ZpuYu12hyDeePjfjUbTLE0WsiN+Xj87Nr4taxx6A2UO
         Ke5q41bIMX2Pn3iNIGy1oUm/o5iUo4vBU4VpMelkb55OYFtcuXpyEJWd1CpDR/lAC7Ol
         q4UP0bGXjs/r+Sj7+CT12tC0QwP+oOYh5NxMyJtagqlG/fhI4yyill2QFTE1GsJbcRkX
         UPmw==
X-Received: by 10.52.179.129 with SMTP id dg1mr3117910vdc.111.1368355755177;
 Sun, 12 May 2013 03:49:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.220.219.198 with HTTP; Sun, 12 May 2013 03:48:54 -0700 (PDT)
In-Reply-To: <1368189407.26780.159.camel@sauron.fi.intel.com>
References: <1364044070-10486-1-git-send-email-jogo@openwrt.org>
 <1364044070-10486-3-git-send-email-jogo@openwrt.org> <1368189407.26780.159.camel@sauron.fi.intel.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Sun, 12 May 2013 12:48:54 +0200
Message-ID: <CAOiHx=m+ZuBcj=qmTtytWouCbtbj+_OX3dS8x_0=kHEBFZ+TmA@mail.gmail.com>
Subject: Re: [PATCH 2/3] MIPS: BCM63XX: export PSI size from nvram
To:     dedekind1@gmail.com
Cc:     linux-mtd@lists.infradead.org,
        David Woodhouse <dwmw2@infradead.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36384
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

On Fri, May 10, 2013 at 2:36 PM, Artem Bityutskiy <dedekind1@gmail.com> wrote:
> On Sat, 2013-03-23 at 14:07 +0100, Jonas Gorski wrote:
>> Signed-off-by: Jonas Gorski <jogo@openwrt.org>
>> ---
>>  arch/mips/bcm63xx/nvram.c                          |   11 +++++++++++
>>  arch/mips/include/asm/mach-bcm63xx/bcm63xx_nvram.h |    2 ++
>>  2 files changed, 13 insertions(+)
>
> Acks from MIPS folks would be nice to have, but I pushed this patch to
> the l2-mtd.git tree, thanks!

I had expected Florian's valid comment from preventing this series
from going in, but if you pushed it already then I will fix the return
type problem  that Florian pointed out in a separate patch (or rather
add add some range check for nvram.psi_size). Luckily it is a
theoretical issue only, as I haven't seen a device yet with an invalid
value.


Regards
Jonas
