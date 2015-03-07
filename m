Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Mar 2015 14:30:38 +0100 (CET)
Received: from mail-we0-f180.google.com ([74.125.82.180]:40733 "EHLO
        mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007461AbbCGNagD85S6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 Mar 2015 14:30:36 +0100
Received: by wevk48 with SMTP id k48so21302057wev.7;
        Sat, 07 Mar 2015 05:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=97fpbXkASgoEaYTcVMxVjeXvrm+9mhSm3tgtSIRXDs4=;
        b=T0S4V8zNdaPYKr/+GrIzGLOpSVu6fUhilMfRWQKsAGBrf/gpeUW+UITFZe9GpxLFSw
         8ziJZamQOY/xL+QX+L4uWquQUpwx7VNzvHhI7VAu73l48TCLFlkKWb+eWfXqubnQ3VqJ
         jDI6rDap0elfW1tIgSEpKh6a8cnBjVwRv0GHWL1yxoPflKZzjGgLBngzoKcTHaTVaOeT
         iH5wt/Q4nfZR3xIDfnyxa5gYg4MnydIF/Z465y/4VIU71kHxF3Gl1/DkvYLfPm8q7QtJ
         yxkwopLOUZa46Ig9xoTiPp4ptkSQuWWVsFwfKTdjsXmFJzipGxb5AyNs/WC0SWd9p0A1
         pY4Q==
X-Received: by 10.194.201.2 with SMTP id jw2mr5265941wjc.158.1425735031381;
        Sat, 07 Mar 2015 05:30:31 -0800 (PST)
Received: from [192.168.1.213] (adsl-dyn-200.95-102-190.t-com.sk. [95.102.190.200])
        by mx.google.com with ESMTPSA id v16sm6684654wib.5.2015.03.07.05.30.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Mar 2015 05:30:30 -0800 (PST)
Message-ID: <54FAFD73.9030500@suse.cz>
Date:   Sat, 07 Mar 2015 14:30:27 +0100
From:   Jiri Slaby <jslaby@suse.cz>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>,
        Guenter Roeck <linux@roeck-us.net>
CC:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, satoru.takeuchi@gmail.com,
        shuah.kh@samsung.com, stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@linux-mips.org, Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org
Subject: Re: [PATCH stable 3.10, 3.12, 3.14] MIPS: Export FP functions used
 by lose_fpu(1) for KVM
References: <54F7BE2E.8070708@roeck-us.net> <1425571724-9480-1-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1425571724-9480-1-git-send-email-james.hogan@imgtec.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-Path: <jirislaby@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46249
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

On 03/05/2015, 05:08 PM, James Hogan wrote:
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

Applied to 3.12 now. Thanks.


-- 
js
suse labs
