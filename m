Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 May 2011 14:09:32 +0200 (CEST)
Received: from usmamail.tilera.com ([206.83.70.75]:62377 "EHLO
        USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1490998Ab1EDMJ3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 May 2011 14:09:29 +0200
Received: from [127.0.0.1] (24.34.76.130) by USMAExch2.tad.internal.tilera.com
 (10.3.0.33) with Microsoft SMTP Server id 14.0.694.0; Wed, 4 May 2011
 08:09:20 -0400
Message-ID: <4DC141EC.5050406@tilera.com>
Date:   Wed, 4 May 2011 08:09:16 -0400
From:   Chris Metcalf <cmetcalf@tilera.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To:     Sven Eckelmann <sven@narfation.org>
CC:     <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, <x86@kernel.org>,
        <linux-alpha@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <uclinux-dist-devel@blackfin.uclinux.org>,
        <linux-cris-kernel@axis.com>, <linux-ia64@vger.kernel.org>,
        <linux-m32r@ml.linux-m32r.org>, <linux-m68k@lists.linux-m68k.org>,
        <linux-mips@linux-mips.org>, <linux-am33-list@redhat.com>,
        <linux-parisc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-s390@vger.kernel.org>, <linux-sh@vger.kernel.org>,
        <sparclinux@vger.kernel.org>, <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] atomic: add *_dec_not_zero
References: <1304458235-28473-1-git-send-email-sven@narfation.org>
In-Reply-To: <1304458235-28473-1-git-send-email-sven@narfation.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-Path: <cmetcalf@tilera.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29814
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cmetcalf@tilera.com
Precedence: bulk
X-list: linux-mips

On 5/3/2011 5:30 PM, Sven Eckelmann wrote:
> Introduce an *_dec_not_zero operation.  Make this a special case of
> *_add_unless because batman-adv uses atomic_dec_not_zero in different
> places like re-broadcast queue or aggregation queue management. There
> are other non-final patches which may also want to use this macro.
>
> Reported-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> [...]
>  arch/tile/include/asm/atomic.h     |    9 +++++++++
>  arch/tile/include/asm/atomic_32.h  |    1 +

Acked-by: Chris Metcalf <cmetcalf@tilera.com>

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
