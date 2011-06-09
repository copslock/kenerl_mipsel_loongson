Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2011 07:26:45 +0200 (CEST)
Received: from gate.crashing.org ([63.228.1.57]:56669 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490954Ab1FIF0m (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Jun 2011 07:26:42 +0200
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p5959YRR023762;
        Thu, 9 Jun 2011 00:09:34 -0500
Subject: Re: [patch 13/14] PCSPKR: Cleanup Kconfig dependencies
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     ralf@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20110601180610.984881988@duck.linux-mips.net>
References: <20110601180456.801265664@duck.linux-mips.net>
         <20110601180610.984881988@duck.linux-mips.net>
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 09 Jun 2011 15:09:32 +1000
Message-ID: <1307596172.2874.268.camel@pasglop>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.3 
Content-Transfer-Encoding: 7bit
X-archive-position: 30304
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: benh@kernel.crashing.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7553

On Wed, 2011-06-01 at 19:05 +0100, ralf@linux-mips.org wrote:
> plain text document attachment
> (i8253-use-aux-symbol-for-pcspkr-config.patch)
> Lenghty lists of the kind "depends on ARCH1 || ARCH2 ... || ARCH123" are
> usually either wrong or too coarse grained.  Or plain an ugly sin.

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> To: linux-kernel@vger.kernel.org
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: linuxppc-dev@lists.ozlabs.org
