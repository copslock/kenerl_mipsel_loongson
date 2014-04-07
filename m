Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Apr 2014 20:02:52 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:53416 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6822092AbaDGSCultuN0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Apr 2014 20:02:50 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s37I2lIa013307;
        Mon, 7 Apr 2014 20:02:47 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s37I2k7p013306;
        Mon, 7 Apr 2014 20:02:46 +0200
Date:   Mon, 7 Apr 2014 20:02:46 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [RFC PATCH v4 2/2] MIPS: make FPU emulator optional
Message-ID: <20140407180246.GR17197@linux-mips.org>
References: <1396868224-252888-1-git-send-email-manuel.lauss@gmail.com>
 <1396868224-252888-2-git-send-email-manuel.lauss@gmail.com>
 <20140407135315.GX14803@pburton-linux.le.imgtec.org>
 <20140407162857.GQ17197@linux-mips.org>
 <CAGVrzcbV0sta4PyOoO+jMyOGc6rbT=hNjZTY_iDbi77ZjfUTfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGVrzcbV0sta4PyOoO+jMyOGc6rbT=hNjZTY_iDbi77ZjfUTfQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39687
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

On Mon, Apr 07, 2014 at 09:37:42AM -0700, Florian Fainelli wrote:

> There are some braindead bootloaders out there that will only allow
> for a small kernel partition, while the rootfs partition can virtually
> span the remainder of the available flash space... and all sorts of
> crazy designs like these.

In a case like that 50k are going to buy you a release or two of Moore's
law applied to kernel bloat.

How making the FPU emu a module?

  Ralf
