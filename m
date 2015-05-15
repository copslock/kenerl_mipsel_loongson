Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2015 22:10:53 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:38453 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27026711AbbEOUKv1at1O (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 May 2015 22:10:51 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t4FKApfJ009142;
        Fri, 15 May 2015 22:10:51 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t4FKAink009141;
        Fri, 15 May 2015 22:10:44 +0200
Date:   Fri, 15 May 2015 22:10:44 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Nicholas Krause <xerofoify@gmail.com>
Cc:     akpm@linux-foundation.org, kumba@gentoo.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] mips:Fix build error for ip32_defconfig
 configuration
Message-ID: <20150515201044.GG2322@linux-mips.org>
References: <1431613217-2517-1-git-send-email-xerofoify@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1431613217-2517-1-git-send-email-xerofoify@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47416
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

On Thu, May 14, 2015 at 10:20:17AM -0400, Nicholas Krause wrote:

> This fixes the make error when building the ip32_defconfig
> configuration due to using sgio2_cmos_devinit rather then
> the correct function,sgio2_rtc_devinit in a device_initcall
> below this function's definition.

I've already applied Joshua Kinard's 
https://patchwork.linux-mips.org/patch/9787/ with a minor cosmetic
touchup.

  Ralf
