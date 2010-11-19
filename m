Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Nov 2010 15:34:28 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:34312 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491875Ab0KSOeZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Nov 2010 15:34:25 +0100
Received: by bwz5 with SMTP id 5so4048862bwz.36
        for <multiple recipients>; Fri, 19 Nov 2010 06:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=QfppuqDMucQuvSJAK5drXEMCdaWXZKatI+E5xOBrIY8=;
        b=mrAAZllHeLDOHWKLvLpMgR9CIX70xYmLEheWqYbPYi719EP97fd0fkhc7dZaliVAxh
         7HPOOSYZI2ZvLfvYXbC0btjDtRX5bRyP0qqkOkq/uWLohDNq56aolpQtqcRdCEUb1/e9
         +whsvOQdSQ6WbUh1t0/Gln4TzFRo2Qc4rpw8c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AzOY2aM4+eGMCCQuAADWy6nZmxnNXguAxLc0yhVEX9oG+QBvFF2f9a3m+ZGVOgazr4
         ICfyGi6oywQzsuSOqmxi3LwWpBVzVTu9eTT/RPuclaKAM5rsGJvx0g/ZQ/19SUMd0o7i
         JkjkiVvQJcTmaswWiJ3K0P349OqcFf2cY5oCI=
Received: by 10.204.136.70 with SMTP id q6mr2120991bkt.208.1290177265312;
        Fri, 19 Nov 2010 06:34:25 -0800 (PST)
Received: from nowhere (p549AACDD.dip.t-dialin.net [84.154.172.221])
        by mx.google.com with ESMTPS id v20sm402564bku.22.2010.11.19.06.34.22
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 06:34:23 -0800 (PST)
Received: by nowhere (nbSMTP-1.00) for uid 1000
        (using TLSv1/SSLv3 with cipher RC4-MD5 (128/128 bits))
        fweisbec@gmail.com; Fri, 19 Nov 2010 15:34:23 +0100 (CET)
Date:   Fri, 19 Nov 2010 15:34:21 +0100
From:   Frederic Weisbecker <fweisbec@gmail.com>
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Cc:     ralf@linux-mips.org, a.p.zijlstra@chello.nl, will.deacon@arm.com,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        wuzhangjin@gmail.com, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com
Subject: Re: [PATCH 4/5] MIPS/Perf-events: Work with the new callchain
        interface
Message-ID: <20101119143416.GA5558@nowhere>
References: <1290063401-25440-1-git-send-email-dengcheng.zhu@gmail.com> <1290063401-25440-5-git-send-email-dengcheng.zhu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1290063401-25440-5-git-send-email-dengcheng.zhu@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <fweisbec@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28434
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fweisbec@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, Nov 18, 2010 at 02:56:40PM +0800, Deng-Cheng Zhu wrote:
> This is the MIPS part of the following commits by Frederic Weisbecker:
> 
> f72c1a931e311bb7780fee19e41a89ac42cab50e
> 	perf: Factorize callchain context handling
> 56962b4449af34070bb1994621ef4f0265eed4d8
> 	perf: Generalize some arch callchain code
> 70791ce9ba68a5921c9905ef05d23f62a90bc10c
> 	perf: Generalize callchain_store()
> c1a65932fd7216fdc9a0db8bbffe1d47842f862c
> 	perf: Drop unappropriate tests on arch callchains
> 
> Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
> ---


Acked-by: Frederic Weisbecker <fweisbec@gmail.com>

Why did I miss this arch? I did a grep on HAVE_PERF_EVENT or something,
may be it hadn't it at that time?

Thanks!
