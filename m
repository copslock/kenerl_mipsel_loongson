Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2014 19:30:55 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:64698 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6862961AbaGVPic2Q9Jv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Jul 2014 17:38:32 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E020469A365CC;
        Tue, 22 Jul 2014 16:38:22 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 22 Jul
 2014 16:38:25 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Jul 2014 16:38:25 +0100
Received: from [192.168.154.158] (192.168.154.158) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 22 Jul
 2014 16:38:24 +0100
Message-ID: <53CE8570.8020404@imgtec.com>
Date:   Tue, 22 Jul 2014 16:38:24 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Rob Kendrick <rob.kendrick@codethink.co.uk>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: EdgeRouter Pro supported?  Strange FP problems
References: <20140722130616.GJ30723@humdrum> <53CE736E.1060009@imgtec.com> <20140722143311.GK30723@humdrum>
In-Reply-To: <20140722143311.GK30723@humdrum>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.158]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41470
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

On 07/22/2014 03:33 PM, Rob Kendrick wrote:
> 
>> What FPU problem are you seeing exactly? Could you show us a log for the
>> failure? Can you post a simple test case which will allow someone to
>> reproduce it?
> 
> A strange problem with awk (substr() doesn't work in either gawk or
> mawk).  I've tried binaries of awk that I've built myself, and binaries
> from Debian.  They all fail with my kernel, work fine with the 3.4
> kernel (with a load of Cavium patches) that ship with the EdgeRouter
> Pro.
> 
> I can see it with this awk script:
> 
> {
>   line = $ 0
>   prefix = substr(line, 1, 3)
>   suffix = substr(line, 9)
>   print "prefix is '" prefix "'"
>   print "suffix is '" suffix "'"
> }
> 
> execute with `echo "foo bar baz" | awk -f test.awk`.  With gawk, I get
> both outputs being "foo bar baz" and with mawk "".  Correct answers
> occur when using the shipped 3.4.
> 
> When you run gawk in linting mode, you get amusing errors like:
> 	warning: substr: length 3 too big for string indexing,
> 	truncating to 1.84467e+19

there have been quite a few FPU changes in 3.16. I am able to reproduce
the problem on EdgeRouter (non pro) but the result is not the same as
yours. The output using the 'gawk' is:

prefix is ''
suffix is 'baz'

a quick bisect between v3.15 and v3.16-rc1, which is the first tag with
all the new FPU changes, leads to the following bad commit:

08a07904e182895e1205f399465a3d622c0115b8
MIPS: math-emu: Remove most ifdefery.

Reverting the commit is not trivial unfortunately. Perhaps you could use
a v3.15 kernel for now (assuming it boots on that board) or perhaps use
an earlier revision before this bad commit (eg
9e8bad1f9c0370b2635175b34d6151b90a53da5c, which boots and your test
works for me)

[root@buildroot ~]# uname -a
Linux buildroot 3.15.0-rc5-00171-g9e8bad1f9c03 #1280 SMP PREEMPT Tue Jul
22 16:36:19 BST 2014 mips64 GNU/Linux
[root@buildroot ~]# echo "foo bar baz" | awk -f awk-test
prefix is 'foo'
suffix is 'baz'

I have CC'd Ralf who is the author of the commit. Ralf any idea?

-- 
markos
