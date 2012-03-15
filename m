Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Mar 2012 17:26:09 +0100 (CET)
Received: from moutng.kundenserver.de ([212.227.126.171]:55143 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903652Ab2COQ0F (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Mar 2012 17:26:05 +0100
Received: from klappe2.localnet (deibp9eh1--blueice3n2.emea.ibm.com [195.212.29.180])
        by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
        id 0MU8aj-1RiC9E1YrB-00QnET; Thu, 15 Mar 2012 17:25:34 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH v3] ipc: provide generic compat versions of IPC syscalls
Date:   Thu, 15 Mar 2012 16:25:32 +0000
User-Agent: KMail/1.12.2 (Linux/3.3.0-rc1; KDE/4.3.2; x86_64; ; )
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christoph Hellwig <hch@lst.de>,
        Lucas De Marchi <lucas.demarchi@profusion.mobi>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "J. Bruce Fields" <bfields@redhat.com>, NeilBrown <neilb@suse.de>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org
References: <201112091536.pB9Fa5f7002738@farm-0002.internal.tilera.com> <201112122148.pBCLmPH0023959@farm-0002.internal.tilera.com> <4F6144B8.5010601@tilera.com>
In-Reply-To: <4F6144B8.5010601@tilera.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201203151625.32199.arnd@arndb.de>
X-Provags-ID: V02:K0:P922dHs4wgmggE20Dch8pBF3qhCaJX1GxSiX7E9IPrx
 qxDSkpPXcAq2EXTxEFd4VS8+lQXRvQe06szjqLZYCxPQrSdSSb
 l9QB9361pLH6sbIInR7ci1YdIR0GFrkf2PUZdmdRjzaUgS77Nc
 ZaAVNKopiv8vF4f9dnx2tq46V9gq066lzoPTcWSUx9b+gwNqdA
 de2VQRmPfA1z+FE7Ta4Qdl8cky3gzfiTZBfsEafrVJXz+Cfq+/
 dJMEI/ZAKIBN6gp9qySJhIVnoYtKmisNitvEF8Kph1ldmZKLkY
 GIBgwG2rcENWEk1Gg11WEJjfkVe7/rrHRvJbeeipdKo2GOeEwf
 trtVmexyROrYsqycmwL0=
X-archive-position: 32711
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thursday 15 March 2012, Chris Metcalf wrote:
> 
> Somewhat belatedly, I'm looking to push this through the "tile" tree. 
> Andrew Morton has been keeping it in his tree but I figure I should push it
> since it directly affects "tile" and currently no one else.

Sounds good.

> However, it would be nice if anyone could provide a Reviewed-by or Acked-by
> on the patch.  Thanks!

As the main author of ipc/compat.c in its current form,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
