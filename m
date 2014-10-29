Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 08:44:24 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.130]:61057 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011870AbaJ2HoWmL0G5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 08:44:22 +0100
Received: from wuerfel.localnet (HSI-KBW-134-3-133-35.hsi14.kabel-badenwuerttemberg.de [134.3.133.35])
        by mrelayeu.kundenserver.de (node=mreue003) with ESMTP (Nemesis)
        id 0MEJGG-1Xpze31sUa-00FS1A; Wed, 29 Oct 2014 08:44:07 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     f.fainelli@gmail.com, tglx@linutronix.de, jason@lakedaemon.net,
        ralf@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 04/11] irqchip: Remove ARM dependency for bcm7120-l2 and brcmstb-l2
Date:   Wed, 29 Oct 2014 08:44:06 +0100
Message-ID: <2058619.ZZgjsUZogD@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1414555138-6500-4-git-send-email-cernekee@gmail.com>
References: <1414555138-6500-1-git-send-email-cernekee@gmail.com> <1414555138-6500-4-git-send-email-cernekee@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V02:K0:kZOOf8G0VdHBkRtfaqPCopcq4yw94IouPP4czLSuCop
 CxnOaBobS6sDsLfRiOHiZTMkTsj4IljGIYcbs2PRi6Rh6kONeQ
 Oz0E0hQQZGS9JP3Z0gXD3FEWTx4Rv1IFsx1VGWZKK8dPPYDSBR
 Cq1x03vWxdFPA9EbSBWeVFL5SzT3k0SnCvq+UOfURfqv7sUpoj
 S0iJvtp4NIZS5sKDrTdSJx5Qv8zjwR3wNxg85oiZVt2Sdpvbfa
 O23FbAWK0SR6QKy7H5BT1Ps5DZ4pkl/gpwwqkE5NGkwJtJ4RZX
 GvLYeDciD4wVRpbTjjLk5EbgYg1QJzAS7i4oX92t1llo2QI3vd
 f+qEvXFRcfxvbjtmJNMg=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43685
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Tuesday 28 October 2014 20:58:51 Kevin Cernekee wrote:
> This can compile for MIPS (or anything else) now.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> 

It's a silent symbol, so the dependency is obviously not needed,

Acked-by: Arnd Bergmann <arnd@arndb.de>
