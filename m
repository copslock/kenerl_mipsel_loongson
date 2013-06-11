Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jun 2013 17:42:56 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:49214 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6835172Ab3FKPlkp-52l (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Jun 2013 17:41:40 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5BFfWHo015321;
        Tue, 11 Jun 2013 17:41:32 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5BFfUol015320;
        Tue, 11 Jun 2013 17:41:30 +0200
Date:   Tue, 11 Jun 2013 17:41:29 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org, Michal Marek <mmarek@suse.cz>,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] MIPS: Kconfig: Set default value for the "Kernel code
 model"
Message-ID: <20130611154129.GD13126@linux-mips.org>
References: <1370944336-13703-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1370944336-13703-1-git-send-email-markos.chandras@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36836
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

On Tue, Jun 11, 2013 at 10:52:16AM +0100, Markos Chandras wrote:

(Adding the kconfig maintainer and mailing list to cc.)

> Certain randconfigs may not select neither CONFIG_32BIT nor
> CONFIG_64BIT which can lead to build problems and to the following
> Kbuild warning:
> 
> .config:154:warning: symbol value '' invalid for PHYSICAL_START
> 
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>

Systems are supposed to set if they support 32 bit kernels and/or 64 bit
kernels in arch/mips/Kconfig.  The behaviour you're reporting happens
if the default system (which happens to be SGI_IP22) supports both
kernel models, that is SYS_SUPPORTS_32BIT_KERNEL and
SYS_SUPPORTS_64BIT_KERNEL are set.  Then "make randconfig" will generate
a .config with neiher CONFIG_32BIT nor CONFIG_64BIT set.

Just defaulting to CONFIG_32BIT as in your patch
http://patchwork.linux-mips.org/patch/5377/ isn't really a good solution
because for some platforms 32 bit kernels, for others 64 bit kernels are
preferred so I tried to implement something like

choice
        prompt "Kernel code model"
        default 32BIT if SYS_32BIT_KERNEL_PREFERRED
        default 64BIT if SYS_64BIT_KERNEL_PREFERRED

and have individual platforms set their preferred kernel variant.  And
I got more odd Kconfig behaviour, getting both choice values 32BIT and
64BIT set for some platforms.

Another variant that only uses a single auxilliary symbol,
SYS_64BIT_KERNEL_PREFERRED like this:

choice
        prompt "Kernel code model"
        default 32BIT if !SYS_64BIT_KERNEL_PREFERRED
        default 64BIT if SYS_64BIT_KERNEL_PREFERRED

still results in

CONFIG_32BIT=y
CONFIG_64BIT=y

So I'm not quite certain how to obtain the desired behaviour - but I appears
highly unobvious to buggy on kconfig's side.

Michal, can you shed some light?

  Ralf
