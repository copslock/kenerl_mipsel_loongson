Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 May 2016 13:56:07 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.126.133]:49778 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27029302AbcELL4FofA0n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 May 2016 13:56:05 +0200
Received: from wuerfel.localnet ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue004) with ESMTPSA (Nemesis) id 0LhRTw-1bMwdQ15Au-00mZWs; Thu, 12 May
 2016 13:55:48 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Christian Lamparter <chunkeey@googlemail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-mips@linux-mips.org, johnyoun@synopsys.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, a.seppala@gmail.com,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: usb: dwc2: regression on MyBook Live Duo / Canyonlands since 4.3.0-rc4
Date:   Thu, 12 May 2016 13:55:44 +0200
Message-ID: <2924514.Pic5Z1NUsc@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <7745292.ZB3149zIk7@debian64>
References: <4231696.iL6nGs74X8@debian64> <5347627.S9K7mIusOJ@wuerfel> <7745292.ZB3149zIk7@debian64>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:5J8LZNX73AAST1QcIDxOs1X2ruioYgkJBYk291QfK1mxvS0nPav
 DktFwP4oNPV9Vmbn/tmWa81y4rRY+zYxql/EUgwqKIqXKF8vDc1hCw5S2Xdo2recudTRwqq
 rpbeGp1aFvvDU+xYQKSnakBq3YnbRiDXwTpid8V0C/+FrIg15xrGs2Jm/3FbYQs54X78oTk
 xI8dinCQLG6Y4jn3GFi1Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iHBcLPm8xp4=:WSkdyTsowe2lvB71o2V1PF
 Euc+80dTivZP9RSi0Ry16gO/6IG7GNcodXyqZ6g0+TDbm/mAGvIFCxR9rORTGaluYBoj+gWA6
 nN4s3vvmIK01BLaDsDajqM1PHs2Fcdll4/2WlRb2kGLOCFvHYIxCczZFu2+IHZxXljfHQS+EL
 eCLAi+WbKS7JMKc7rP15Z6OUo6lb/LYSlUWdFuBBbfG9El6U1RGZAe6wzRLrGgFu4Ba+1BsFL
 RHr+2c54zbD8m+HJ/ZFWbiNY88luudMwJOz8PM3nQK8IEFvBmKaXlOA5QjrU8xkDSIBii9pX7
 o71O9NTLyXXbXsByHBRrUVah5tuWH3sYKZOjCT9veybckkAxhLffP5agDIR8rRIqdHb8Y0Etv
 dGDC+MheW19R6RsFgXGc6DI8HM6moRF9CF3yvePker2qIkMlDgOyXf3cQEVcYDlSmGiNTqI28
 CLTaDwWYr5QtGDaBP6heiBJHrb4BzEGa2wJm/MollE6NYdL2nUvbkjtrLdw1ouV3KZiBMw+NX
 EnHOnR0QQzzAt0OaGzL/xICsK+vGPGhyJZWlrcqFxKQ4tqIW8Ipyyny4z6Y49ZmnjsQZiTZaN
 3Q0pWP8TGQW6kbFAROkjWmYJEjB7smaBOh16rxFQz+pFdhH4Ag+Qnf9RaA+gs0ZeXYBhBHAnt
 QvHTrzOSBUMvzQLkcAv9Tq9IjCWtSTDU7OnA1MBV0g9ElgK+IAHY3ECUbB6ezVH/L5pW9vlm4
 mFtL6ilE0Inzf/0f
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53406
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

On Thursday 12 May 2016 11:58:18 Christian Lamparter wrote:
> > > > Detecting the endianess of the
> > > > device is probably the best future-proof solution, but it's also
> > > > considerably more work to do in the driver, and comes with a
> > > > tiny runtime overhead.
> > > 
> > > The runtime overhead is probably non-measurable compared with the cost
> > > of the actual MMIOs.
> > 
> > Right. The code size increase is probably measurable (but still small),
> > the runtime overhead is not.
> 
> Ok, so no rebuts or complains have been posted.
> 
> I've tested the patch you made in: https://lkml.org/lkml/2016/5/9/354
> and it works: 
> 
> Tested-by: Christian Lamparter <chunkeey@googlemail.com>
> 
> So, how do we go from here? There is are two small issues with the
> original patch (#ifdef DWC2_LOG_WRITES got converted to lower case:
> #ifdef dwc2_log_writes) and I guess a proper subject would be nice.  
> 
> Arnd, can you please respin and post it (cc'd stable as well)?
> So this is can be picked up? Or what's your plan?

(I just realized my reply was stuck in my outbox, so the patch
went out first)

If I recall correctly, the rough consensus was to go with your longer
patch in the future (fixed up for the comments that BenH and
I sent), and I'd suggest basing it on top of a fixed version of
my patch.

Felipe just had another idea, to change the endianess of the dwc2
block by setting a registers (if that exists). That would indeed
be preferable, then we can just revert the broken change that
went into 4.4 and backport that fix instead.

	Arnd
