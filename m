Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Apr 2013 06:28:46 +0200 (CEST)
Received: from mail-pd0-f176.google.com ([209.85.192.176]:55599 "EHLO
        mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816206Ab3DCE2oGYKUm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Apr 2013 06:28:44 +0200
Received: by mail-pd0-f176.google.com with SMTP id r11so617630pdi.35
        for <multiple recipients>; Tue, 02 Apr 2013 21:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=rHKO/lX9t7+W2f86YbBMY5NB2B4kurHTvjwAmbKgq14=;
        b=wLnZPsSwxT63WfC+asLl/xttYqz7ma7Xky+Iq/l9ubFpPVu59PEXS9atDjMpEUo7mx
         WTaVlOcM8ICp/jHimQNfbDWdY23zAgbeakpzzPUh75V2NlsY+cBNhCj48fPlhEgiNIqD
         NLGuTk6if5CrLCopC7yQbmC6HplPsAwrezErxVH6nhCHepTbuqaLT0PFGrpXRvk8A7+t
         CyOSnuR+cSW78lCX5CJ4YyyRIg3HlbcpOHFYGKTNfKib0+a85e14MBAPN/8DKo1kP2Ox
         8Qzh/6+onAG35uxYLaZIaB1CA+b3qbtB9avOutvL2462v6V1UbOVxZ4XDyM3xPtrhVpT
         SYZw==
X-Received: by 10.66.162.229 with SMTP id yd5mr1055376pab.4.1364963316798;
        Tue, 02 Apr 2013 21:28:36 -0700 (PDT)
Received: from hades.local (60-248-83-130.HINET-IP.hinet.net. [60.248.83.130])
        by mx.google.com with ESMTPS id kt5sm4280108pbc.30.2013.04.02.21.28.34
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 02 Apr 2013 21:28:36 -0700 (PDT)
Date:   Wed, 3 Apr 2013 12:28:19 +0800
From:   Tony Wu <tung7970@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: MIPS: Delete definition of SA_RESTORER.
Message-ID: <20130403042819.GA1013@hades.local>
References: <S6825888Ab3DBPUspqgO4/20130402152048Z+2639@eddie.linux-mips.org>
 <CA+zhxNntS-+Di-DRt5gUF7+P6KovOzmeoh741Y06i_d2-ccngw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+zhxNntS-+Di-DRt5gUF7+P6KovOzmeoh741Y06i_d2-ccngw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 36005
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tung7970@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Upstream cdef9602fb [signal: always clear sa_restorer on execve] was
also applied to v3.0 and v3.4 stable branches. So, the SA_RESTORER patch
Ralf applied to v3.8 is needed as well.

Here's the original commit message:
SA_RESTORER used to be defined as 0x04000000 but only the O32 ABI ever
supported its use and no libc was using it, so the entire sa-restorer
functionality was removed with lmo commit 39bffc12c3580ab [Zap sa_restorer.]
for 2.5.48 retaining only the SA_RESTORER definition as a reminder to avoid
accidental reuse of the mask bit.

Upstream cdef9602fbf1871a43f0f1b5cea10dd0f275167d [signal: always clear
sa_restorer on execve] adds code that assumes sa_sigaction has an
sa_restorer field, if SA_RESTORER is defined which would break MIPS.
So remove the SA_RESTORER definition before the v3.8.4 merge.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Tony Wu <tung7970@gmail.com>

diff --git a/arch/mips/include/asm/signal.h b/arch/mips/include/asm/signal.h
index c783f36..edfb2b0 100644
--- a/arch/mips/include/asm/signal.h
+++ b/arch/mips/include/asm/signal.h
@@ -84,8 +84,6 @@ typedef unsigned long old_sigset_t;		/* at least 32 bits */
 #define SA_NOMASK	SA_NODEFER
 #define SA_ONESHOT	SA_RESETHAND
 
-#define SA_RESTORER	0x04000000	/* Only for o32 */
-
 /*
  * sigaltstack controls
  */

On Wed, Apr 03, 2013 at 12:54:30AM +0800, Tony Wu wrote:
> Hi, Ralf,
> 
> Also need to remove SA_RESTORER from arch/mips/include/signal.h for
> linux-3.0-stable and linux-3.4-stable or it will break compilation.
> 
> Thanks,
> Tony
> 
> ---------- Forwarded message ----------
> From: <linux-mips@linux-mips.org>
> Date: Tue, Apr 2, 2013 at 11:20 PM
> Subject: MIPS: Delete definition of SA_RESTORER.
> To: git-commits@linux-mips.org
> 
> 
> Author: Ralf Baechle <ralf@linux-mips.org> Mon Mar 25 13:43:14 2013 +0100
> Commit: 17da8d63add23830892ac4dc2cbb3b5d4ffb79a8
> Gitweb: http://git.linux-mips.org/g/ralf/linux/17da8d63add2
> Branch: linux-3.8-stable
> 
> SA_RESTORER used to be defined as 0x04000000 but only the O32 ABI ever
> supported its use and no libc was using it, so the entire sa-restorer
> functionality was removed with lmo commit 39bffc12c3580ab [Zap sa_restorer.]
> for 2.5.48 retaining only the SA_RESTORER definition as a reminder to avoid
> accidental reuse of the mask bit.
> 
> Upstream cdef9602fbf1871a43f0f1b5cea10dd0f275167d [signal: always clear
> sa_restorer on execve] adds code that assumes sa_sigaction has an
> sa_restorer field, if SA_RESTORER is defined which would break MIPS.
> So remove the SA_RESTORER definition before the v3.8.4 merge.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> ---
> 
>  arch/mips/include/uapi/asm/signal.h |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/include/uapi/asm/signal.h
> b/arch/mips/include/uapi/asm/signal.h
> index 770732c..dfd6b5e 100644
> --- a/arch/mips/include/uapi/asm/signal.h
> +++ b/arch/mips/include/uapi/asm/signal.h
> @@ -72,6 +72,12 @@ typedef unsigned long old_sigset_t;          /* at least
> 32 bits */
>   *
>   * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
>   * Unix names RESETHAND and NODEFER respectively.
> + *
> + * SA_RESTORER used to be defined as 0x04000000 but only the O32 ABI ever
> + * supported its use and no libc was using it, so the entire sa-restorer
> + * functionality was removed with lmo commit 39bffc12c3580ab for 2.5.48
> + * retaining only the SA_RESTORER definition as a reminder to avoid
> + * accidental reuse of the mask bit.
>   */
>  #define SA_ONSTACK     0x08000000
>  #define SA_RESETHAND   0x80000000
> @@ -84,8 +90,6 @@ typedef unsigned long old_sigset_t;           /* at least
> 32 bits */
>  #define SA_NOMASK      SA_NODEFER
>  #define SA_ONESHOT     SA_RESETHAND
> 
> -#define SA_RESTORER    0x04000000      /* Only for o32 */
> -
>  #define MINSIGSTKSZ    2048
>  #define SIGSTKSZ       8192
