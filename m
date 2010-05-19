Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 May 2010 12:24:08 +0200 (CEST)
Received: from www.tglx.de ([62.245.132.106]:40539 "EHLO www.tglx.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492274Ab0ESKYE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 May 2010 12:24:04 +0200
Received: from localhost (www.tglx.de [127.0.0.1])
        by www.tglx.de (8.13.8/8.13.8/TGLX-2007100201) with ESMTP id o4JANsWq031296
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 19 May 2010 12:23:54 +0200
Date:   Wed, 19 May 2010 12:23:53 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     David Daney <ddaney@caviumnetworks.com>
cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] MIPS: Don't overflow cevt-r4k.c calculations at high
 clock rates.
In-Reply-To: <1274220676-4562-1-git-send-email-ddaney@caviumnetworks.com>
Message-ID: <alpine.LFD.2.00.1005191223260.3368@localhost.localdomain>
References: <1274220676-4562-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: clamav-milter 0.95.3 at www.tglx.de
X-Virus-Status: Clean
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26764
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

On Tue, 18 May 2010, David Daney wrote:

> The 'mult' element of struct clock_event_device must never be wider
> than 32-bits.  If it were, it would get truncated when used by
> clockevent_delta2ns() when this calls do_div().
> 
> We meet the requirement by ensuring that the relationship:
> 
>  (mips_hpt_frequency >> (32 - shift)) < NSEC_PER_SEC
> 
> Always holds.

clocks_calc_mult_shift() is your friend :)

Thanks,

	tglx
