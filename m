Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Feb 2015 09:27:24 +0100 (CET)
Received: from astoria.ccjclearline.com ([64.235.106.9]:46294 "EHLO
        astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006620AbbBUI1Tl6hqq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Feb 2015 09:27:19 +0100
Received: from [99.240.204.5] (port=44126 helo=crashcourse.ca)
        by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.80)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1YP5P9-0001zL-BE; Sat, 21 Feb 2015 03:27:15 -0500
Date:   Sat, 21 Feb 2015 03:27:15 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To:     Manuel Lauss <manuel.lauss@gmail.com>
cc:     Matt Turner <mattst88@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: what is the purpose of the following LE->BE patch to
 arch/mips/include/asm/io.h?
In-Reply-To: <CAOLZvyFKc4fu6F5qOuzaAJg9wvkKhYrFcV35Vn1Hzo_sYVYfvQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1502210325450.8996@localhost>
References: <alpine.LFD.2.11.1502200445290.26212@localhost> <CAEdQ38HVxBug9ukgE1oXLo_e+8FDB_yuY0vn1d84puoThhdYCA@mail.gmail.com> <CAEdQ38F5jWX8Ujs4Jj6scxPAqtZw55gn4exL_rj9HCmf5YJgCA@mail.gmail.com> <alpine.LFD.2.11.1502210258580.5732@localhost>
 <CAOLZvyFKc4fu6F5qOuzaAJg9wvkKhYrFcV35Vn1Hzo_sYVYfvQ@mail.gmail.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - astoria.ccjclearline.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <rpjday@crashcourse.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45875
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rpjday@crashcourse.ca
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

On Sat, 21 Feb 2015, Manuel Lauss wrote:

> On Sat, Feb 21, 2015 at 9:11 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> >
> >   has anyone else ever needed to do this? or is this some weird,
> > one-off hack that perhaps applies *only* to some bizarre feature of
> > this board?
>
> My guess is that the peripherals attached to the internal bus
> only undestand little endian, and the bus doesn't do byte swaps when
> the core isn't configured for LE. I.e. the BE feature is only
> implemented in the mips core and the rest was designed for LE only.

  ok, that makes sense ... so it's very likely a "issue with *this*
particular board and setup" kind of thing. thanks.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
