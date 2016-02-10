Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 01:21:20 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:51267 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009890AbcBJAVS6KT3O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Feb 2016 01:21:18 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 6F0A84A547054;
        Wed, 10 Feb 2016 00:21:09 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 10 Feb 2016 00:21:12 +0000
Received: from localhost (10.100.200.47) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 10 Feb
 2016 00:21:12 +0000
Date:   Tue, 9 Feb 2016 16:21:10 -0800
From:   Paul Burton <paul.burton@imgtec.com>
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
CC:     Manuel Lauss <manuel.lauss@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: 4.1: XPA breaks Alchemy
Message-ID: <20160210002110.GA27917@NP-P-BURTON>
References: <CAOLZvyHPYF2kO2EdijCCX9OSt=hdo8g-tUXzZee0sSXT=-WdDw@mail.gmail.com>
 <CAOLZvyE3GYuU8E9Rico3bjRFs=4wn5mWfRf0NyCk_zJqxQTneg@mail.gmail.com>
 <5638B2D7.9050809@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <5638B2D7.9050809@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [10.100.200.47]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51937
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

On Tue, Nov 03, 2015 at 07:12:55AM -0600, Steven J. Hill wrote:
> On 07/14/2015 01:28 AM, Manuel Lauss wrote:
> >Ping
> >
> >This issue still exists in latest -git.  It goes away when
> >CONFIG_PHYS_ADDR_T_64BIT
> >is disabled, but then we lose PCI and PCMCIA (and other chipselect signals which
> >are mapped beyond 4G).
> >
> >I'm going to look into this today if nobody beats me to it.
> >
> >Manuel
> >
> Hey Manuel.
> 
> I'm sorry that I did not pay attention and see this on the mailing list. I
> will get a fix out today (tomorrow your time).
> 
> Steve

Hi Steve,

Did you ever fix this? I don't see anything in patchwork from you since
a long time before this email.

I believe the same issue occurs if you take any system with a 32 bit
kernel (eg. malta or boston) & select ARCH_PHYS_ADDR_T_64BIT.

One issue is that iPTE_SW tries to ori a mode with bits beyond bit 15
set if you are running that 32 bit kernel on a 64 bit CPU, leading to
uasm overflow errors & garbage TLB handlers. Just having it or in all of
mode isn't sufficient to get things working though.

Thanks,
    Paul
