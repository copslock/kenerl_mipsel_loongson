Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2016 01:10:16 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:35738 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27025253AbcDCXKMc5YHO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Apr 2016 01:10:12 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u33NABKV006700;
        Mon, 4 Apr 2016 01:10:11 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u33NAAet006699;
        Mon, 4 Apr 2016 01:10:10 +0200
Date:   Mon, 4 Apr 2016 01:10:10 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Cc:     linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, f.fainelli@gmail.com,
        jogo@openwrt.org, cernekee@gmail.com, simon@fire.lp0.eu
Subject: Re: [PATCH 2/3] MIPS: BMIPS: improve BCM6358 device tree
Message-ID: <20160403231010.GA6518@linux-mips.org>
References: <1459685585-11747-1-git-send-email-noltari@gmail.com>
 <1459685585-11747-2-git-send-email-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1459685585-11747-2-git-send-email-noltari@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52849
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

On Sun, Apr 03, 2016 at 02:13:04PM +0200, Álvaro Fernández Rojas wrote:

> - Switch to bcm6345-l1-intc interrupt controller.
> - Add ehci0 and ohci0 nodes.
> - Use proper native-endian syscon property.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
>  arch/mips/boot/dts/brcm/bcm6358.dtsi | 29 ++++++++++++++++++++++++-----

Any reason Why didn't you fold this patch into the "[v3,2/2] bmips: add
device tree example for BCM6358" patch of the other series?

  Ralf
