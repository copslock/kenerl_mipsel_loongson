Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Aug 2014 13:49:13 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57015 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007012AbaH0LtLg0J3Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Aug 2014 13:49:11 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 458F0523B2DB7;
        Wed, 27 Aug 2014 12:49:02 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 27 Aug
 2014 12:49:04 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 27 Aug 2014 12:49:04 +0100
Received: from localhost (192.168.79.156) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 27 Aug
 2014 12:49:01 +0100
Date:   Wed, 27 Aug 2014 12:48:54 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     "lkcl ." <luke.leighton@gmail.com>
CC:     <linux-mips@linux-mips.org>
Subject: Re: rhombus tech eoma68 ingenic jz4775 cpu card
Message-ID: <20140827114854.GC25985@pburton-laptop>
References: <CAPweEDznk3iecHkQcaGMd_EZfzZmbAbtXuO9dnePctDxFSWS7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAPweEDznk3iecHkQcaGMd_EZfzZmbAbtXuO9dnePctDxFSWS7Q@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.79.156]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42279
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On Wed, Aug 27, 2014 at 12:18:56PM +0100, lkcl . wrote:
> hi all,
> 
> i'm a long-standing software libre advocate and developer and i tend
> to tackle the areas where free software doesn't have someone already
> working on it.  that has taken me into hardware design, so i'd like to
> let people here know that i have designed a hardware standard (eoma68)
> and have been working with ingenic to create a CPU card using the
> ingenic JZ4775. info on the standard is here:
> http://elinux.org/Embedded_Open_Modular_Architecture/EOMA-68#Table_of_EOMA-68_pinouts
> 
> the PCB designs are done and will be sent off to be prototyped (qty 5
> are planned at the moment) at the beginning of next month (september).
> it will be the very first CPU card that could go into FSF-Endorseable
> products and be reasonably popular, as Ingenic have, bless 'em, even
> released the full source code of the VPU drivers.  no, not "a .a or
> .so with some header files", *actual* full source.  also as people
> familiar with Ingenic X-Burst will know, although it is a bit
> challenging the 3D libraries are also fully software libre.
> 
> very very early Ingenic SoCs (JZ4740) only used X-Burst: ingenic then
> unfortunately licensed proprietary 2D/3D/VPU hard macros for a while
> but the JZ4775 is the first 1ghz (i.e. modern-ish) SoC that can
> address 3Gb (i.e. modern-ish) DDR3 RAM and *doesn't* include
> proprietary drivers.
> 
> so! :)
> 
> if anyone would like to get involved, just let me know, i will be
> happy to answer.  just so you know, i am subscribed (digest) to
> linux-mips.
> 
> l.

Hi Luke :)

That all sounds very interesting! I would definitely be interested in
getting involved & helping out, and I imagine others at Imagination
may be too!

We have recently begun releasing a board based around the jz4780[1] so
have been doing a fair bit of work on that SoC, are familiar with some
of the older SoCs in the jz47xx series and I believe should have access
to some other jz4775 based boards. There is also the jz4770 based GCW
zero project[2] which is interested in developing, improving &
mainlining Linux support for that SoC and there is of course the
existing in-tree jz4740 support. Effectively we're all aiming towards
having in-tree support for the whole series of jz47xx SoCs so if you're
interested in collaborating on that, it would be fantastic!

Did you have anything concrete in mind that would be helpful at this
stage, or are you more judging interest?

Thanks,
    Paul

[1]: http://elinux.org/MIPS_Creator_CI20
[2]: http://www.gcw-zero.com/
