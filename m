Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2014 04:45:37 +0200 (CEST)
Received: from qmta09.westchester.pa.mail.comcast.net ([76.96.62.96]:55578
        "EHLO qmta09.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816503AbaHSCpUBxVJj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Aug 2014 04:45:20 +0200
Received: from omta15.westchester.pa.mail.comcast.net ([76.96.62.87])
        by qmta09.westchester.pa.mail.comcast.net with comcast
        id gSbl1o0021swQuc59SlBf3; Tue, 19 Aug 2014 02:45:11 +0000
Received: from [192.168.1.13] ([50.190.84.14])
        by omta15.westchester.pa.mail.comcast.net with comcast
        id gSlB1o0010JZ7Re3bSlBmi; Tue, 19 Aug 2014 02:45:11 +0000
Message-ID: <53F2BA34.5010100@gentoo.org>
Date:   Mon, 18 Aug 2014 22:45:08 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: IP28 boot error under 3.16
References: <53F039B3.9010503@gentoo.org> <20140818152750.GA1860@alpha.franken.de>
In-Reply-To: <20140818152750.GA1860@alpha.franken.de>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1408416311;
        bh=TfeVqxLX/pE+oilys1Wt2N/yWeHvhtbJxBjtT4DFPQI=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=ijO8rreoRrvbPjppfBb23qLW+a5LEVDRX0aSzZ5V3aQ4vb2MEZEoRJuE8qjV+bIV3
         IqkTgn2/8a+u9J0405mrnF7ZAdSh4bLso5PSeZA6H2l2vTgcgjW1uVML/EgvJb1OBg
         3h59dSd26s3OHYzl4mN2OpgkxQ0Yr70xz1eTK7/R+Iqq2ifTvSRyfQuIbkIro1n2Sa
         IBb6BZXFokRtMWZu0ghGF4TyMsnmWqYDTDGB3oeQkq4VZq8vkMMQ76JSqeCZjan86l
         NA7DxlWe0kT4Uy95WOZBoJVmijbHMf8ZO8GjvnP/Z0eECx4KzQGaRIV1dNLcp/mYSo
         9u3VLLK76WLOQ==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42138
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 08/18/2014 11:27, Thomas Bogendoerfer wrote:
> On Sun, Aug 17, 2014 at 01:12:19AM -0400, Joshua Kinard wrote:
>> Thoughts?
> 
> something like
> 
> #define IO_BASE                 _AC(0x9000000000000000, UL)
> 
> in mach-ip28/spaces.h should do the trick. UNCAC_BASE also looks
> strange, no idea why there that way.

That appears to do it, thanks!  Still getting a panic somewhere before
Impact comes up, as the LED starts flashing.  However, my serial cables are
missing in a closet somewhere, so I can't debug it further right now.  I
ordered some more cables so I can take another look later in the week (or go
tear my closet apart looking for the other ones...).

Digging on kernel.org, it appears commit ed3ce16c added the definitions of
UNCAC_BASE and IO_BASE as part of a larger fix.  Before that, these
definitions didn't exist in IP28's spaces.h.

I'll send a patch for this fix shortly.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And
our lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
