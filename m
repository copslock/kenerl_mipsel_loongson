Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Mar 2017 02:38:21 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:42162 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992111AbdCPBiOqVDG5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Mar 2017 02:38:14 +0100
Received: from localhost (unknown [104.132.152.98])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7DDC5BEB;
        Thu, 16 Mar 2017 01:38:07 +0000 (UTC)
Date:   Thu, 16 Mar 2017 10:37:54 +0900
From:   gregkh <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kernel-build-reports@lists.linaro.org,
        "kernelci.org bot" <bot@kernelci.org>, stable@vger.kernel.org,
        linux-mips@linux-mips.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
Subject: Re: stable build: 199 builds: 1 failed, 198 passed, 1 error, 31
 warnings (v4.4.52)
Message-ID: <20170316013754.GB442@kroah.com>
References: <58b2e1b1.16502e0a.696c.aa4e@mx.google.com>
 <CAK8P3a2YDcM3t2aJHNEv8C6EFN2P4hN1hKsqJ8K--_XEC12b5A@mail.gmail.com>
 <20170315072223.GD26837@kroah.com>
 <CAK8P3a19darucxTU4rm6ApFB4CjPXqAkuVBx7M3btkaT5=f2YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a19darucxTU4rm6ApFB4CjPXqAkuVBx7M3btkaT5=f2YA@mail.gmail.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57315
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

On Wed, Mar 15, 2017 at 01:42:21PM +0100, Arnd Bergmann wrote:
> On Wed, Mar 15, 2017 at 8:22 AM, gregkh <gregkh@linuxfoundation.org> wrote:
> > On Tue, Feb 28, 2017 at 02:55:42PM +0100, Arnd Bergmann wrote:
> >> On Sun, Feb 26, 2017 at 3:09 PM, kernelci.org bot <bot@kernelci.org> wrote:
> >> > stable build: 199 builds: 1 failed, 198 passed, 1 error, 31 warnings
> >>
> 
> >> d43e6fb4ac4a ("cpmac: remove hopeless #warning")
> 
> >> 358c07fcc3b6 ("mm: memcontrol: avoid unused function warning")
> >>
> 
> >> 3021773c7c3e ("MIPS: DEC: Avoid la pseudo-instruction in delay slots")
> 
> >> 32eb6e8bee14 ("MIPS: Netlogic: Fix CP0_EBASE redefinition warnings")
> >
> > And I've added these as well, thanks.
> 
> Thanks! Here are the latest results from
> 
> https://kernelci.org/build/stable-rc/kernel/v4.4.54-31-gfe326ea3fc88/
> 
> | Errors Summary
> |
> | 1 arch/mips/ralink/timer.c:146:2: error: implicit declaration of
> function 'rt_timer_free' [-Werror=implicit-function-declaration]
> | 1 arch/mips/ralink/timer.c:145:2: error: implicit declaration of
> function 'rt_timer_disable' [-Werror=implicit-function-declaration]
> 
> d92240d12a got backported to 4.4.55-rc1 but should have only been
> in v4.9 or higher (which contains 62ee73d284e7). Please revert that
> one.

Oops, now dropped.

> | Warnings Summary
> | 1 net/wireless/nl80211.c:5109:1: warning: the frame size of 2064
> bytes is larger than 2048 bytes [-Wframe-larger-than=]
> | 1 net/wireless/nl80211.c:3875:1: warning: the frame size of 2168
> bytes is larger than 2048 bytes [-Wframe-larger-than=]
> | 1 net/wireless/nl80211.c:1744:1: warning: the frame size of 5640
> bytes is larger than 2048 bytes [-Wframe-larger-than=]
> | 1 drivers/tty/vt/keyboard.c:1470:1: warning: the frame size of 2344
> bytes is larger than 2048 bytes [-Wframe-larger-than=]
> 
> Still broken on mainline, will get back to this in a few days.
> 
> | 1 drivers/scsi/mvsas/mv_sas.c:736:3: warning: this 'else' clause
> does not guard... [-Wmisleading-indentation]
> 
> Harmless warning that was fixed by
> 7789cd39274c ("mvsas: fix misleading indentation")
> 
> which got merged into v4.5. Caused by 0b15fb1fdfd4 ("[SCSI] mvsas:
> add support for Task collector mode and fixed relative bugs") in v3.0.

Now queued up, thanks.

greg k-h
