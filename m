Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Nov 2011 17:47:21 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:34011 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903668Ab1KHQrR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Nov 2011 17:47:17 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pA8GlDf6014317;
        Tue, 8 Nov 2011 16:47:13 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pA8GlCM0014315;
        Tue, 8 Nov 2011 16:47:12 GMT
Date:   Tue, 8 Nov 2011 16:47:12 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     linux-mips@linux-mips.org,
        Maksim Rayskiy <maksim.rayskiy@gmail.com>,
        "Kevin D. Kissell" <kevink@paralogos.com>,
        Sergey Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH RESEND 1/9] MIPS: Add local_flush_tlb_all_mm to clear all
 mm contexts on calling cpu
Message-ID: <20111108164711.GA13937@linux-mips.org>
References: <c2c8833593cb8eeef5c102468e105497@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2c8833593cb8eeef5c102468e105497@localhost>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31430
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6904

On Sat, Nov 05, 2011 at 02:21:10PM -0700, Kevin Cernekee wrote:

> +void local_flush_tlb_all_mm(void)
> +{
> +	struct task_struct *p;
> +
> +	for_each_process(p)
> +		if (p->mm)
> +			local_flush_tlb_mm(p->mm);

Aside of for_each_process being a potencially very heavy iterator - there
can be thousands of threads on some systems, even embedded systems I'm
missing the task_list lock being taken so bad things could happen.

  Ralf
