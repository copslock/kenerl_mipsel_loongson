Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2014 04:41:18 +0200 (CEST)
Received: from qmta06.westchester.pa.mail.comcast.net ([76.96.62.56]:34702
        "EHLO qmta06.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006814AbaHZClRWPUj7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Aug 2014 04:41:17 +0200
Received: from omta02.westchester.pa.mail.comcast.net ([76.96.62.19])
        by qmta06.westchester.pa.mail.comcast.net with comcast
        id jEcf1o0010QuhwU56EhBXY; Tue, 26 Aug 2014 02:41:11 +0000
Received: from [192.168.1.13] ([50.190.84.14])
        by omta02.westchester.pa.mail.comcast.net with comcast
        id jEh91o0100JZ7Re3NEhAWZ; Tue, 26 Aug 2014 02:41:11 +0000
Message-ID: <53FBF3C3.90509@gentoo.org>
Date:   Mon, 25 Aug 2014 22:41:07 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Chris Zankel <chris@zankel.net>,
        Marc Gauthier <marc@cadence.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Steven Hill <Steven.Hill@imgtec.com>
Subject: Re: [PATCH v4 0/2] mm/highmem: make kmap cache coloring aware
References: <1406941899-19932-1-git-send-email-jcmvbkbc@gmail.com> <20140825171600.GH25892@linux-mips.org> <53FBCD09.1050003@gentoo.org> <53FBD676.8080307@gmail.com>
In-Reply-To: <53FBD676.8080307@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1409020871;
        bh=7pXsMm9PgVboL1iGLpDV+6rUik/btJU9xc6qN3NOVkI=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=woViiizYhSoMoZxFMKwFdVE4btrmHicYbUTfBjegaieCk9D3SJN66OJ0SQnLt1Sy3
         gL7Pmd7k+A/KZJBuFYj6Ht3ujtIliVbcIyv82IoJQcEAYe9FxiypxwLX4gZBNv1opE
         oAFxrtfijZNftr2GTmPjQeM98rSTgaUYjwCB5D8zedSGWOtC+zDOuYsu53lTUsh8h4
         63lnsPqRgQnWb64sT/uOfikMCj6RnUV/KWL0KEDfWeLHcpbs0iia6vCIAh44NHop+1
         ms4kbLZjhQ1BoDoni0y9Zm/mAN2Ki+5PGhqGbwcN/Ghb3+mq/PEH4sPQFltaYR5mjM
         3z+5YcOMT1sRA==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42243
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

On 08/25/2014 20:36, David Daney wrote:
> On 08/25/2014 04:55 PM, Joshua Kinard wrote:
>> On 08/25/2014 13:16, Ralf Baechle wrote:
>>> On Sat, Aug 02, 2014 at 05:11:37AM +0400, Max Filippov wrote:
>>>
>>>> this series adds mapping color control to the generic kmap code, allowing
>>>> architectures with aliasing VIPT cache to use high memory. There's also
>>>> use example of this new interface by xtensa.
>>>
>>> I haven't actually ported this to MIPS but it certainly appears to be
>>> the right framework to get highmem aliases handled on MIPS, too.
>>>
>>> Though I still consider increasing PAGE_SIZE to 16k the preferable
>>> solution because it will entirly do away with cache aliases.
>>
>> Won't setting PAGE_SIZE to 16k break some existing userlands (o32)?  I use a
>> 4k PAGE_SIZE because the last few times I've tried 16k or 64k, init won't
>> load (SIGSEGVs or such, which panicks the kernel).
>>
> 
> It isn't supposed to break things.  Using "stock" toolchains should result
> in executables that will run with any page size.
> 
> In the past, some geniuses came up with some linker (ld) patches that, in
> order to save a few KB of RAM, produced executables that ran only on 4K pages.
> 
> There were some equally astute Debian emacs package maintainers that were
> carrying emacs patches into Debian that would not work on non-4K page size
> systems.
> 
> That said, I think such thinking should be punished.  The punishment should
> be to not have their software run when we select non-4K page sizes.  The
> vast majority of prepackaged software runs just fine with a larger page size.

Well, it does appear to mostly work now w/ 16k PAGE_SIZE.  The Octane booted
into userland with just a couple of "illegal instruction" errors from 'rm'
and 'mdadm'.  I wonder if that's tied to a hardcoded PAGE_SIZE somewhere.
Have to dig around and find something that reproduces the problem on demand.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And
our lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
