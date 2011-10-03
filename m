Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Oct 2011 23:45:08 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:48848 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491907Ab1JCVpC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Oct 2011 23:45:02 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1RAqJY-0007rh-K9; Mon, 03 Oct 2011 23:44:44 +0200
Date:   Mon, 3 Oct 2011 23:44:43 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Venkat Subbiah <venkat.subbiah@caviumnetworks.com>
cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-rt-users@vger.kernel.org, david.daney@cavium.com
Subject: Re: [PATCH] MIPS: Octeon: Mark SMP-IPI interrupt as IRQF_NO_THREAD
In-Reply-To: <1317673870-10671-1-git-send-email-venkat.subbiah@caviumnetworks.com>
Message-ID: <alpine.LFD.2.02.1110032344240.1489@ionos>
References: <1317673870-10671-1-git-send-email-venkat.subbiah@caviumnetworks.com>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
X-archive-position: 31205
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1586



On Mon, 3 Oct 2011, Venkat Subbiah wrote:

> From: Venkat Subbiah <venkat.subbiah@cavium.com>
> 
> This is to exclude it from force threading to allow RT patch set to work.
> And while on this line
> * Remove IRQF_DISABLED as as this flag is NOOP
> * Add IRQF_PERCPU as this is a per cpu interrupt.
> 
> 
> Signed-off-by: Venkat Subbiah <venkat.subbiah@cavium.com>
> Acked-by: David Daney <david.daney@cavium.com>

Acked-by: Thomas Gleixner <tglx@linutronix.de>
