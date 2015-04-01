Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Apr 2015 06:36:59 +0200 (CEST)
Received: from resqmta-ch2-02v.sys.comcast.net ([69.252.207.34]:38920 "EHLO
        resqmta-ch2-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008595AbbDAEgzZznme (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Apr 2015 06:36:55 +0200
Received: from resomta-ch2-20v.sys.comcast.net ([69.252.207.116])
        by resqmta-ch2-02v.sys.comcast.net with comcast
        id AUcq1q0032XD5SV01Ucquz; Wed, 01 Apr 2015 04:36:50 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-ch2-20v.sys.comcast.net with comcast
        id AUco1q00642s2jH01UcofS; Wed, 01 Apr 2015 04:36:50 +0000
Message-ID: <551B75DA.10603@gentoo.org>
Date:   Wed, 01 Apr 2015 00:36:42 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] MIPS: R10000: Split R10000 definitions from R12000
 and up
References: <54BFA0DF.8000104@gentoo.org> <20150331121757.GD28951@linux-mips.org>
In-Reply-To: <20150331121757.GD28951@linux-mips.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1427863010;
        bh=7ETq1VyFfT00AqLOU6ORU6cjIm2lJT5rnuC5mAtuADU=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=m+9LwL/DhxZuK3wfbR2EQDKAjb5fsZa899+6/DaVLfLBrfL82HVpbDoOPUqOW+1S2
         1dAuJLqBb80cMMAa/VKLt/SS+FYQnh1uM+bOslbEAU04y3yNRuszeEkdpSdPW2Yqnl
         EVVRiIVyXxQa/NMRysk2M7o2e5HGJfyM6jaZz6y99/roFssWJw5EBILY5SjtUSTqDJ
         vZ4yyXeJT7KCP51AohJwBbiFqVeZizyoRL19RvMc5d6lX+33I7ijcGIUJmuib/TuMQ
         dM7KwEIRIpEZDA17zhA/i41x9UelzgAsqCeSG9ultgdzMxWJvJ1JY+S6akMJNQSwct
         Hb17J3kARSvhQ==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46674
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

On 03/31/2015 08:17, Ralf Baechle wrote:
> On Wed, Jan 21, 2015 at 07:51:43AM -0500, Joshua Kinard wrote:
> 
>>  up
>> Content-Type: text/plain; charset=utf-8
>>
>> From: Joshua Kinard <kumba@gentoo.org>
>>
>> This patch splits the old R10000 definitions so that the R10000_LLSC_WAR can be
>> disabled and -mno-fix-r10000 passed to CFLAGS for systems running R12000 CPUs
>> and greater.  This allows the kernel to build without branch-likely
>> instructions, which are considered deprecated in current MIPS implementations.
>>  Only R10000 systems with R2.6 and lower CPUs require branch-likely to work
>> around a known hardware errata item.
> 
> The kernel doesn't use -mfix-r10000 rsp. -mno-fix-r10000 or any code that
> would rely on the default setting for this option.  The kernel rather
> opencodes all these atomic sequences in inline assembler.

True, though I added that on the off chance the compiler decides to emit its
own ll/sc pair somewhere and thus could use normal beq/beqz insns instead of
the branch-likely variants.  Couldn't hurt.


> Only platforms which are known to be equipped with R10000 v2.6 processors
> enable R10000_LLSC_WAR and I've done so quite intentionally not just for
> some CPU configuration but the entire platforms which at this time are IP27
> and IP28.

This allows one to override this on IP27 at least.  I've got both R12K and R14K
node boards, neither of which require the branch-likely workarounds, so it's
safe to disable the WAR there.  And although it's not in the tree yet, IP30
also benefits from this as well.  I am not sure how old the IP30 R10000 CPU
revs can go, so it might need the WAR in limited circumstances, too.  It also
sets things up to further separate R12K from R14K should any beneficial
enhancements be discovered in the future (or if I can ever figure out why R14K
seems weirder in some instances than R12K).

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
