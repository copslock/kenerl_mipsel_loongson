Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Apr 2014 13:34:37 +0200 (CEST)
Received: from mail-ob0-f171.google.com ([209.85.214.171]:52531 "EHLO
        mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6819447AbaDWLeej0dy1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Apr 2014 13:34:34 +0200
Received: by mail-ob0-f171.google.com with SMTP id uy5so862360obc.16
        for <linux-mips@linux-mips.org>; Wed, 23 Apr 2014 04:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=TGRGrLeLCXlbiQgCvtThQ9FnWi2XiUuQfv6jfd/9UDk=;
        b=PflDYmH0TL6c2exv2bibJMa1JsTppeCvVl5Vf5ziucCXX6Qfe2gl11afoNui9beXKW
         3D6MGt/ojOATU7KPGT/qsmGcTu8w77xPKxWlwz1DAigW6ooRlXCkqgQUXCExyvkPgDN+
         UzU2k6xxMPQO0yajNGnvMtXFQPHuA1fUNESJm6nxhgoMW29ekcgf43tL5abyhrFDbUo0
         lIHuixSpg3cdYrvCVWr6Xp7RMvcdkTD9O2UBkm+LP56Z3lmXHPh/boIyc6OqPEoSu2rr
         41jhLThr9fqrw4gRzYResYwCuDNo76CqDUYekvCGP05ufZdnLJLNMLfzhyjVeR2fREVe
         e4uw==
X-Gm-Message-State: ALoCoQkVmhRywZnIM7uOP40C/DQA8rA+C3VHHjSp4LNpqYKWwEvr9+LDctFTyvGAsvwcPBKb0SQl
MIME-Version: 1.0
X-Received: by 10.60.92.170 with SMTP id cn10mr338937oeb.76.1398252868188;
 Wed, 23 Apr 2014 04:34:28 -0700 (PDT)
Received: by 10.76.124.165 with HTTP; Wed, 23 Apr 2014 04:34:28 -0700 (PDT)
X-Originating-IP: [217.156.156.35]
In-Reply-To: <CAMuHMdU75HO=JUgb_wm7OCXDEEUL_=GGjkTMy0WzA+VyFuKa=g@mail.gmail.com>
References: <1398251857-16290-1-git-send-email-james.hogan@imgtec.com>
        <CAMuHMdU75HO=JUgb_wm7OCXDEEUL_=GGjkTMy0WzA+VyFuKa=g@mail.gmail.com>
Date:   Wed, 23 Apr 2014 12:34:28 +0100
X-Google-Sender-Auth: k3Y1AcC8MTb9JLQcOIJWBMA37j8
Message-ID: <CAAG0J99-KD95L5fZzZ0Dpi5y9spsK=p85MKBUWZWaOg_hMnOng@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Wire up renameat2 syscall
From:   James Hogan <james.hogan@imgtec.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Markos Chandras <markos.chandras@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <james@albanarts.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39910
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Hi Geert,

On 23 April 2014 12:25, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, Apr 23, 2014 at 1:17 PM, James Hogan <james.hogan@imgtec.com> wrote:
>> Wire up for MIPS the new renameat2 system call added in commit
>> 520c8b165052 (vfs: add renameat2 syscall) merged in v3.15-rc1.
>
> Miklos already wired this up for all architectures, cfr. the MIPS version
> sent to lkml and linux-arch: https://lkml.org/lkml/2014/4/11/196

Ah yes, I missed that!

Thanks
James
