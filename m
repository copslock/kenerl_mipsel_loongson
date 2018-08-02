Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2018 16:16:59 +0200 (CEST)
Received: from mail-io0-x244.google.com ([IPv6:2607:f8b0:4001:c06::244]:43971
        "EHLO mail-io0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994056AbeHBOQ45Iusi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Aug 2018 16:16:56 +0200
Received: by mail-io0-x244.google.com with SMTP id y10-v6so1949992ioa.10
        for <linux-mips@linux-mips.org>; Thu, 02 Aug 2018 07:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IdF7jUEexRC4GbnJH7EPr1jr8K9tF5uKiVoaWGfOuMI=;
        b=TvqPWRBBwZq+asp0Lf0wUBIErRz8bj3xUgb6E8/hMUZNqbx2WEtH5WoRPIURc1MSAK
         McNywcshro03blTyWFGKqInFZX+IJcp2l4VKYBzkQrt2ay0kX9i4UA4uxDHNBjhYkSO3
         vFnj2e1LD2M6yPEhz3ghOrRvjc7dfSMNnBmwCJUZOEWYn7nsDs4sJX55EPHqhSt+3aBX
         s7h+3PBNIItSdV37QKI9QDU0U0IVSer5ibQZzAtqowTuIPHixtbaSWEP1Ja1ELDZ1DMO
         Ll4ImBh77A9FIidNgHnbOuDfbLf0ehxZlgbdjBPMGRRf8UZeNSouEV8vxIMhbTxFUw7i
         Phow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IdF7jUEexRC4GbnJH7EPr1jr8K9tF5uKiVoaWGfOuMI=;
        b=dbSya/oOSHldDdrOlPv/OEVj0qlw05V8c04PmUzzs33mKoRUFRfnfOaa0dFDMmn6DT
         p0HQY1DQwcjoVd6QxUoo/HRnQKnzeDYvFWaziqdkXWRMU4MutA8e4R0Vojh8zTirOIF2
         evSPGe+88DOg7+xaaP8vip2ROWoZ+Iq2xdQK8VszgaOLgc4r4lRX10p9rpt1J9dUJApR
         Tik/1rqnurvWk18bl1jjgpnHGWCiJDfocIb1nvdRQGcMkxFxL8908uF+d+lp9IUyJWlK
         VLc8BkpNfqZztkGeqqMjU7UY5u+esDKcqrdrpe662BXY1yrUzojz0lWOUGTmK1Z9eBOT
         umJw==
X-Gm-Message-State: AOUpUlFFfhU4QVLQeLEZyXKvQw42AdMsXZHd1i293/9lomdY7MPgsCxX
        5reeiiHDZtOKpZ25bHAAk4Y=
X-Google-Smtp-Source: AAOMgpeLwTUWeGaVesbXIu+j2d95AI2ZWblwBqI3iW+z06pG3fY68VwNFiUBya2g7Lm+xU31XiCqxg==
X-Received: by 2002:a6b:f40b:: with SMTP id i11-v6mr2400679iog.162.1533219410727;
        Thu, 02 Aug 2018 07:16:50 -0700 (PDT)
Received: from [100.71.5.67] ([184.151.246.124])
        by smtp.gmail.com with ESMTPSA id m1-v6sm528929iok.81.2018.08.02.07.16.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 07:16:49 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [RESEND PATCH 6/6] arm64: enable RapidIO menu in Kconfig
From:   Alex Bounine <alex.bou9@gmail.com>
X-Mailer: iPad Mail (15G77)
In-Reply-To: <20180802140033.GH38497@guest228.east.isi.edu>
Date:   Thu, 2 Aug 2018 10:16:48 -0400
Cc:     Christoph Hellwig <hch@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jwalters@isi.edu, Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Message-Id: <D6EE6CE1-FB11-41EB-B787-A093D26CE3E3@gmail.com>
References: <20180731142954.30345-1-acolin@isi.edu> <20180731142954.30345-7-acolin@isi.edu> <20180801095404.GA17585@infradead.org> <fad8661c-cd8c-3a9c-ca03-5d2f63893a24@gmail.com> <CAMuHMdVDra1MKcuuD0SqEYXSggr0iVFcbcjL33z7JuiE1_y8yw@mail.gmail.com> <20180802134544.GG38497@guest228.east.isi.edu> <20180802135421.GA13512@infradead.org> <20180802140033.GH38497@guest228.east.isi.edu>
To:     Alexei Colin <acolin@isi.edu>
Return-Path: <alex.bou9@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex.bou9@gmail.com
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

I will experiment with this idea.
Please keep me in CC as well.

Sent from my iPad

> On Aug 2, 2018, at 10:00 AM, Alexei Colin <acolin@isi.edu> wrote:
> 
>> On Thu, Aug 02, 2018 at 06:54:21AM -0700, Christoph Hellwig wrote:
>>> On Thu, Aug 02, 2018 at 09:45:44AM -0400, Alexei Colin wrote:
>>> If I move RapidIO option to drivers/Kconfig, then it won't appear under
>>> the Bus Options/System Support menu, along with other choices for the
>>> system bus (PCI, PCMCIA, ISA, TC, ...).
>> 
>> It's not like anyone cares.  And FYI, moving all those to
>> drivers/Kconfig is osmething I will submit for the next merge window.
> 
> Ok, I would appreciate a CC on that patch. After it lands, if
> there is time, I'll resubmit a rebased version of this patch.
