Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jul 2016 23:45:47 +0200 (CEST)
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35628 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992509AbcGDVpkXXe6Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Jul 2016 23:45:40 +0200
Received: by mail-oi0-f68.google.com with SMTP id d132so24970944oig.2;
        Mon, 04 Jul 2016 14:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=MDvpGqCFZSpT4EeaRuKfKBDANTRkM2yZ90Xp9/Ej2U0=;
        b=SKL4Ck95w+978c65/yD6buSlme8vjUFYSCg7zhHlHDxcve3cnrO/HalF2nPRuISahg
         9QQuXt6/aqHC0Xp86wVd/V6A3l4Z5XrOPz/zCXiLDsTQZK/xI64H+NfNstRgRHoYNIQa
         kfwTtuElzuo48o43rQv2XyF/mN7qa7MpAt2fm27O+TjxO+H/jplDBX1VsWpMyKNV13sS
         QdR9mkIZAilZfQ5G3peNpw2qiPNmoZTttuNxnsVHtkZ3hiH01JW4rAj51etNFt/s2+np
         ABd0c/Q8K0iC4267ZYu97535XG6Q85ZVJ88Wzsy9283KBVcuwrTG7b1iYVh269MJ0+j/
         TzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=MDvpGqCFZSpT4EeaRuKfKBDANTRkM2yZ90Xp9/Ej2U0=;
        b=iIIyQjfij2QjfRibMbn3JL1xqIMQHWlptBq5Xq5jwxJv9migj0wXFEZYUbBd3jJ4Hw
         DSW2BAUDPvAZvFMgemjsktIy7+mwQQoIqnEJ+11ky63eu2V/zjVtfHPsfiqxEQgMge7Z
         0fBAwoGcYIhNWAU79XLGj5HuGmL+un7M4uWI7So98VhTY+lIvNAKDgky3ImGXMegbGKY
         08ukfg/81GnytYgl4WY6R/Lz+FanKu+3cNWxeCbkIRqwOLc5tw8S7XaPWWuQ6kskEjql
         5qgn8hSBi/XUVu6HwFhriV0QYz74Jnho77u72scKS5NjqtSwOM7rXD8SSDQ1mG1uxkQ4
         00kA==
X-Gm-Message-State: ALyK8tLPz3Rc82m/yLbNPCpY7knxjVBH9ix22Hldd4fdN9ELPHXNc+sULyyqjUXu5fWhzA==
X-Received: by 10.157.29.105 with SMTP id m96mr8699209otm.39.1467668734164;
        Mon, 04 Jul 2016 14:45:34 -0700 (PDT)
Received: from ?IPv6:2001:470:d:73f:5c45:95b8:df2e:9a8a? ([2001:470:d:73f:5c45:95b8:df2e:9a8a])
        by smtp.googlemail.com with ESMTPSA id y3sm11817175ota.18.2016.07.04.14.45.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jul 2016 14:45:33 -0700 (PDT)
Subject: Re: [RFC] mips: Add MXU context switching support
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        linux-mips@linux-mips.org
References: <1466856870-17153-1-git-send-email-prasannatsmkumar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, adobriyan@gmail.com,
        john.stultz@linaro.org, mguzik@redhat.com, athorlton@sgi.com,
        mhocko@suse.com, ebiederm@xmission.com, gorcunov@openvz.org,
        luto@kernel.org, cl@linux.com, serge.hallyn@ubuntu.com,
        keescook@chromium.org, jslaby@suse.cz, akpm@linux-foundation.org,
        macro@imgtec.com, mingo@kernel.org, alex.smith@imgtec.com,
        markos.chandras@imgtec.com, Leonid.Yegoshin@imgtec.com,
        david.daney@cavium.com, zhaoxiu.zeng@gmail.com, chenhc@lemote.com,
        Zubair.Kakakhel@imgtec.com, james.hogan@imgtec.com,
        paul.burton@imgtec.com, ralf@linux-mips.org
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <577AD8FB.3040909@gmail.com>
Date:   Mon, 4 Jul 2016 14:45:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <1466856870-17153-1-git-send-email-prasannatsmkumar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54210
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Le 25/06/2016 05:14, PrasannaKumar Muralidharan a écrit :
> From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
> 
> This patch adds support for context switching Xburst MXU registers. The
> registers are named xr0 to xr16. xr16 is the control register that can
> be used to enable and disable MXU instruction set. Read and write to
> these registers can be done without enabling MXU instruction set by user
> space. Only when MXU instruction set is enabled any MXU instruction
> (other than read or write to xr registers) can be done. xr0 is always 0.
> 
> Kernel does not know when MXU instruction is enabled or disabled. So
> during context switch if MXU is enabled in xr16 register then MXU
> registers are saved, restored when the task is run. When user space
> application enables MXU, it is not reflected in other threads
> immediately. So for convenience the applications can use prctl syscall
> to let the MXU state propagate across threads running in different CPUs.

This is all well and good and seems useful, but you have not stated why
this is even useful in the first place?

> 
> Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
> ---

[snip]

> diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
> index 7e78b62..a4def30 100644
> --- a/arch/mips/include/asm/processor.h
> +++ b/arch/mips/include/asm/processor.h
> @@ -142,6 +142,11 @@ struct mips_dsp_state {
>  	unsigned int	dspcontrol;
>  };
>  
> +#define NUM_MXU_REGS 16
> +struct xburst_mxu_state {
> +	unsigned int xr[NUM_MXU_REGS];
> +};
> +
>  #define INIT_CPUMASK { \
>  	{0,} \
>  }
> @@ -266,6 +271,10 @@ struct thread_struct {
>  	/* Saved state of the DSP ASE, if available. */
>  	struct mips_dsp_state dsp;
>  
> +	unsigned int mxu_used;
> +	/* Saved registers of Xburst MXU, if available. */
> +	struct xburst_mxu_state mxu;

That's adding about 17 * 4 bytes to a structure that is probably best
kept as small as possible, might be worth adding an ifdef here specific
to the Ingenic platforms w/ MXU?

> +
>  	/* Saved watch register state, if available. */
>  	union mips_watch_reg_state watch;
>  
> @@ -330,6 +339,10 @@ struct thread_struct {
>  		.dspr		= {0, },			\
>  		.dspcontrol	= 0,				\
>  	},							\
> +	.mxu_used		= 0,				\
> +	.mxu			= {				\
> +		.xr		= {0, },			\
> +	},							\
>  	/*							\
>  	 * saved watch register stuff				\
>  	 */							\
> @@ -410,4 +423,10 @@ extern int mips_set_process_fp_mode(struct task_struct *task,
>  #define GET_FP_MODE(task)		mips_get_process_fp_mode(task)
>  #define SET_FP_MODE(task,value)		mips_set_process_fp_mode(task, value)
>  
> +extern int mips_enable_mxu_other_cpus(void);
> +extern int mips_disable_mxu_other_cpus(void);
> +
> +#define ENABLE_MXU_OTHER_CPUS()         mips_enable_mxu_other_cpus()
> +#define DISABLE_MXU_OTHER_CPUS()        mips_disable_mxu_other_cpus()

Where is the stub when building for !MIPS? Have you build a kernel with
your changes for e.g: x86?

[snip]

> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index a8d0759..b193d91 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -197,4 +197,7 @@ struct prctl_mm_map {
>  # define PR_CAP_AMBIENT_LOWER		3
>  # define PR_CAP_AMBIENT_CLEAR_ALL	4
>  
> +#define PR_ENABLE_MXU_OTHER_CPUS        48
> +#define PR_DISABLE_MXU_OTHER_CPUS       49
> +
>  #endif /* _LINUX_PRCTL_H */
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 89d5be4..fbbc7b2 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2270,6 +2270,12 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  	case PR_GET_FP_MODE:
>  		error = GET_FP_MODE(me);
>  		break;
> +	case PR_ENABLE_MXU_OTHER_CPUS:
> +		error = ENABLE_MXU_OTHER_CPUS();
> +		break;
> +	case PR_DISABLE_MXU_OTHER_CPUS:
> +		error = DISABLE_MXU_OTHER_CPUS();
> +		break;

Is not there a way to call into an architecture specific prctl() for the
unhandled options passed to prctl()? Not everybody will
want/implement/support that, and, more importantly changing generic code
here looks fishy and probably the wrong abstraction.
-- 
Florian
