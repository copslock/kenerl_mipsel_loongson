Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Feb 2015 09:11:59 +0100 (CET)
Received: from astoria.ccjclearline.com ([64.235.106.9]:46206 "EHLO
        astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006620AbbBUIL6E0TFb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Feb 2015 09:11:58 +0100
Received: from [99.240.204.5] (port=43958 helo=crashcourse.ca)
        by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.80)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1YP5AF-0000mc-HD; Sat, 21 Feb 2015 03:11:51 -0500
Date:   Sat, 21 Feb 2015 03:11:51 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To:     Matt Turner <mattst88@gmail.com>
cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: what is the purpose of the following LE->BE patch to
 arch/mips/include/asm/io.h?
In-Reply-To: <CAEdQ38F5jWX8Ujs4Jj6scxPAqtZw55gn4exL_rj9HCmf5YJgCA@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1502210258580.5732@localhost>
References: <alpine.LFD.2.11.1502200445290.26212@localhost> <CAEdQ38HVxBug9ukgE1oXLo_e+8FDB_yuY0vn1d84puoThhdYCA@mail.gmail.com> <CAEdQ38F5jWX8Ujs4Jj6scxPAqtZw55gn4exL_rj9HCmf5YJgCA@mail.gmail.com>
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
X-archive-position: 45873
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

On Fri, 20 Feb 2015, Matt Turner wrote:

> On Fri, Feb 20, 2015 at 8:00 PM, Matt Turner <mattst88@gmail.com> wrote:
> > On Fri, Feb 20, 2015 at 1:53 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> >>
> >>   was recently handed a MIPS-based dev board (can't name the vendor,
> >> NDA) that *typically* runs in LE mode but, because of a proprietary
> >> binary that must be run on the board and was compiled as BE, has to be
> >> run in BE mode.
> >>
> >>   the vendor supplied a yoctoproject layer that seems to work fine
> >> but, in changing the DEFAULTTUNE to big-endian, the following patch
> >> had to be applied to the 3.14 kernel tree to the file
> >> arch/mips/include/asm/io.h in order to get output from the console
> >> port as the system was booting:
> >>
> >> 326c326,333
> >> <               *__mem = __val;                                         \
> >> ---
> >>>       {                                                                               \
> >>>               if (sizeof(type) == sizeof(u32))                \
> >>>               {                                                                       \
> >>>                       *__mem = __cpu_to_le32(__val);  \
> >
> > They're byte swapping a value if they're in big endian mode.
> >
> >>>               }                                                                       \
> >>>               else                                                            \
> >>>                       *__mem = __val;                                         \
> >
> > And they don't seem to really understand the __cpu_to_le32 macro...
>
> Sorry, I should be more precise. They're byte swapping 32-bit values
> if they're in big endian mode, and copying everything else without
> conversion.

  i understand *in general* what the above is doing ... what i don't
understand is why it's necessary to hack a fundamental kernel header
file this way in order to run this board in BE versus LE mode.

  the kernel was already configured for BE mode, which i would have
thought would be sufficient, so it's a mystery to me why one would
still have to *further* hack the io.h file this way -- if the above is
a necessity, shouldn't it be a conditional change based on selecting
BE configuration?

  has anyone else ever needed to do this? or is this some weird,
one-off hack that perhaps applies *only* to some bizarre feature of
this board?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
