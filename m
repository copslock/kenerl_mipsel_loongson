Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Mar 2017 09:42:43 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:40454 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991960AbdCHImhFVEq0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Mar 2017 09:42:37 +0100
Received: from localhost (LFbn-1-12060-104.w90-92.abo.wanadoo.fr [90.92.122.104])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E2804905;
        Wed,  8 Mar 2017 08:42:15 +0000 (UTC)
Date:   Wed, 8 Mar 2017 09:42:09 +0100
From:   gregkh <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "kernelci.org bot" <bot@kernelci.org>,
        kernel-build-reports@lists.linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mips@linux-mips.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: next build: 208 builds: 21 failed, 187 passed, 53 errors, 406
 warnings (next-20170308)
Message-ID: <20170308084209.GA16755@kroah.com>
References: <58bf7d43.8173190a.8d21e.1fde@mx.google.com>
 <CAK8P3a16cpvK3_a0Rxx+XqRw_d97LtVgpzcpvpzmH6U4Ty-fXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a16cpvK3_a0Rxx+XqRw_d97LtVgpzcpvpzmH6U4Ty-fXQ@mail.gmail.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57083
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

On Wed, Mar 08, 2017 at 09:24:01AM +0100, Arnd Bergmann wrote:
> On Wed, Mar 8, 2017 at 4:40 AM, kernelci.org bot <bot@kernelci.org> wrote:
> > cavium_octeon_defconfig (mips) — FAIL, 4 errors, 4 warnings, 0 section
> > mismatches
> > Warnings:
> > drivers/staging/octeon/ethernet-rx.c:339:28: warning: unused variable 'priv'
> > [-Wunused-variable]
> 
> I sent the patch on Feb 17, resent the same one today

Oops, I have 400+ staging patches to dig through, will get to that one
soon, sorry about it.

greg k-h
