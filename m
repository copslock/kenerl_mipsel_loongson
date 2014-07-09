Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jul 2014 13:58:41 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:39363 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6859944AbaGIL6iNM7vr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Jul 2014 13:58:38 +0200
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 85C3D280893;
        Wed,  9 Jul 2014 13:56:32 +0200 (CEST)
Received: from openwrt.org (dslb-088-073-046-107.pools.arcor-ip.net [88.73.46.107])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Wed,  9 Jul 2014 13:56:32 +0200 (CEST)
Date:   Wed, 9 Jul 2014 13:58:37 +0200
From:   Jonas Gorski <jogo@openwrt.org>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH 6/8] MIPS: BCM63XX: remove !RUNTIME_DETECT usage from
 enet code
Message-ID: <20140709135837.00006b3c@openwrt.org>
In-Reply-To: <53BC156D.6080106@cogentembedded.com>
References: <1404831204-30659-1-git-send-email-jogo@openwrt.org>
        <1404831204-30659-7-git-send-email-jogo@openwrt.org>
        <53BC156D.6080106@cogentembedded.com>
Organization: OpenWrt
X-Mailer: Claws Mail 3.9.3-30-gd68093 (GTK+ 2.16.6; i586-pc-mingw32msvc)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41097
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On Tue, 08 Jul 2014 19:59:41 +0400
Sergei Shtylyov <sergei.shtylyov@cogentembedded.com> wrote:

> Hello.
> 
>     You forgot to si.gn off on this patch.

(added a dot into sign to make ecartis not detect a command)

Indeed I have, thanks for spotting this. *cough*
 
Sooo ... *looks at patchwork*
 
Signed-off-by: Jonas Gorski <jogo@openwrt.org>
 

Jonas
