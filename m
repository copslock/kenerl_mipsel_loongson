Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jul 2014 20:06:41 +0200 (CEST)
Received: from mail-ig0-f174.google.com ([209.85.213.174]:52408 "EHLO
        mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860069AbaG3SGiUf6lC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Jul 2014 20:06:38 +0200
Received: by mail-ig0-f174.google.com with SMTP id c1so7802776igq.13
        for <multiple recipients>; Wed, 30 Jul 2014 11:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7z7Cgb842OdccY7d2RoIhIM8VQqsUrwHp/Z00sZTf4c=;
        b=i6O04Xxr8NWECRN+XnseK3JPtYk34609MfR/HMVakiP3H9x3SIHcXe/4cfPbnTpwA2
         MJLAt3FrNCNPiidGH0qrp+J68r3hQd1JhnZ0g4OEwVL+djIB5BLoPDv8IVwBcnELwsmH
         nDDRUGVW/8xfMcv1TCXayh4rXdBQNfTu0fGp9KgdDHs3BloP8xmAoDSrxBFjArzuzFUt
         WgcqFkxoI7Ko9Q45twO6i3OCH5/G287XkQKfIPnzHbTAHpB2HNMWGQbuS6yxlQaMmtPY
         EiIs55dH2L0NWxBcNcfy5HV00YPVFEvJF3UXOzw4gbvoqyTMwied6A7iZOUYUQsPCJFr
         PBlA==
MIME-Version: 1.0
X-Received: by 10.50.6.77 with SMTP id y13mr9989304igy.21.1406743591980; Wed,
 30 Jul 2014 11:06:31 -0700 (PDT)
Received: by 10.107.130.160 with HTTP; Wed, 30 Jul 2014 11:06:31 -0700 (PDT)
In-Reply-To: <1406584437-31108-1-git-send-email-hauke@hauke-m.de>
References: <1406584437-31108-1-git-send-email-hauke@hauke-m.de>
Date:   Wed, 30 Jul 2014 20:06:31 +0200
Message-ID: <CACna6rw_OswnvN7YD7AVnCNKtKJAk8UGXEjUdVJEvaBF3ErAmQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: BCM47XX: make reboot more relaiable
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41821
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

On 28 July 2014 23:53, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> The reboot on the BCM47XX SoCs is done, by setting the watchdog counter
> to 1 and let it trigger a reboot, when it reaches 0. Some devices with
> a BCM4705/BCM4785 SoC do not reboot when the counter is set to 1 and
> decreased to 0 by the hardware. It looks like it works more reliable
> when we set it to 3. As far as I understand the hardware, this should
> not make any difference, but I do not have access to any documentation
> for this SoC.
> It is still not 100% reliable.

Did you see code in hndmips.c of Broadcom SDK? Maybe we need this
magic ASM code they have it there?

if (CHIPID(sih->chip) == BCM4785_CHIP_ID)
    MTC0(C0_BROADCOM, 4, (1 << 22));
si_watchdog(sih, 1);
if (CHIPID(sih->chip) == BCM4785_CHIP_ID) {
    __asm__ __volatile__(
        ".set\tmips3\n\t"
        "sync\n\t"
        "wait\n\t"
        ".set\tmips0");
}
while (1);

Maybe it'll work better and more reliable?
