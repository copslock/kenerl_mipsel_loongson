Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Oct 2018 12:39:03 +0200 (CEST)
Received: from fudo.makrotopia.org ([IPv6:2a07:2ec0:3002::71]:48750 "EHLO
        fudo.makrotopia.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992479AbeJPKi7TAFP2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Oct 2018 12:38:59 +0200
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
         (Exim 4.90_1)
        (envelope-from <daniel@makrotopia.org>)
        id 1gCMkQ-0008Fz-Lx; Tue, 16 Oct 2018 12:38:47 +0200
Date:   Tue, 16 Oct 2018 12:38:07 +0200
From:   Daniel Golle <daniel@makrotopia.org>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Tom Psyborg <pozega.tomislav@gmail.com>,
        linux-wireless@vger.kernel.org, Mathias Kresin <dev@kresin.me>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH v4 4/8] rt2800: fix registers init for MT7620
Message-ID: <20181016103806.GA1544@makrotopia.org>
References: <1539334591-9965-1-git-send-email-sgruszka@redhat.com>
 <1539334591-9965-5-git-send-email-sgruszka@redhat.com>
 <CAKR_QVJ60VTDjyC59BEDsRKrKR495xjGwob0QqvX333L+L+=Zg@mail.gmail.com>
 <20181016081115.GA4401@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016081115.GA4401@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <daniel@makrotopia.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66866
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@makrotopia.org
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

On Tue, Oct 16, 2018 at 10:11:16AM +0200, Stanislaw Gruszka wrote:
> On Fri, Oct 12, 2018 at 12:48:07PM +0200, Tom Psyborg wrote:
> > chip version support exist in daniel's tree since a long time ago. so
> > don't disable registers initialization but try to upstream his
> > changes.
> 
> Where is this patch ? I can not find it.

So this requires to make the chip version and package available to
drivers like rt2x00. First of all, this is a patch for linux-mips:

https://git.openwrt.org/?p=openwrt/staging/dangole.git;a=blob;f=target/linux/ramips/patches-4.4/300-mt7620-export-chip-version-and-pkg.patch;h=f6aca6c90516f9c534b3c51e9f99dff6a3f41b75;hb=709fe05dfea58728d6accb9fe56c7056d9d0715b

It belongs to this (very outdated) tree:
https://git.openwrt.org/?p=openwrt/staging/dangole.git;a=shortlog;h=refs/heads/differentiate-pkg-ver-eco

I'm not sure whether this is the right way to do this, but it worked.


Cheers


Daniel



> 
> Thanks
> Stanislaw
