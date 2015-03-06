Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Mar 2015 07:30:46 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:34430 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007185AbbCFGan4u93L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Mar 2015 07:30:43 +0100
Received: from localhost (unknown [70.102.234.3])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 276DA990;
        Fri,  6 Mar 2015 06:30:35 +0000 (UTC)
Date:   Thu, 5 Mar 2015 22:30:34 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        satoru.takeuchi@gmail.com, shuah.kh@samsung.com,
        stable@vger.kernel.org, linux-mips@linux-mips.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org
Subject: Re: [PATCH stable 3.10, 3.12, 3.14] MIPS: Export FP functions used
 by lose_fpu(1) for KVM
Message-ID: <20150306063034.GA6914@kroah.com>
References: <54F7BE2E.8070708@roeck-us.net>
 <1425571724-9480-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1425571724-9480-1-git-send-email-james.hogan@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46218
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

On Thu, Mar 05, 2015 at 04:08:44PM +0000, James Hogan wrote:
> [ Upstream commit 3ce465e04bfd8de9956d515d6e9587faac3375dc ]
> 
> Export the _save_fp asm function used by the lose_fpu(1) macro to GPL
> modules so that KVM can make use of it when it is built as a module.
> 
> This fixes the following build error when CONFIG_KVM=m due to commit
> f798217dfd03 ("KVM: MIPS: Don't leak FPU/DSP to guest"):
> 
> ERROR: "_save_fp" [arch/mips/kvm/kvm.ko] undefined!
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Fixes: f798217dfd03 (KVM: MIPS: Don't leak FPU/DSP to guest)
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@imgtec.com>
> Cc: Gleb Natapov <gleb@kernel.org>
> Cc: kvm@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: <stable@vger.kernel.org> # 3.10...3.15
> Patchwork: https://patchwork.linux-mips.org/patch/9260/
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> [james.hogan@imgtec.com: Only export when CPU_R4K_FPU=y prior to v3.16,
>  so as not to break the Octeon build which excludes FPU support. KVM
>  depends on MIPS32r2 anyway.]
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> ---
> Appologies for the previous cavium_octeon_defconfig link breakage.
> Octeon has the symbol since 3.16, but not before. This backport should
> do the trick for stable 3.10, 3.12, and 3.14. Build tested with
> cavium_octeon_defconfig and malta_kvm_defconfig on those stable
> branches.
> ---
>  arch/mips/kernel/mips_ksyms.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Now fixed up, thanks.

greg k-h
