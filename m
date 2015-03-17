Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Mar 2015 02:33:42 +0100 (CET)
Received: from ns.iliad.fr ([212.27.33.1]:42025 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008889AbbCQBdlBw-yf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Mar 2015 02:33:41 +0100
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 2B23A20539;
        Tue, 17 Mar 2015 02:33:41 +0100 (CET)
Received: from sakura.staff.proxad.net (freebox.vlq16.iliad.fr [213.36.7.13])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by ns.iliad.fr (Postfix) with ESMTPS id 11B8D1FF58;
        Tue, 17 Mar 2015 02:33:41 +0100 (CET)
Date:   Tue, 17 Mar 2015 02:33:39 +0100
From:   Maxime Bizon <mbizon@freebox.fr>
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     Nicolas Schichan <nschichan@freebox.fr>,
        Ralf Baechle <ralf@linux-mips.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandre Courbot <acourbot@nvidia.com>
Subject: Re: [PATCH] MIPS: bcm63xx: move bcm63xx_gpio_init() to
 bcm63xx_register_devices().
Message-ID: <20150317013339.GA10829@sakura.staff.proxad.net>
References: <1426176058-26114-1-git-send-email-nschichan@freebox.fr>
 <1426517616.25162.24.camel@sakura.staff.proxad.net>
 <CAOiHx==nyb946TouM5-eZKWBzNbhEuworX6bfTZntZTqfK08bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOiHx==nyb946TouM5-eZKWBzNbhEuworX6bfTZntZTqfK08bQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Tue Mar 17 02:33:41 2015 +0100 (CET)
Return-Path: <mbizon@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46425
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
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


On Monday 16 Mar 2015 à 16:54:54 (+0100), Jonas Gorski wrote:

> So I don't see how this breaks anything. But for the sake of the
> argument, let's give it a spin:

my mistake, you are right, I completely misread the patch.

-- 
Maxime
