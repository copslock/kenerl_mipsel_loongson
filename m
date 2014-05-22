Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 May 2014 17:25:20 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:56558 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6815784AbaEVPZSsYfq1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 May 2014 17:25:18 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s4MFPGjT016706;
        Thu, 22 May 2014 17:25:16 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s4MFPAGZ016705;
        Thu, 22 May 2014 17:25:10 +0200
Date:   Thu, 22 May 2014 17:25:10 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Bolle <pebolle@tiscali.nl>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: remove checks for CONFIG_SGI_IP35
Message-ID: <20140522152510.GD17197@linux-mips.org>
References: <1400584909.4912.35.camel@x220>
 <20140522131243.GZ10287@linux-mips.org>
 <1400767088.16407.14.camel@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1400767088.16407.14.camel@x220>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40245
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

On Thu, May 22, 2014 at 03:58:08PM +0200, Paul Bolle wrote:

> By the way, could you perhaps look at CONFIG_SYS_HAS_CPU_RM9000? It
> seems the Kconfig entry for SYS_HAS_CPU_RM9000 is simply missing. But
> the CPU support code is rather complicated and I stopped trying to
> understand it after staring at it for way too long.

Seem that crept back in through commit 69f24d17 [MIPS: Optimize
current_cpu_type() for better code.] which had been developed before
but merged after RM9000 was removed.

There were various other artifacts of the RM9000 support around which I
also removed.  Only a few comments and PRID_IMP_RM9000 which helps
avoid accidental reuse of the value are now remaining.

  Ralf
