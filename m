Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2014 20:44:56 +0200 (CEST)
Received: from mail-ie0-f181.google.com ([209.85.223.181]:63100 "EHLO
        mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6843053AbaFESoxahAJq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Jun 2014 20:44:53 +0200
Received: by mail-ie0-f181.google.com with SMTP id rp18so1273772iec.40
        for <multiple recipients>; Thu, 05 Jun 2014 11:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ynl1IPrGDCm1Dcv0eNt4ZpbEVVNGoMtK8Dhnf6B7Rj4=;
        b=PwBUI5lQSdv9Taop+lLdS9tPgBsy8cRgKpljaurLTDxtvFQFTVNiJbnwvblIovbgyA
         nb+KSt5vM5kZtzhrhea+m7UdD9Y7mrJL9vMm6/3wh7fDFcAKbpg681TwFQxpu/nNOrQ5
         raSC14UamxxMsReYJ1euVB8TpzCO1xiCWKpEOapNIRkgP0FuDM1Kc7LkbULTiVGYbsY3
         nKvSvZRYjQy/z1XRf44KPxHqcHGaK8OpgyyH8bSga/TDjLSUAM3qD2iYRuZ3lc4E0sr2
         CArkvuG9pwVCIX61y6InPRnL/lyeZNpeQfMj019v6sDaPRQNpBhIvgLHyqVfHTor4qXu
         z3Ww==
X-Received: by 10.50.152.38 with SMTP id uv6mr848205igb.34.1401993886899;
        Thu, 05 Jun 2014 11:44:46 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id q5sm54964215igg.10.2014.06.05.11.44.45
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 05 Jun 2014 11:44:46 -0700 (PDT)
Message-ID: <5390BA9D.3090402@gmail.com>
Date:   Thu, 05 Jun 2014 11:44:45 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: gcc warning in my trace_benchmark() code
References: <20140605121204.18ee5f2d@gandalf.local.home> <5390A4F0.3000601@gmail.com> <20140605133500.190eb31d@gandalf.local.home>
In-Reply-To: <20140605133500.190eb31d@gandalf.local.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40443
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 06/05/2014 10:35 AM, Steven Rostedt wrote:
> On Thu, 05 Jun 2014 10:12:16 -0700
> David Daney <ddaney.cavm@gmail.com> wrote:
>
>> On 06/05/2014 09:12 AM, Steven Rostedt wrote:
>>> I'm going through some of the warnings that Fengguang Wu's test bot has
>>> discovered, and one of them is from a MIPS allmodconfig build.
>>>
>>> https://lists.01.org/pipermail/kbuild-all/2014-May/004751.html
>>>
>>>      kernel/trace/trace_benchmark.c: In function 'trace_do_benchmark':
>>>>> kernel/trace/trace_benchmark.c:84:3: warning: comparison of distinct pointer types lacks a cast [enabled by default]
>>>>> kernel/trace/trace_benchmark.c:85:3: warning: comparison of distinct pointer types lacks a cast [enabled by default]
>>>      kernel/trace/trace_benchmark.c:38:6: warning: unused variable 'seedsq' [-Wunused-variable]
>>>
>>> vim +84 kernel/trace/trace_benchmark.c
>>>
>>>       78		if (bm_cnt > 1) {
>>>       79			/*
>>>       80			 * Apply Welford's method to calculate standard deviation:
>>>       81			 * s^2 = 1 / (n * (n-1)) * (n * \Sum (x_i)^2 - (\Sum x_i)^2)
>>>       82			 */
>>>       83			stddev = (u64)bm_cnt * bm_totalsq - bm_total * bm_total;
>>>     > 84			do_div(stddev, bm_cnt);
>>>     > 85			do_div(stddev, bm_cnt - 1);
>>>       86		} else
>>>       87			stddev = 0;
>>>       88	
>>>
>>>
>>>
>>> Is there something special with do_div in mips that I should be aware
>>> of?
>>
>> Yes.  MIPS is using the implementation in asm-generic/div64.h,  which
>> per the comments in that file has a useless pointer compare to find just
>> this type of issue.
>
> You mean this comment?
>
> /* The unnecessary pointer compare is there
>   * to check for type safety (n must be 64bit)
>   */
>

Yes.

> But stddev is s64. Ah, but the compare is:
>
> (void)(((typeof((n)) *)0) == ((uint64_t *)0));
>
> so it's complaining about a signed verses unsigned compare, not length.
> I think I can ignore this warning then.

The pedant in me thinks that you should fix your code if using do_div() 
on a signed object is undefined.  But if you aren't planning on merging 
the code, then it probably doesn't matter.

>
> Thoughts?

I think I will have lunch now...

David Daney

>
