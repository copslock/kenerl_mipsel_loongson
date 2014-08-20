Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Aug 2014 12:54:03 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:35789 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6855389AbaHTKyAw3PTz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Aug 2014 12:54:00 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s7KArxT8023247;
        Wed, 20 Aug 2014 12:53:59 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s7KArw6B023246;
        Wed, 20 Aug 2014 12:53:58 +0200
Date:   Wed, 20 Aug 2014 12:53:57 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     chenj <chenj@lemote.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     linux-mips@linux-mips.org, chenhc@lemote.com
Subject: Re: [PATCH] mips: define _MIPS_ARCH_LOONGSON3A for Loongson3
Message-ID: <20140820105356.GA21497@linux-mips.org>
References: <1408504488-12319-1-git-send-email-chenj@lemote.com>
 <1408504488-12319-2-git-send-email-chenj@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1408504488-12319-2-git-send-email-chenj@lemote.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42161
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

On Wed, Aug 20, 2014 at 11:14:48AM +0800, chenj wrote:

> +cflags-$(CONFIG_CPU_LOONGSON3)  += -D_MIPS_ARCH_LOONGSON3A

The _MIPS_ARCH_* namespace belongs to GCC.  While it seems current GCC
does not define this symbol _MIPS_ARCH_LOONGSON3A runs into the danger
of causing a conflict when GCC eventually will define the symbol.

  Ralf
