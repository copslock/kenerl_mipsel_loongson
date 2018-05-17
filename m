Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 May 2018 03:13:29 +0200 (CEST)
Received: from out03.mta.xmission.com ([166.70.13.233]:42360 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993497AbeEQBNWGWhZi convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 May 2018 03:13:22 +0200
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fJ7Tn-0006DB-8l; Wed, 16 May 2018 19:13:15 -0600
Received: from [97.90.247.198] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fJ7Tm-0000B8-G1; Wed, 16 May 2018 19:13:15 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>
References: <1526392247-25512-1-git-send-email-linux@roeck-us.net>
Date:   Wed, 16 May 2018 20:13:10 -0500
In-Reply-To: <1526392247-25512-1-git-send-email-linux@roeck-us.net> (Guenter
        Roeck's message of "Tue, 15 May 2018 06:50:47 -0700")
Message-ID: <87k1s3jd95.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1fJ7Tm-0000B8-G1;;;mid=<87k1s3jd95.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.90.247.198;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19kcZIzeD/4OcMXj+PT8Qy42j9/8VCBv0k=
X-SA-Exim-Connect-IP: 97.90.247.198
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH -next] signal/mips: Report FPE_FLTUNK for undiagnosed floating point exceptions
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Return-Path: <ebiederm@xmission.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63979
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ebiederm@xmission.com
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

Guenter Roeck <linux@roeck-us.net> writes:

> Most mips builds fail with
>
> arch/mips/kernel/traps.c: In function ‘force_fcr31_sig’:
> arch/mips/kernel/traps.c:732:2: error:
> 	‘si_code’ may be used uninitialized in this function
>
> Fix the problem by initializing si_code with FPE_FLTUNK (undiagnosed
> floating point exception).
>
> Fixes: f43a54a0d916 ("signal/mips: Use force_sig_fault where appropriate")
> Cc: linux-mips@linux-mips.org
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied.  Thank you.

Eric

> ---
> Feel free to merge into the patch introducing the problem.
>
>  arch/mips/kernel/traps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index 66ec4b0b484d..d67fa74622ee 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -716,7 +716,7 @@ asmlinkage void do_ov(struct pt_regs *regs)
>  void force_fcr31_sig(unsigned long fcr31, void __user *fault_addr,
>  		     struct task_struct *tsk)
>  {
> -	int si_code;
> +	int si_code = FPE_FLTUNK;
>  
>  	if (fcr31 & FPU_CSR_INV_X)
>  		si_code = FPE_FLTINV;
