Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 May 2014 00:05:06 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:58163 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822096AbaEFWFDCmaJH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 May 2014 00:05:03 +0200
Date:   Tue, 6 May 2014 23:05:02 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Alessandro Zummo <a.zummo@towertech.it>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        rtc-linux@googlegroups.com, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [rtc-linux] [PATCH 1/2] RTC: rtc-cmos: drivers/char/rtc.c features
 for DECstation support
In-Reply-To: <20140506115458.4010da2e@linux.lan.towertech.it>
Message-ID: <alpine.LFD.2.11.1405062258130.21408@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1404192224250.11598@eddie.linux-mips.org> <20140506115458.4010da2e@linux.lan.towertech.it>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40036
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Tue, 6 May 2014, Alessandro Zummo wrote:

> > This brings in drivers/char/rtc.c functionality required for DECstation 
> > and, should the maintainers decide to switch, Alpha systems to use 
> > rtc-cmos.
> 
>  Seems sane. We need to be sure it doesn't break anything
>  on non-Alpha machines. Did you test it on x86? It would be fine if
>  we can get a couple of Tested-by:

 Thanks for your review.  I can't test x86 easily/immediately, but I'll 
see what I can do, and will also appreciate if people can check that this 
change didn't cause any regressions.  Also Andrew was kind enough to pull 
this patch into his -mm tree, so hopefully any breakage will show up soon.

  Maciej
