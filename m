Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 May 2010 15:51:57 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:55737 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491796Ab0EUNvx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 21 May 2010 15:51:53 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o4LDpo2V013483;
        Fri, 21 May 2010 14:51:51 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o4LDpnuW013481;
        Fri, 21 May 2010 14:51:49 +0100
Date:   Fri, 21 May 2010 14:51:49 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] tx49xx: define ARCH_KMALLOC_MINALIGN
Message-ID: <20100521135148.GA13174@linux-mips.org>
References: <1274110685-13196-1-git-send-email-anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1274110685-13196-1-git-send-email-anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26778
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 18, 2010 at 12:38:05AM +0900, Atsushi Nemoto wrote:

> With SLAB, it works without ARCH_KMALLOC_MINALIGN, but with SLOB/SLUB,
> ARCH_KMALLOC_MINALIGN is required to ensure alignment of kmalloced
> buffer.

Thanks, applied.

  Ralf
