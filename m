Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Sep 2013 16:07:32 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:55816 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823977Ab3ISOH1D1fFJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 Sep 2013 16:07:27 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r8JE7QGC026615;
        Thu, 19 Sep 2013 16:07:26 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r8JE7QhG026614;
        Thu, 19 Sep 2013 16:07:26 +0200
Date:   Thu, 19 Sep 2013 16:07:26 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Felix Fietkau <nbd@openwrt.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v3 1/3] MIPS: remove unnecessary platform dma helper
 functions
Message-ID: <20130919140726.GD22468@linux-mips.org>
References: <1376558912-41050-1-git-send-email-nbd@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1376558912-41050-1-git-send-email-nbd@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37883
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

On Thu, Aug 15, 2013 at 11:28:30AM +0200, Felix Fietkau wrote:
> Date:   Thu, 15 Aug 2013 11:28:30 +0200
> From: Felix Fietkau <nbd@openwrt.org>
> To: linux-mips@linux-mips.org
> Subject: [PATCH v3 1/3] MIPS: remove unnecessary platform dma helper
>  functions
> 
> The semantics stay the same - on Cavium Octeon the functions were dead
> code (it overrides the MIPS DMA ops) - on other platforms they contained
> no code at all.

Queued for 3.13.

Thanks,

  Ralf
