Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2014 19:12:26 +0200 (CEST)
Received: from mail-ie0-f169.google.com ([209.85.223.169]:46935 "EHLO
        mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822331AbaFERMYy0acr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Jun 2014 19:12:24 +0200
Received: by mail-ie0-f169.google.com with SMTP id rp18so1186761iec.28
        for <multiple recipients>; Thu, 05 Jun 2014 10:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=okWuRjB9FQx/Z6obFi7Wq0io4BTu16WKGLi0Qc1kJcs=;
        b=kjm4HeaC1oK3s1u/s4TTcPh0PhJMekpts9FXbWxLzCJ7v5G8Csva2teV4VL7Ul/6qC
         DzAPWXKTHUU2cmQkBtc41RO7G/o57HwhR79W5MjQYjXtWbvOw3TMDn+flJMm6BAtZ0iS
         oi0bK1AK1wIrqivPvvZdq6ll/TxFOvpLwljto7eNDHMunXBwM1scHyaPRI6PUDdtIj7P
         ESpi8OF0grfVOelfGV3PG7pSvuSLzkIfByUVZTuc4eZtdW3xvU/Ncooo80HfD4oynyN2
         XpD/ZTRpCETlKou6oM2rKm3DTOZH4rkEFOHN60fBFiUp0uV/g5fycI6EOJAPbnz2XAR7
         OJVg==
X-Received: by 10.50.20.97 with SMTP id m1mr14962ige.28.1401988338483;
        Thu, 05 Jun 2014 10:12:18 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id j1sm19860255ige.0.2014.06.05.10.12.17
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 05 Jun 2014 10:12:17 -0700 (PDT)
Message-ID: <5390A4F0.3000601@gmail.com>
Date:   Thu, 05 Jun 2014 10:12:16 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: gcc warning in my trace_benchmark() code
References: <20140605121204.18ee5f2d@gandalf.local.home>
In-Reply-To: <20140605121204.18ee5f2d@gandalf.local.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40441
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

On 06/05/2014 09:12 AM, Steven Rostedt wrote:
> I'm going through some of the warnings that Fengguang Wu's test bot has
> discovered, and one of them is from a MIPS allmodconfig build.
>
> https://lists.01.org/pipermail/kbuild-all/2014-May/004751.html
>
>     kernel/trace/trace_benchmark.c: In function 'trace_do_benchmark':
>>> kernel/trace/trace_benchmark.c:84:3: warning: comparison of distinct pointer types lacks a cast [enabled by default]
>>> kernel/trace/trace_benchmark.c:85:3: warning: comparison of distinct pointer types lacks a cast [enabled by default]
>     kernel/trace/trace_benchmark.c:38:6: warning: unused variable 'seedsq' [-Wunused-variable]
>
> vim +84 kernel/trace/trace_benchmark.c
>
>      78		if (bm_cnt > 1) {
>      79			/*
>      80			 * Apply Welford's method to calculate standard deviation:
>      81			 * s^2 = 1 / (n * (n-1)) * (n * \Sum (x_i)^2 - (\Sum x_i)^2)
>      82			 */
>      83			stddev = (u64)bm_cnt * bm_totalsq - bm_total * bm_total;
>    > 84			do_div(stddev, bm_cnt);
>    > 85			do_div(stddev, bm_cnt - 1);
>      86		} else
>      87			stddev = 0;
>      88	
>
>
>
> Is there something special with do_div in mips that I should be aware
> of?

Yes.  MIPS is using the implementation in asm-generic/div64.h,  which 
per the comments in that file has a useless pointer compare to find just 
this type of issue.


Ralf:  As a side note, while looking at arch/mips/include/asm/div64.h, I 
saw that the implementation of __div64_32 in that file will be unused, 
and is also completely broken due to the first parameter never being used.

David Daney
