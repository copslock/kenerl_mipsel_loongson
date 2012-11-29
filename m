Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Nov 2012 00:00:53 +0100 (CET)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:61606 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6829667Ab2K2XAwvukM- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Nov 2012 00:00:52 +0100
Received: by mail-pa0-f49.google.com with SMTP id bi1so7182499pad.36
        for <multiple recipients>; Thu, 29 Nov 2012 15:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=5xzKw+iWWcJD3Le76aufZV0SsXcVuf+MKMQ2h+WjIqY=;
        b=pSXSqamcC7vLK3SekgCInmEJ47zmFYVNLzpQks8ZTHpPTAJOt9l4RF/FpUhHz5IZvk
         qp9dFNYylAU/4fEkDVPvTzkGVZZN+USBWhnQB+C9SL4mKRcbqRXEJzPaWqnW75pY35QG
         am+gncR0929ReBpSUM9XV6+Rz4Z9E0ZOx+W23d1uo/UZc49iLkr7T1PCZKwm5IXuIMDE
         oawt9YUfd3hCMFMtScoQ3TKlKeE+FZ3YbTiIT+ikiUi76Zp/ZEax2QSVhumLDFR0/Dut
         wSe3saLB0OzSG9930lNpNBiLXdJO7BXTLx0F/bUtpe+U3S3jLsB6daBWOu4mDi8qCp79
         ApDQ==
Received: by 10.68.239.198 with SMTP id vu6mr40861pbc.109.1354230046002;
        Thu, 29 Nov 2012 15:00:46 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id sw1sm1887562pbc.75.2012.11.29.15.00.44
        (version=SSLv3 cipher=OTHER);
        Thu, 29 Nov 2012 15:00:45 -0800 (PST)
Message-ID: <50B7E91C.6070403@gmail.com>
Date:   Thu, 29 Nov 2012 15:00:44 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     Alan Cooper <alcooperx@gmail.com>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: MIPS Function Tracer question
References: <CAOGqxeUOrVFoqsmUV19h5tXsD6pw5creXP9aN1C-V7K3WL2EXA@mail.gmail.com>
In-Reply-To: <CAOGqxeUOrVFoqsmUV19h5tXsD6pw5creXP9aN1C-V7K3WL2EXA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35154
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 11/29/2012 01:04 PM, Alan Cooper wrote:
> I've been doing some testing of the MIPS Function Tracer functionality
> on the 3.3 kernel. I was surprised to find that the option to generate
> frame pointers was required for tracing.

It is not really required for MIPS function tracing, but the Kconfigs 
for some reason set it.

>  When I don't enable
> FRAME_POINTER along with FUNCTION_TRACER, the kernel hangs on boot. I
> also noticed that a checkin to the 3.4 kernel
> (b732d439cb43336cd6d7e804ecb2c81193ef63b0) no longer forces on
> FRAME_POINTER when FUNCTION_TRACER is selected. I was wondering how it
> works in 3.4 and beyond, so I built a Malta kernel from the latest
> MIPS tree with FUNCTION_TRACING enabled and tested it with QEMU. The
> kernel hung the same way. I can think of 2 reasons for this:
> 1. Function tracing is broken for MIPS in 3.4 and beyond.
> 2. The 4.5.3 GNU C compiler I'm using is generating different code for
> function tracing.

Function tracing works best with recent versions of GCC (those that 
support -mmcount-ra-address).

> I was wondering if anyone has MIPS function tracing working in 3.4 or later?

Yes.  Using GCC 4.7.0 on an octeon kernel (based on 3.4.14):

# tracer: function_graph
#
# CPU  DURATION                  FUNCTION CALLS
# |     |   |                     |   |   |   |
   1)               |  __fsnotify_parent() {
   1)   7.154 us    |  } /* __fsnotify_parent */
   1)               |  fsnotify() {
   1)               |    __srcu_read_lock() {
   1)               |      add_preempt_count() {
   1)   1.356 us    |      } /* add_preempt_count */
   1)               |      sub_preempt_count() {
   1)   1.385 us    |      } /* sub_preempt_count */
   1)   6.747 us    |    } /* __srcu_read_lock */
   1)               |    __srcu_read_unlock() {
   1)               |      add_preempt_count() {
   1)   1.383 us    |      } /* add_preempt_count */
   1)               |      sub_preempt_count() {
   1)   1.358 us    |      } /* sub_preempt_count */
   1)   6.642 us    |    } /* __srcu_read_unlock */
   1) + 17.861 us   |  } /* fsnotify */
.
.
.



>
> I did figure out why it's hanging and I have some changes that will
> allow the function tracer to run without frame pointers, but before I
> proceed I want to rule out compiler differences.
>
> Thanks
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
