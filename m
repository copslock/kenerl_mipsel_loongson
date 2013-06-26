Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jun 2013 01:55:57 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:50352 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6835001Ab3FZXzuDCCyu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Jun 2013 01:55:50 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5QNtaCF004828;
        Thu, 27 Jun 2013 01:55:36 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5QNtZnb004827;
        Thu, 27 Jun 2013 01:55:35 +0200
Date:   Thu, 27 Jun 2013 01:55:35 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>,
        Jonas Gorski <jogo@openwrt.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>
Subject: Re: [PATCH 3/3] MIPS: Only set cpu_has_mmips if
 SYS_SUPPORTS_MICROMIPS
Message-ID: <20130626235535.GO7171@linux-mips.org>
References: <1369432450-13583-1-git-send-email-ddaney.cavm@gmail.com>
 <1369432450-13583-4-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1369432450-13583-4-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37159
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

On Fri, May 24, 2013 at 02:54:10PM -0700, David Daney wrote:

> From: David Daney <david.daney@cavium.com>
> 
> As Jonas Gorske said in his patch:
> 
>    Disable cpu_has_mmips for everything but SEAD3 and MALTA. Most of
>    these platforms are from before the micromips introduction, so they
>    are very unlikely to implement it.
> 
>    Reduces an -Os compiled, uncompressed kernel image by 8KiB for
>    BCM63XX.
> 
> This patch taks a different approach than his, we gate the runtime
> test for microMIPS by the config symbol SYS_SUPPORTS_MICROMIPS.

Sounds like a good approach also for other ASEs.

Applied.

  Ralf
