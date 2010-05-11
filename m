Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 May 2010 20:42:37 +0200 (CEST)
Received: from mail.gmx.net ([213.165.64.20]:36003 "HELO mail.gmx.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S1491942Ab0EKSme convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 May 2010 20:42:34 +0200
Received: (qmail invoked by alias); 11 May 2010 18:42:19 -0000
Received: from dslb-084-056-028-235.pools.arcor-ip.net (EHLO lamer.localnet) [84.56.28.235]
  by mail.gmx.net (mp004) with SMTP; 11 May 2010 20:42:19 +0200
X-Authenticated: #12255092
X-Provags-ID: V01U2FsdGVkX1/IvmtEpuzI/vNBXd0uWx3n38FlkPDZvnH6PzkcLx
        vq/2G2oDwrXpa8
From:   Peter =?iso-8859-1?q?H=FCwe?= <PeterHuewe@gmx.de>
To:     Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [PATCH] media/IR: Add missing include file to rc-map.c
Date:   Tue, 11 May 2010 20:42:14 +0200
User-Agent: KMail/1.12.4 (Linux/2.6.33.2; KDE/4.3.5; x86_64; ; )
Cc:     linuxppc-dev@ozlabs.org,
        "David =?iso-8859-1?q?H=E4rdeman?=" <david@hardeman.nu>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-mips@linux-mips.org,
        linux-m68k@lists.linux-m68k.org
References: <201005051720.22617.PeterHuewe@gmx.de>
In-Reply-To: <201005051720.22617.PeterHuewe@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <201005112042.14889.PeterHuewe@gmx.de>
X-Y-GMX-Trusted: 0
Return-Path: <PeterHuewe@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26674
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: PeterHuewe@gmx.de
Precedence: bulk
X-list: linux-mips

Am Mittwoch 05 Mai 2010 17:20:21 schrieb Peter Hüwe:
> From: Peter Huewe <peterhuewe@gmx.de>
> 
> This patch adds a missing include linux/delay.h to prevent
> build failures[1-5]
> 
> Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
> ---
Any updates on this patch?
Issue still exists with today's linux-next tree

Thanks,
Peter
