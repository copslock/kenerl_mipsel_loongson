Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Mar 2017 08:23:31 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:48896 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992036AbdCOHWmm80wH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Mar 2017 08:22:42 +0100
Received: from localhost (unknown [104.132.150.97])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 60C6E514;
        Wed, 15 Mar 2017 07:22:36 +0000 (UTC)
Date:   Wed, 15 Mar 2017 15:22:23 +0800
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
Message-ID: <20170315072223.GD26837@kroah.com>
References: <58b2e1b1.16502e0a.696c.aa4e@mx.google.com>
 <CAK8P3a2YDcM3t2aJHNEv8C6EFN2P4hN1hKsqJ8K--_XEC12b5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a2YDcM3t2aJHNEv8C6EFN2P4hN1hKsqJ8K--_XEC12b5A@mail.gmail.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57280
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

On Tue, Feb 28, 2017 at 02:55:42PM +0100, Arnd Bergmann wrote:
> On Sun, Feb 26, 2017 at 3:09 PM, kernelci.org bot <bot@kernelci.org> wrote:
> > stable build: 199 builds: 1 failed, 198 passed, 1 error, 31 warnings
> 
> A few additional patches are missing here, besides the ones I have
> listed for 4.9 and v4.10
> 
> > Warnings:
> > drivers/net/ethernet/ti/cpmac.c:1240:2: warning: #warning FIXME: unhardcode
> > gpio&reset bits [-Wcpp]
> 
> d43e6fb4ac4a ("cpmac: remove hopeless #warning")
> 
> > ci20_defconfig (mips) — PASS, 0 errors, 1 warning, 0 section mismatches
> >
> > Warnings:
> > mm/memcontrol.c:4153:27: warning: 'mem_cgroup_id_get_online' defined but not
> > used [-Wunused-function]
> 
> 358c07fcc3b6 ("mm: memcontrol: avoid unused function warning")
> 
> > decstation_defconfig (mips) — PASS, 0 errors, 3 warnings, 0 section
> > mismatches
> >
> > Warnings:
> > arch/mips/dec/int-handler.S:149: Warning: macro instruction expanded into
> > multiple instructions in a branch delay slot
> > arch/mips/dec/int-handler.S:198: Warning: macro instruction expanded into
> > multiple instructions in a branch delay slot
> 
> 3021773c7c3e ("MIPS: DEC: Avoid la pseudo-instruction in delay slots")
> 
> > nlm_xlp_defconfig (mips) — PASS, 0 errors, 4 warnings, 0 section mismatches
> >
> > Warnings:
> > arch/mips/netlogic/common/reset.S:53:0: warning: "CP0_EBASE" redefined
> > arch/mips/netlogic/common/smpboot.S:51:0: warning: "CP0_EBASE" redefined
> 
> 32eb6e8bee14 ("MIPS: Netlogic: Fix CP0_EBASE redefinition warnings")

And I've added these as well, thanks.

greg k-h
