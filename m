Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Mar 2017 08:22:56 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:48874 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991232AbdCOHWdAFlpH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Mar 2017 08:22:33 +0100
Received: from localhost (unknown [104.132.150.97])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B4FC8514;
        Wed, 15 Mar 2017 07:22:26 +0000 (UTC)
Date:   Wed, 15 Mar 2017 15:22:13 +0800
From:   gregkh <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kernel-build-reports@lists.linaro.org,
        "kernelci.org bot" <bot@kernelci.org>, stable@vger.kernel.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: stable build: 203 builds: 3 failed, 200 passed, 5 errors, 28
 warnings (v4.9.13)
Message-ID: <20170315072213.GC26837@kroah.com>
References: <58b2dd95.18532e0a.7645f.aec1@mx.google.com>
 <CAK8P3a2nhoxgCT3467=+CLe9zeWqJa1oKFtcPoCut-1z5jacqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a2nhoxgCT3467=+CLe9zeWqJa1oKFtcPoCut-1z5jacqw@mail.gmail.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57279
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

On Tue, Feb 28, 2017 at 02:50:03PM +0100, Arnd Bergmann wrote:
> On Sun, Feb 26, 2017 at 2:52 PM, kernelci.org bot <bot@kernelci.org> wrote:
> >
> > stable build: 203 builds: 3 failed, 200 passed, 5 errors, 28 warnings (v4.9.13)
> 
> Only one warning that doesn't also show up in v4.10-stable
> 
> > bcm63xx_defconfig (mips) — PASS, 0 errors, 1 warning, 0 section mismatches
> >
> > Warnings:
> > drivers/net/ethernet/broadcom/bcm63xx_enet.c:1130:3: warning: 'phydev' may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
> df384d435a5c ("bcm63xx_enet: avoid uninitialized variable warning")

Also added, thanks.

greg k-h
