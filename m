Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2014 01:56:03 +0200 (CEST)
Received: from qmta06.westchester.pa.mail.comcast.net ([76.96.62.56]:35637
        "EHLO qmta06.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006537AbaHYX4BwX6Mh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Aug 2014 01:56:01 +0200
Received: from omta24.westchester.pa.mail.comcast.net ([76.96.62.76])
        by qmta06.westchester.pa.mail.comcast.net with comcast
        id jBRq1o0031ei1Bg56BvwM4; Mon, 25 Aug 2014 23:55:56 +0000
Received: from [192.168.1.13] ([50.190.84.14])
        by omta24.westchester.pa.mail.comcast.net with comcast
        id jBvv1o0040JZ7Re3kBvvLr; Mon, 25 Aug 2014 23:55:56 +0000
Message-ID: <53FBCD09.1050003@gentoo.org>
Date:   Mon, 25 Aug 2014 19:55:53 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>,
        Max Filippov <jcmvbkbc@gmail.com>
CC:     linux-xtensa@linux-xtensa.org, Chris Zankel <chris@zankel.net>,
        Marc Gauthier <marc@cadence.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Steven Hill <Steven.Hill@imgtec.com>
Subject: Re: [PATCH v4 0/2] mm/highmem: make kmap cache coloring aware
References: <1406941899-19932-1-git-send-email-jcmvbkbc@gmail.com> <20140825171600.GH25892@linux-mips.org>
In-Reply-To: <20140825171600.GH25892@linux-mips.org>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1409010956;
        bh=8dznMvPL/iKLG9Tkn4Ijz2zl068niI+QefefLysqtJM=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=SlDbaqFS7ySrhHIj3x3HnaPM5rdKl6TrmSQMquOqrXsJL9PTGUU4eKOytOGcHyM0m
         XQiFum0gjr/+YzdgU3uJqqsgVXeQfa4Pp6RoYKiW5Fz/87Z6g+3AdauUbUz34y91uW
         ZXhuPwlfv1aI6IIe7jYdR+1Nvqlkuv3yNalR3OoLvCp4sc/deN1xlyQKlRI5CmkZ/p
         6HdbLUPZvnvczd0Z2FyjS2VAzH9rjEhc+lc9BrhhO+VWd2TGdAV8FtZZTRSYW6IRYv
         hzx6qMmD+53OHb+qNSZ7U3pZ/NvgnIt0kznp9R52zFGEvKdEV7OhMySuK3NbT7tqnH
         7snbAvPZdTexw==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42239
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

On 08/25/2014 13:16, Ralf Baechle wrote:
> On Sat, Aug 02, 2014 at 05:11:37AM +0400, Max Filippov wrote:
> 
>> this series adds mapping color control to the generic kmap code, allowing
>> architectures with aliasing VIPT cache to use high memory. There's also
>> use example of this new interface by xtensa.
> 
> I haven't actually ported this to MIPS but it certainly appears to be
> the right framework to get highmem aliases handled on MIPS, too.
> 
> Though I still consider increasing PAGE_SIZE to 16k the preferable
> solution because it will entirly do away with cache aliases.

Won't setting PAGE_SIZE to 16k break some existing userlands (o32)?  I use a
4k PAGE_SIZE because the last few times I've tried 16k or 64k, init won't
load (SIGSEGVs or such, which panicks the kernel).

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And
our lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
