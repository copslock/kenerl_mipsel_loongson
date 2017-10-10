Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Oct 2017 04:37:53 +0200 (CEST)
Received: from resqmta-ch2-07v.sys.comcast.net ([IPv6:2001:558:fe21:29:69:252:207:39]:36650
        "EHLO resqmta-ch2-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990396AbdJJChp7h5RY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Oct 2017 04:37:45 +0200
Received: from resomta-ch2-16v.sys.comcast.net ([69.252.207.112])
        by resqmta-ch2-07v.sys.comcast.net with ESMTP
        id 1kNseapKJoILS1kO2eyLIw; Tue, 10 Oct 2017 02:35:14 +0000
Received: from [192.168.1.13] ([73.173.137.35])
        by resomta-ch2-16v.sys.comcast.net with SMTP
        id 1kO1e9ksMwcoj1kO1eiTif; Tue, 10 Oct 2017 02:35:14 +0000
Subject: Re: Question regarding atomic ops
To:     linux-mips@linux-mips.org
References: <eb17f62d-c347-e470-f9cf-06b18a55481e@gentoo.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <4f77107c-18ba-d549-c5f2-d52d0460377b@gentoo.org>
Date:   Mon, 9 Oct 2017 22:34:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <eb17f62d-c347-e470-f9cf-06b18a55481e@gentoo.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLwWlcfN+VL9OCVu4c9g/VilNppOStGiH9hcutgXzifV1+MRaLp+aeaKXroZ2UnGfkeC8HHvizcWfv3iulCm1G07Iw6MoHcZUpOdgfYBQAeaGxlVnLgG
 HhrvrVEgKAwXFekfQKqwGQHCtnKouhpm09Rv1mR0DC1Oqs4AyhfLK3FosU2l2eQ39JQYhIYOWsbiz3OmCZjAbelkXivF+DLNV4I=
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60353
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

On 10/09/2017 22:24, Joshua Kinard wrote:

[snip]

> This raises the question of why was the standard "kernel_uses_llsc" case
> changed but not the R10000_LLSC_WAR case?  The changes seem like they would be
> applicable to the older R10K CPUs regardless, since this is before a lot of the
> code for the newer ISAs (R2+) was added.  I am getting a funny feeling that a
> lot of these templates need to be re-written (maybe even in plain C, given
> newer gcc's better intelligence) and other useful cleanups done.  I am not
> fluent in MIPS asm enough, though, to know what to change.

Answered one of my own questions via this buried commit from ~2006/2007 that
has a commit message, but no changed files:

https://git.linux-mips.org/cgit/ralf/linux.git/commit/arch/mips/include/asm/atomic.h?id=5999eca25c1fd4b9b9aca7833b04d10fe4bc877d

> [MIPS] Improve branch prediction in ll/sc atomic operations.
> Now that finally all supported versions of binutils have functioning
> support for .subsection use .subsection to tweak the branch prediction
> 
> I did not modify the R10000 errata variants because it seems unclear if
> this will invalidate the workaround which actually relies on the cheesy
> prediction of branch likely to cause a misspredict if the sc was
> successful.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

Seems like that second paragraph is a ripe candidate for a comment block so
this is better documented :)

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
