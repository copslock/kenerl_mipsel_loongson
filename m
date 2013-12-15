Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Dec 2013 11:37:21 +0100 (CET)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33319 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822146Ab3LOKhJoE9sq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 15 Dec 2013 11:37:09 +0100
Received: by mail-pa0-f49.google.com with SMTP id kx10so1733316pab.8
        for <multiple recipients>; Sun, 15 Dec 2013 02:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=C1QCmOuoDFf3toFrGAN0M2g41dYFvFZiRa9qL58m5gU=;
        b=VQiY7rEwiyOptXg+h+ckQhtOxXsa3HanX5V6jwpihI04ogI4Cr8nmS3NA1RkC9Us/R
         sD1ZwaXxJkiwSW43q84nYicPUAkwuCmmQakUrST7oPFdltMFQTqcpawS8PQFWZezAUKS
         Ya+kFbYYpzHiHGT4gd0DVFMK2S2yFcEDprfv73U55tNH5d+km7veka3jz13O0+2J+uKM
         CSoa0PbP/CeePH+y+/sh+uO9lfV4TuBluq27X8clbk3oWpq8iJxUY1dhIeZb/sxyrUbM
         PMER+mwImWchO8nv4T8cQ3VVAc1UhvP8sseUTfxBSoCIRmdgjE5vkH0FX9fFbNTDukhU
         gKaw==
X-Received: by 10.68.91.131 with SMTP id ce3mr337417pbb.19.1387103822839;
        Sun, 15 Dec 2013 02:37:02 -0800 (PST)
Received: from mailhub.coreip.homeip.net (c-67-188-112-76.hsd1.ca.comcast.net. [67.188.112.76])
        by mx.google.com with ESMTPSA id pe3sm18162488pbc.23.2013.12.15.02.37.00
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 15 Dec 2013 02:37:02 -0800 (PST)
Date:   Sun, 15 Dec 2013 02:36:57 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Mark Salter <msalter@redhat.com>, linux-kernel@vger.kernel.org,
        Richard Henderson <rth@twiddle.net>,
        linux-alpha@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, Paul Mundt <lethal@linux-sh.org>,
        linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: Re: [PATCH 10/10] Kconfig: cleanup SERIO_I8042 dependencies
Message-ID: <20131215103657.GB20197@core.coreip.homeip.net>
References: <1387040376-26906-1-git-send-email-msalter@redhat.com>
 <1387040376-26906-11-git-send-email-msalter@redhat.com>
 <52ACA43F.2040402@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52ACA43F.2040402@zytor.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dmitry.torokhov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38703
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitry.torokhov@gmail.com
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

On Sat, Dec 14, 2013 at 10:32:31AM -0800, H. Peter Anvin wrote:
> On 12/14/2013 08:59 AM, Mark Salter wrote:
> > Remove messy dependencies from SERIO_I8042 by having it depend on one
> > Kconfig symbol (ARCH_MIGHT_HAVE_PC_SERIO) and having architectures
> > which need it select ARCH_MIGHT_HAVE_PC_SERIO in arch/*/Kconfig.
> > New architectures are unlikely to need SERIO_I8042, so this avoids
> > having an ever growing list of architectures to exclude.
> > 
> > Signed-off-by: Mark Salter <msalter@redhat.com>
> > CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > CC: Richard Henderson <rth@twiddle.net>
> > CC: linux-alpha@vger.kernel.org
> > CC: Russell King <linux@arm.linux.org.uk>
> > CC: linux-arm-kernel@lists.infradead.org
> > CC: Tony Luck <tony.luck@intel.com>
> > CC: Fenghua Yu <fenghua.yu@intel.com>
> > CC: linux-ia64@vger.kernel.org
> > CC: Ralf Baechle <ralf@linux-mips.org>
> > CC: linux-mips@linux-mips.org
> > CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > CC: Paul Mackerras <paulus@samba.org>
> > CC: linuxppc-dev@lists.ozlabs.org
> > CC: Paul Mundt <lethal@linux-sh.org>
> > CC: linux-sh@vger.kernel.org
> > CC: "David S. Miller" <davem@davemloft.net>
> > CC: sparclinux@vger.kernel.org
> > CC: Guan Xuetao <gxt@mprc.pku.edu.cn>
> > CC: Ingo Molnar <mingo@redhat.com>
> > CC: Thomas Gleixner <tglx@linutronix.de>
> > CC: "H. Peter Anvin" <hpa@zytor.com>
> > CC: x86@kernel.org
> 
> Acked-by: H. Peter Anvin <hpa@linux.intel.com>

How are we going to merge this? In bulk through input tree or peacemeal
through all arches first?

-- 
Dmitry
