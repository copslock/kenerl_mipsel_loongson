Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Mar 2015 17:23:13 +0100 (CET)
Received: from bh-25.webhostbox.net ([208.91.199.152]:35644 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012696AbbCFQXLgIYRz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Mar 2015 17:23:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=VP63BmDVH9zWOQ7nzuWEghvfosJUHy1Dl56aocd32c8=;
        b=k//68YBYekrT+P43uDEwAdkiTA6UWlBxpXB8UpXXp9TbzZPqlM9zbnDpS3cT3ZoQF4pqzms+Rco1weCfj61wak0+Aba0eXlHXfhZcJUO5YZXQFv0i/Xaq36RNrsSfRKVh5PVcJhdTzQJr2ZkKzt+CD1NwVS6jnLy4BJUI+xMICI=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1YTv1l-000P6l-Fz
        for linux-mips@linux-mips.org; Fri, 06 Mar 2015 16:23:05 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:53366 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1YTv1X-000Oxc-3n; Fri, 06 Mar 2015 16:22:51 +0000
Date:   Fri, 6 Mar 2015 08:22:49 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     James Hogan <james.hogan@imgtec.com>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        satoru.takeuchi@gmail.com, shuah.kh@samsung.com,
        stable@vger.kernel.org, linux-mips@linux-mips.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org
Subject: Re: [PATCH stable 3.10, 3.12, 3.14] MIPS: Export FP functions used
 by lose_fpu(1) for KVM
Message-ID: <20150306162249.GA28962@roeck-us.net>
References: <54F7BE2E.8070708@roeck-us.net>
 <1425571724-9480-1-git-send-email-james.hogan@imgtec.com>
 <20150306063034.GA6914@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150306063034.GA6914@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-CTCH-PVer: 0000001
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: 0
X-CTCH-RefID: str=0001.0A020204.54F9D469.0244,ss=1,re=0.001,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-Score: 0.001
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: C_4847,
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 9
X-CTCH-SenderID-TotalSpam: 0
X-CTCH-SenderID-TotalSuspected: 0
X-CTCH-SenderID-TotalConfirmed: 0
X-CTCH-SenderID-TotalBulk: 0
X-CTCH-SenderID-TotalVirus: 0
X-CTCH-SenderID-TotalRecipients: 0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: mailgid no entry from get_relayhosts_entry
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46235
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On Thu, Mar 05, 2015 at 10:30:34PM -0800, Greg Kroah-Hartman wrote:
> On Thu, Mar 05, 2015 at 04:08:44PM +0000, James Hogan wrote:
> > [ Upstream commit 3ce465e04bfd8de9956d515d6e9587faac3375dc ]
> > 
> > Export the _save_fp asm function used by the lose_fpu(1) macro to GPL
> > modules so that KVM can make use of it when it is built as a module.
> > 
> > This fixes the following build error when CONFIG_KVM=m due to commit
> > f798217dfd03 ("KVM: MIPS: Don't leak FPU/DSP to guest"):
> > 
> > ERROR: "_save_fp" [arch/mips/kvm/kvm.ko] undefined!
> > 
> > Signed-off-by: James Hogan <james.hogan@imgtec.com>
> > Fixes: f798217dfd03 (KVM: MIPS: Don't leak FPU/DSP to guest)
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Paul Burton <paul.burton@imgtec.com>
> > Cc: Gleb Natapov <gleb@kernel.org>
> > Cc: kvm@vger.kernel.org
> > Cc: linux-mips@linux-mips.org
> > Cc: <stable@vger.kernel.org> # 3.10...3.15
> > Patchwork: https://patchwork.linux-mips.org/patch/9260/
> > Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> > [james.hogan@imgtec.com: Only export when CPU_R4K_FPU=y prior to v3.16,
> >  so as not to break the Octeon build which excludes FPU support. KVM
> >  depends on MIPS32r2 anyway.]
> > Signed-off-by: James Hogan <james.hogan@imgtec.com>
> > ---
> > Appologies for the previous cavium_octeon_defconfig link breakage.
> > Octeon has the symbol since 3.16, but not before. This backport should
> > do the trick for stable 3.10, 3.12, and 3.14. Build tested with
> > cavium_octeon_defconfig and malta_kvm_defconfig on those stable
> > branches.
> > ---
> >  arch/mips/kernel/mips_ksyms.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> 
> Now fixed up, thanks.
> 
My auto-builders still fail to build cavium_octeon_defconfig for 3.10 and 3.14,
and as far as I can see they picked up no changes. Did you push the changes into
the stable queue repository ?

Thanks,
Guenter
