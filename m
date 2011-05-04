Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 May 2011 13:06:02 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:39130 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491102Ab1EDLF7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 May 2011 13:05:59 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p44B2BXU005150;
        Wed, 4 May 2011 12:02:12 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p44B27JV005143;
        Wed, 4 May 2011 12:02:07 +0100
Date:   Wed, 4 May 2011 12:02:07 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Chris Metcalf <cmetcalf@tilera.com>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        uclinux-dist-devel@blackfin.uclinux.org,
        linux-cris-kernel@axis.com, linux-ia64@vger.kernel.org,
        linux-m32r@ml.linux-m32r.org, linux-m68k@vger.kernel.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] atomic: add *_dec_not_zero
Message-ID: <20110504110207.GA4243@linux-mips.org>
References: <1304458235-28473-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1304458235-28473-1-git-send-email-sven@narfation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29812
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 03, 2011 at 11:30:35PM +0200, Sven Eckelmann wrote:

>  arch/mips/include/asm/atomic.h     |    2 ++
>  arch/mips/include/asm/local.h      |    1 +

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
