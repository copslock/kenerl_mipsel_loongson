Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Apr 2016 12:58:49 +0200 (CEST)
Received: from mail-lf0-f51.google.com ([209.85.215.51]:34209 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007715AbcDAK6nlgCYY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Apr 2016 12:58:43 +0200
Received: by mail-lf0-f51.google.com with SMTP id c62so79115357lfc.1
        for <linux-mips@linux-mips.org>; Fri, 01 Apr 2016 03:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=L3l8/0OKQ96v4uobnDst3VKsvlFGNTMrRcb9MhOR7YU=;
        b=W8g/OpZvrTWN7APXPiUryBQSHQPx9tKzUEBgUQfiZ/BRqlHvmDpNfmuwOxcaxSFpzA
         8MBpG1sfKfx0I/2t8MgynAs0lvF9OuiFk78L4+1KHzl1qwcVSffPpTum0qBl+h6IoEOG
         cugM9aREbwWw42q3BGv/ek1xQUcgzTJFwFAkJNjboBp/PMS82qMOXUQ5ZGcIcGjurC2h
         k/vLdERl6+PU9WB5rxL9JJKK84ijlsZ+44cR29Oz6WHFb5T5IhYcShrKQbMwe83Ctc2f
         uhAyLtzcDPpNkomxWmgIhRoNTq9uChcv/GtQoXt39WsH3t/+Bjj4KLrpPUVbV0+s+xwh
         iz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=L3l8/0OKQ96v4uobnDst3VKsvlFGNTMrRcb9MhOR7YU=;
        b=LpfBsrq0EfMsuS2/pifFKZ8VIAmRt9xcezMrco6+vHKSPLxLGdwFC2rhMPl5WaTnz1
         1CEMpHS+eY38Tk5h0clh0F0SuQauWVFLcqpeOJ303qSGk2xPrEgfCorWeaxgoiycfJYT
         +acn5m+nqTRMk22I/N/aievNCjYI8eDTzUKEZXQ2IFJY+hBxKMqw+GJAE11102ROMXA/
         73LPiKKzQ18lrJYjhd25CNf5K0mVYBNfuBfd4EoyWFp36LvcXabeqgcynyzA+1j8UmlY
         0y62yEUflhhePcGSMQ5x3N7N4gbmyeYm0lCPJw1YCwVha92T3MkrleGHF5fw0MW4tDyw
         mghg==
X-Gm-Message-State: AD7BkJIBI++wpWga62os9yvcF0ESSYz7WqQvjRphto5VV77FkwZ5yXUFVBmd80eHahv5DA==
X-Received: by 10.25.82.203 with SMTP id g194mr1681102lfb.1.1459508317248;
        Fri, 01 Apr 2016 03:58:37 -0700 (PDT)
Received: from [192.168.4.126] ([31.173.81.54])
        by smtp.gmail.com with ESMTPSA id do4sm2066905lbc.35.2016.04.01.03.58.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 01 Apr 2016 03:58:35 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] perf tools: Hook up MIPS unwind and dwarf-regs in
 the Makefile
To:     Ralf Baechle <ralf@linux-mips.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Daney <david.daney@cavium.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Jiri Olsa <jolsa@redhat.com>, Wang Nan <wangnan0@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
References: <cover.1459501014.git.ralf@linux-mips.org>
 <a3a7e99203ceaf662dc61895418c76e837eaf6ab.1459501014.git.ralf@linux-mips.org>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <56FE545A.7090003@cogentembedded.com>
Date:   Fri, 1 Apr 2016 13:58:34 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.1
MIME-Version: 1.0
In-Reply-To: <a3a7e99203ceaf662dc61895418c76e837eaf6ab.1459501014.git.ralf@linux-mips.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52829
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 4/1/2016 11:56 AM, Ralf Baechle wrote:

> From: David Daney <david.daney@cavium.com>
>
> Define a new symbol (ARCH_SUPPORTS_LIBUNWIND) in config/Makefile.

    Eh? Where is it?

> Use this from x86 and MIPS to gate testing of libunwind.

    x86? Where?

> Signed-off-by: David Daney <david.daney@cavium.com>
> Cc: linux-mips@linux-mips.org
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> ---
>   tools/perf/config/Makefile | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/tools/perf/config/Makefile b/tools/perf/config/Makefile
> index f7d7f5a..713c69c 100644
> --- a/tools/perf/config/Makefile
> +++ b/tools/perf/config/Makefile
> @@ -51,6 +51,11 @@ ifeq ($(NO_PERF_REGS),0)
>     $(call detected,CONFIG_PERF_REGS)
>   endif
>
> +ifeq ($(ARCH),mips)
> +  NO_PERF_REGS := 0
> +  LIBUNWIND_LIBS = -lunwind -lunwind-mips
> +endif
> +
>   # So far there's only x86 and arm libdw unwind support merged in perf.
>   # Disable it on all other architectures in case libdw unwind
>   # support is detected in system. Add supported architectures

MBR, Sergei
