Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Apr 2015 14:54:36 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:47193 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010573AbbDGMyeDLE7g (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Apr 2015 14:54:34 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t37CsYc6031695;
        Tue, 7 Apr 2015 14:54:34 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t37CsYq6031694;
        Tue, 7 Apr 2015 14:54:34 +0200
Date:   Tue, 7 Apr 2015 14:54:34 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 47/48] MIPS: Respect the ISA level in FCSR handling
Message-ID: <20150407125434.GA27914@linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
 <alpine.LFD.2.11.1504032248160.21028@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.11.1504032248160.21028@eddie.linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46802
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Fri, Apr 03, 2015 at 11:27:48PM +0100, Maciej W. Rozycki wrote:
> Date:   Fri, 3 Apr 2015 23:27:48 +0100 (BST)

> Index: linux/arch/mips/include/asm/fpu.h
> ===================================================================
> --- linux.orig/arch/mips/include/asm/fpu.h	2015-04-02 20:18:47.499480000 +0100
> +++ linux/arch/mips/include/asm/fpu.h	2015-04-02 20:27:59.745241000 +0100
> @@ -14,6 +14,7 @@
>  #include <linux/thread_info.h>
>  #include <linux/bitops.h>
>  
> +#include <asm/current.h>
>  #include <asm/mipsregs.h>
>  #include <asm/cpu.h>
>  #include <asm/cpu-features.h>

This is adding a 2nd inclusion of <asm/current.h>.  Will fix that.

  Ralf
