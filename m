Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 May 2011 19:39:18 +0200 (CEST)
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:50387 "EHLO
        cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491005Ab1EDRjP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 May 2011 19:39:15 +0200
Received: from [10.37.7.18] ([10.37.7.18])
        by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id p44HK3F9001742;
        Wed, 4 May 2011 18:20:03 +0100 (BST)
Subject: Re: [PATCH] atomic: add *_dec_not_zero
From:   Will Deacon <will.deacon@arm.com>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mips@linux-mips.org, linux-m32r@ml.linux-m32r.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-cris-kernel@axis.com, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, x86@kernel.org,
        Chris Metcalf <cmetcalf@tilera.com>,
        David Howells <dhowells@redhat.com>,
        linux-m68k@vger.kernel.org, linux-am33-list@redhat.com,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <1304458235-28473-1-git-send-email-sven@narfation.org>
References: <1304458235-28473-1-git-send-email-sven@narfation.org>
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 04 May 2011 18:27:36 +0100
Message-ID: <1304530056.2296.1.camel@craptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Content-Transfer-Encoding: 7bit
Return-Path: <will.deacon@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29817
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: will.deacon@arm.com
Precedence: bulk
X-list: linux-mips

On Tue, 2011-05-03 at 22:30 +0100, Sven Eckelmann wrote:
> Introduce an *_dec_not_zero operation.  Make this a special case of
> *_add_unless because batman-adv uses atomic_dec_not_zero in different
> places like re-broadcast queue or aggregation queue management. There
> are other non-final patches which may also want to use this macro.
> 
For the ARM changes:

Acked-by: Will Deacon <will.deacon@arm.com>

Cheers,

Will
