Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Feb 2012 03:12:32 +0100 (CET)
Received: from mail1.windriver.com ([147.11.146.13]:51396 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903695Ab2BUCM2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Feb 2012 03:12:28 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
        by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q1L2CEc2016165
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 20 Feb 2012 18:12:15 -0800 (PST)
Received: from [128.224.162.71] (128.224.162.71) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.1.255.0; Mon, 20 Feb 2012
 18:12:14 -0800
Message-ID: <4F42FD60.4090201@windriver.com>
Date:   Tue, 21 Feb 2012 10:11:44 +0800
From:   "tiejun.chen" <tiejun.chen@windriver.com>
User-Agent: Thunderbird 2.0.0.24 (X11/20101027)
MIME-Version: 1.0
To:     Mikael Starvik <mikael.starvik@axis.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: SMP MIPS and Linux 3.2
References: <4BEA3FF3CAA35E408EA55C7BE2E61D055C769FECBC@xmail3.se.axis.com>
In-Reply-To: <4BEA3FF3CAA35E408EA55C7BE2E61D055C769FECBC@xmail3.se.axis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-archive-position: 32491
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiejun.chen@windriver.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Mikael Starvik wrote:
> I'm running Linux 3.2 on a MIPS 34K with two VPEs (in MT_SMP configuration). It works fine in UP but with SMP it deadlocks during bootup (both CPUs gets idle). Typically like this:
> 
> [��� 0.090000] CPU revision is: 01019550 (MIPS 34Kc)
> [��� 0.090000] Primary instruction cache 32kB, VIPT, 4-way, linesize 32 bytes.
> [��� 0.090000] Primary data cache 32kB, 4-way, PIPT, no aliases, linesize 32 bytes
> [��� 0.170000] Brought up 2 CPUs
> <No more output>
> 
> I have tried to enable __ARCH_WANT_INTERRUPTS_ON_CTXSW but that didn't improve anything. Anyone else got this running or have any thoughts about what the problem may be?
> 

I think using git-bisect is the simplest way to figure out this if you already
know one kernel version is fine for mips 34kc.

Or did you try to pass 'nosmp' into the kernel command line? If good maybe
you're hitting some locking issues. You can enable those Kconfig options to
probe-to-debug these locking problem.

Tiejun
