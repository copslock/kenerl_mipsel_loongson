Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 May 2018 14:28:07 +0200 (CEST)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:40732
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991783AbeEDM17ju0s9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 May 2018 14:27:59 +0200
Received: by mail-wm0-x243.google.com with SMTP id j5-v6so4451190wme.5;
        Fri, 04 May 2018 05:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bg0zRws3bmwlUdbJMEiWwnBUG1Kpfw+8l7KAdhGWjm8=;
        b=S9aHhC50r0ZoDfhdqwNcej25ok/IbuVWlScCHDYR8z05mY2BJY0Tu3IhbMq1S3S8P7
         LhKQMAaqy8s0CVkHQJL37FZvg/COad6sWGg1M97KaZZP8v3IODetIqprhIxGysIzw850
         WeC51w+bdYAdvunF0yZjRaFHQnBtjCPQDRZixdSFy139j9Gxl2quexw8JYq5mHxKsCIA
         iOewhNNn9GEeUyw58Gnmazv7Qoa2gBQP4VEWymThzMQKmq2d/RifCtK1DtIRDa73y8MI
         72oVNKSK8yrFLPFeY7kDGdY8sTBd76rjDWunjEOdFcomZLlGd3ctxlrDx87b6wvSZWib
         4Eng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bg0zRws3bmwlUdbJMEiWwnBUG1Kpfw+8l7KAdhGWjm8=;
        b=AjmiUme4J7Oz7HEWBT8gefeeXDgvGRRhCV96xHIbbAKB7q1+FiwTW5Ka4nSoyuVmJa
         vRBkTTrTmqPee4WYMs3KqFWlWUtYWgTOhxrw7Ngz/IBBuVC8QF4odJ+o7z8wJJKPB0GC
         GcI9+9GkcV16w7IyKoet1ymSRjPS45dTtHPjPhEaSeh7rZvV+/iibCak7cTZpyHW4T2U
         u0nc+8UNC8dLcyIAH9iEEe0NT8RSiYqPKNZRJznN12CweHO/ZoNol1sgcdbmySJGZpSc
         DHEpxnYzbyoEpG9M+Vr8QLO8ySgdjGIcijpX5Trev1JrZbbTt4uX492o9IcZLhJJCpi1
         iMWg==
X-Gm-Message-State: ALQs6tCzkjgpGE6bJpU+SLW8CNTtRmlSxzZPMeniaf3HC0jB5GqhtctS
        qJ6X581LFHi2VxvLJ8runI0=
X-Google-Smtp-Source: AB8JxZoWQn55TauI56QCwbIbaqvwMPX1pdLDtOqUrjYrEBNCzXBMQASJdZ7pA5K7z6CB3S5Kq8jTuA==
X-Received: by 10.28.225.86 with SMTP id y83mr11765204wmg.92.1525436874150;
        Fri, 04 May 2018 05:27:54 -0700 (PDT)
Received: from rric.localdomain (x4e37fc4f.dyn.telefonica.de. [78.55.252.79])
        by smtp.gmail.com with ESMTPSA id n143-v6sm2329581wmd.29.2018.05.04.05.27.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 May 2018 05:27:53 -0700 (PDT)
Date:   Fri, 4 May 2018 14:27:51 +0200
From:   Robert Richter <rric@kernel.org>
To:     Matt Redfearn <matt.redfearn@mips.com>
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Huacai Chen <chenhc@lemote.com>, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        oprofile-list@lists.sf.net
Subject: Re: [RFC PATCH] MIPS: Oprofile: Drop support
Message-ID: <20180504122750.GE4493@rric.localdomain>
References: <1524574554-7451-1-git-send-email-matt.redfearn@mips.com>
 <20180424130511.GB28813@saruman>
 <5e464a40-4e4d-dde4-b5b5-ceb637dc5f38@mips.com>
 <20180504093002.GC4493@rric.localdomain>
 <dd951d1e-206d-78dd-49ae-3a16cad9ebcc@mips.com>
 <20180504102600.GD4493@rric.localdomain>
 <294858af-9164-f0c3-62d3-d6b643e89e09@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <294858af-9164-f0c3-62d3-d6b643e89e09@mips.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <rric.net@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63868
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rric@kernel.org
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

On 04.05.18 12:03:12, Matt Redfearn wrote:
> >As said, oprofile version 0.9.x is still available for cpus that do
> >not support perf. What is the breakage?
> 
> The breakage I originally set out to fix was the MT support in perf.
> https://www.linux-mips.org/archives/linux-mips/2018-04/msg00259.html
> 
> Since the perf code shares so much copied code from oprofile, those same
> issues exist in oprofile and ought to be addressed. But as newer oprofile
> userspace does not use the (MIPS) kernel oprofile code, then we could,
> perhaps, just remove it (as per the RFC). That would break legacy tools
> (0.9.x) though...

Those support perf:

 (CPU_MIPS32 || CPU_MIPS64 || CPU_R10000 || CPU_SB1 || CPU_CAVIUM_OCTEON || CPU_XLP || CPU_LOONGSON3)

Here is the total list of CPU_*:

 $ git grep -h config.CPU_ arch/mips/ | sort -u | wc -l
 79

The comparisation might not be accurate, but at least gives a hint
that there are many cpus not supporting perf. You would drop profiling
support at al to them.

If it is too hard to also fix the oprofile code (code duplication
seems the main issue here), then it would be also ok to blacklist
newer cpus to enable oprofile kernel code (where it is broken).

-Robert
