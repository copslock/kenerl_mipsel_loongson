Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 May 2017 04:23:18 +0200 (CEST)
Received: from mail-pf0-x244.google.com ([IPv6:2607:f8b0:400e:c00::244]:33242
        "EHLO mail-pf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990686AbdEZCXLf1Goo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 May 2017 04:23:11 +0200
Received: by mail-pf0-x244.google.com with SMTP id f27so42730508pfe.0;
        Thu, 25 May 2017 19:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2i1ytBHt6rFwJC8W8H5vRhk7sUMpAsu0wek4DcdQTGo=;
        b=DmZc4sHUumcGxLNTSKZqNefIVv5eqAjBkuotxIUaD6W/oSudNcd9EF8y9KtkDr9kiE
         PcK416e2eHbIxrTOEp0/0qyQc4TPKYaolb+MHpn3trEncjN4pUcFt40XdveAmMGNXFbC
         09LM5IP5wNqRaYrkh2v/bckKnRGEnQI/oZ4QTg8SUuTuRyYWlgrS1BaFOnFsn8e1WxKX
         xoMk6EBEXCpuVhml7TKdckAgpVIXPHlZoqvwQBQwxn5wUPZ57gwdeQDM4bjX5k7o1DGX
         ArqwXylK40MrT9qR5PTZhUrXMybGrK25dQs209ShiOJRBFGELmatpPdRpCrVoqNeOEWb
         i0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2i1ytBHt6rFwJC8W8H5vRhk7sUMpAsu0wek4DcdQTGo=;
        b=hidWWe6wLrlbxfBFtUQ3wjXOo4ZHs4chNv63ZRyeXR3xAD16FBiFprADfJ8PpLmwEf
         r5Vn/9zpO45MS6eLjpw73oA7HnsaUCzJ3rVqbKCNIpk9METX/Y44pJnV6Fa3u6cnBdIH
         BKygDmdJs/8skDyjP3oPepjUvom0E9OAsWIVsgjHcO5fvOKBglS3q7Aw9PqQJl0XZq1x
         trSAvTIqK+HzvLyVcPYOgJZ3TFutqPU0QNmyVx3GDIipRF5htT77PvdSaeN5uJdVfoaL
         s5lET/1kdYws+C6kz+NH2PyiZbVw+4vsnOlGrpVuIJSmgUsM8LWhAZ2ZE577glU97c6W
         EAwg==
X-Gm-Message-State: AODbwcDLddWigxqT2e02j0C4dGxzWybPQBry0l+ZLELZSPZyWuFQqbqd
        qikeCTQEmolVVQ==
X-Received: by 10.84.224.4 with SMTP id r4mr54589096plj.173.1495765385586;
        Thu, 25 May 2017 19:23:05 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:180::1:7abe])
        by smtp.gmail.com with ESMTPSA id p9sm16431212pfd.35.2017.05.25.19.23.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 19:23:04 -0700 (PDT)
Date:   Thu, 25 May 2017 19:23:02 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     David Daney <david.daney@cavium.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org, Markos Chandras <markos.chandras@imgtec.com>
Subject: Re: [PATCH 5/5] MIPS: Add support for eBPF JIT.
Message-ID: <20170526022300.c4gtxhqt3tyiukz2@ast-mbp>
References: <20170526003826.10834-1-david.daney@cavium.com>
 <20170526003826.10834-6-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170526003826.10834-6-david.daney@cavium.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Return-Path: <alexei.starovoitov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58014
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexei.starovoitov@gmail.com
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

On Thu, May 25, 2017 at 05:38:26PM -0700, David Daney wrote:
> Since the eBPF machine has 64-bit registers, we only support this in
> 64-bit kernels.  As of the writing of this commit log test-bpf is showing:
> 
>   test_bpf: Summary: 316 PASSED, 0 FAILED, [308/308 JIT'ed]
> 
> All current test cases are successfully compiled.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  arch/mips/Kconfig       |    1 +
>  arch/mips/net/bpf_jit.c | 1627 ++++++++++++++++++++++++++++++++++++++++++++++-
>  arch/mips/net/bpf_jit.h |    7 +
>  3 files changed, 1633 insertions(+), 2 deletions(-)

Great stuff. I wonder what is the performance difference
interpreter vs JIT

> + * eBPF stack frame will be something like:
> + *
> + *  Entry $sp ------>   +--------------------------------+
> + *                      |   $ra  (optional)              |
> + *                      +--------------------------------+
> + *                      |   $s0  (optional)              |
> + *                      +--------------------------------+
> + *                      |   $s1  (optional)              |
> + *                      +--------------------------------+
> + *                      |   $s2  (optional)              |
> + *                      +--------------------------------+
> + *                      |   $s3  (optional)              |
> + *                      +--------------------------------+
> + *                      |   tmp-storage  (if $ra saved)  |
> + * $sp + tmp_offset --> +--------------------------------+ <--BPF_REG_10
> + *                      |   BPF_REG_10 relative storage  |
> + *                      |    MAX_BPF_STACK (optional)    |
> + *                      |      .                         |
> + *                      |      .                         |
> + *                      |      .                         |
> + *     $sp -------->    +--------------------------------+
> + *
> + * If BPF_REG_10 is never referenced, then the MAX_BPF_STACK sized
> + * area is not allocated.
> + */

It's especially great to see that you've put the tmp storage
above program stack and made the stack allocation optional.
At the moment I'm working on reducing bpf program stack size,
so that JIT and interpreter can use only the stack they need.
Looking at this JIT code only minimal changes will be needed.
