Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2015 20:52:14 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:19179 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026874AbbFBSnuOKBG4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jun 2015 20:43:50 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A41233E92F35A;
        Tue,  2 Jun 2015 19:43:35 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 2 Jun
 2015 19:43:39 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Tue, 2 Jun
 2015 19:43:38 +0100
Received: from [10.20.3.79] (10.20.3.79) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Tue, 2 Jun 2015
 11:43:37 -0700
Message-ID: <556DF959.1010704@imgtec.com>
Date:   Tue, 2 Jun 2015 11:43:37 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>,
        <benh@kernel.crashing.org>, <will.deacon@arm.com>,
        <linux-kernel@vger.kernel.org>, <ralf@linux-mips.org>,
        <markos.chandras@imgtec.com>, <macro@linux-mips.org>,
        <Steven.Hill@imgtec.com>, <alexander.h.duyck@redhat.com>,
        <davem@davemloft.net>
Subject: Re: [PATCH 2/3] MIPS: enforce LL-SC loop enclosing with SYNC (ACQUIRE
 and RELEASE)
References: <20150602000818.6668.76632.stgit@ubuntu-yegoshin> <20150602000943.6668.28434.stgit@ubuntu-yegoshin> <556D95DA.5090305@imgtec.com>
In-Reply-To: <556D95DA.5090305@imgtec.com>
Content-Type: multipart/alternative;
        boundary="------------090801090503060704020107"
X-Originating-IP: [10.20.3.79]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47800
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

--------------090801090503060704020107
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 06/02/2015 04:39 AM, James Hogan wrote:
> Hi Leonid,
>
> On 02/06/15 01:09, Leonid Yegoshin wrote:
>
>> CPUs may occasionally have problems in accordance with HW team.
> "have problems in accordance with HW team" is a bit confusing. What do
> you mean?

I wrote about memory barriers and problems may happens without it.
Some details from internal e-mail exchange:

-------------------------------------------

yes, it is possible for the stores to be observed out of order
The SC B can complete if it has ownership and the SW A is still
waiting for ownership.  This scenario was also possible on older
cores.

(snip)

-----Original Message-----
From: Leonid Yegoshin
Subject: more SYNC issues

...

I want to know - do XXXX orders stores without SYNC?

Let's consider a scenario:

SW    $0, A (cache miss)
...
LL    $1, B (cache hit)
..
SC    $1, B (cache hit again)
B        (is not taken!)
..
SYNC  0x10

Is it possible for other core to get new value of B before new value of A between SC-B and SYNC?
-------------------------------------------------------------

Another mail, another processor:

==========================================

Hi Leonid

I looked into the LSU RTL and I do not see speculation being blocked for 
younger loads following LL.

I also ran a testcase to confirm my observation:

LL  (cacheable)Miss

LW (cacheable)Miss, different cacheline

Miss request for LW goes out before the Miss request for LL, also the 
GPR updated for LW happens before the LL GPR update.
==========================================


> Actually *true*? P5600 you mean? Same in Kconfig help text. 

Yes, thank you, it is P5600 and I5600 doesn't exist.


> It feels wrong to be giving the user this option. Can't we just select
> WEAK_REORDERING_BEYOND_LLSC automatically based on the hardware that
> needs to be supported by the kernel configuration (e.g. CPU_MIPSR6 or
> CPU_MIPS32_R2)?

No, we can't - a lot of old processors are in-order and all of that is 
still MIPS R2.

>   Those who care about mips r2 performance on hardware
> which doesn't strictly need it can always speak up / add an exception.
>
> Out of interest, are futex operations safe with weak llsc ordering, on
> the premise that they're mainly used by userland so ordering with normal
> kernel accesses just doesn't matter in practice?

I think futex is used to communicate between user threads and problem is 
theoretically still here.

> This patch does 3 logically separable things:
> 1) add smp_release/smp_acquire based on MIPS_LIGHTWEIGHT_SYNC and weaken
> smp_store_release()/smp_load_acquire() to use them.
> 2) weaken llsc barriers when MIPS_LIGHTWEIGHT_SYNC.
> 3) the MIPS_ENFORCE_WEAK_REORDERING_BEYOND_LLSC Kconfig stuff (or
> whatever method to select WEAK_REORDERING_BEYOND_LLSC more often).
>
> Any reason not to split them, and give a clear description of each?
>
>

I don't see a reason to split it.

- Leonid.

--------------090801090503060704020107
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 06/02/2015 04:39 AM, James Hogan
      wrote:<br>
    </div>
    <blockquote cite="mid:556D95DA.5090305@imgtec.com" type="cite">
      <pre wrap="">Hi Leonid,

On 02/06/15 01:09, Leonid Yegoshin wrote:

</pre>
      <blockquote type="cite">
        <pre wrap="">CPUs may occasionally have problems in accordance with HW team.
</pre>
      </blockquote>
      <pre wrap="">
"have problems in accordance with HW team" is a bit confusing. What do
you mean?</pre>
    </blockquote>
    <br>
    I wrote about memory barriers and problems may happens without it.<br>
    Some details from internal e-mail exchange:<br>
    <br>
    -------------------------------------------<br>
    <pre wrap="">yes, it is possible for the stores to be observed out of order
The SC B can complete if it has ownership and the SW A is still
waiting for ownership.  This scenario was also possible on older
cores.

(snip)

-----Original Message-----
From: Leonid Yegoshin 
Subject: more SYNC issues

...

I want to know - do XXXX orders stores without SYNC?

Let's consider a scenario:

SW    $0, A (cache miss)
...
LL    $1, B (cache hit)
..
SC    $1, B (cache hit again)
B        (is not taken!)
..
SYNC  0x10

Is it possible for other core to get new value of B before new value of A between SC-B and SYNC? 
-------------------------------------------------------------

</pre>
    Another mail, another processor:<br>
    <br>
    ==========================================<br>
    <p class="MsoNormal">Hi Leonid<o:p></o:p></p>
    <p class="MsoNormal" style="line-height:13.0pt;background:white"><span
style="font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#333333"><o:p> </o:p></span><span
style="font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#333333">I
        looked into the LSU RTL and I do not see speculation being
        blocked for younger loads following LL.<o:p></o:p></span>
    </p>
    <p class="MsoNormal" style="line-height:13.0pt;background:white"><span
style="font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#333333"><o:p> </o:p></span><span
style="font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#333333">I
        also ran a testcase to confirm my observation:<o:p></o:p></span><span
style="font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#333333"><br>
      </span></p>
    <p class="MsoNormal" style="line-height:13.0pt;background:white"><span
style="font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#333333">LL
         (cacheable)</span><span
        style="font-size:10.0pt;font-family:Wingdings;color:#333333"> </span><span
style="font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#333333">
        Miss <o:p></o:p></span><span
style="font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#333333"></span></p>
    <p class="MsoNormal" style="line-height:13.0pt;background:white"><span
style="font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#333333">LW
        (cacheable)</span><span
        style="font-size:10.0pt;font-family:Wingdings;color:#333333"> </span><span
style="font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#333333">
        Miss, different cacheline </span><br>
    </p>
    <span style="font-size:10.0pt;font-family:Wingdings;color:#333333"></span><span
style="font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#333333">Miss
      request for LW goes out before the Miss request for LL, also the
      GPR updated for LW happens before the LL GPR update.</span><br>
    ==========================================<br>
    <br>
    <br>
    <blockquote cite="mid:556D95DA.5090305@imgtec.com" type="cite">
      Actually *true*?
      P5600 you mean?
      Same in Kconfig help text.
    </blockquote>
    <br>
    Yes, thank you, it is P5600 and I5600 doesn't exist.<br>
    <br>
    <br>
    <blockquote cite="mid:556D95DA.5090305@imgtec.com" type="cite">
      <pre wrap="">
It feels wrong to be giving the user this option. Can't we just select
WEAK_REORDERING_BEYOND_LLSC automatically based on the hardware that
needs to be supported by the kernel configuration (e.g. CPU_MIPSR6 or
CPU_MIPS32_R2)?</pre>
    </blockquote>
    <br>
    No, we can't - a lot of old processors are in-order and all of that
    is still MIPS R2.<br>
    <br>
    <blockquote cite="mid:556D95DA.5090305@imgtec.com" type="cite">
      <pre wrap=""> Those who care about mips r2 performance on hardware
which doesn't strictly need it can always speak up / add an exception.

Out of interest, are futex operations safe with weak llsc ordering, on
the premise that they're mainly used by userland so ordering with normal
kernel accesses just doesn't matter in practice?</pre>
    </blockquote>
    <br>
    I think futex is used to communicate between user threads and
    problem is theoretically still here.<br>
    <br>
    <blockquote cite="mid:556D95DA.5090305@imgtec.com" type="cite">
      <pre wrap="">
This patch does 3 logically separable things:
1) add smp_release/smp_acquire based on MIPS_LIGHTWEIGHT_SYNC and weaken
smp_store_release()/smp_load_acquire() to use them.
2) weaken llsc barriers when MIPS_LIGHTWEIGHT_SYNC.
3) the MIPS_ENFORCE_WEAK_REORDERING_BEYOND_LLSC Kconfig stuff (or
whatever method to select WEAK_REORDERING_BEYOND_LLSC more often).

Any reason not to split them, and give a clear description of each?


</pre>
    </blockquote>
    <br>
    I don't see a reason to split it.<br>
    <br>
    - Leonid.<br>
  </body>
</html>

--------------090801090503060704020107--
