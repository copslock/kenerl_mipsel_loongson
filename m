Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jul 2016 11:48:43 +0200 (CEST)
Received: from mail-io0-f196.google.com ([209.85.223.196]:33680 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991049AbcGEJrvqBqAx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jul 2016 11:47:51 +0200
Received: by mail-io0-f196.google.com with SMTP id t74so20186811ioi.0;
        Tue, 05 Jul 2016 02:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RE6WPl9kKwGGObLjMQaqrLX48h9tWm/Kvz2URMO/3PY=;
        b=gRTEgXYXiuQ4LpbzQQgK/R1oiejB5VLviK0OrX4XbxWqGhJv5GLEwta+7jsN2QTUi0
         kIUv66bDMiXkBSEVRPo1EoDEOtsrwLBg7UW/hmMpas3LkmLkIhYb8u9l+CfVadCl7olS
         9wwwWm4+MGOENpdKXdpkzkp5O+7K0g7aKm0kgvH2q6wgaOlaErGaBnpVdckGozw4uxUH
         SY4QDCslg/o6AuAnNb57HykSMbjn1K5ArNeNDMylrX1YcvfVO31npWScARF/CapmXVnZ
         1/9MSCTqslvtWSejsOQybp6NGRKiImsnMenURZOTUv4xYTqeui0vVKwmYlUCbF4Hbzm3
         dKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RE6WPl9kKwGGObLjMQaqrLX48h9tWm/Kvz2URMO/3PY=;
        b=d00FjA/ssff997WbiiGHLR/hPOXEHEYWltSBn/RmG86aaV7+TIb9FXvjsE7bPbOQJI
         ilWouzSkVBhyxuTcLmdlen48UmoOPMRzXaLE73dUrs2IPGM4tnzJfmpakdkGRom/3c7F
         CyifPSdlEld9Vp9EXsgzLnUDashahf69YyFZRQwkNRb7cWG5tnet/dWjOlb3kq8XswEA
         mGZvJKSfBFsJNTkeNjhAAuSm6r3tJ8eNs1Xl/UJy/jbSBkc60z0krpi/Ggp+bzB0Z8KX
         xdAqCeL6OgTEacyYiB8RpTCaxNGrcZbSMMORIKJptcFy3ymdL6+d9l8w1/dYB1eeH6lB
         Z+Lg==
X-Gm-Message-State: ALyK8tJme8bW/QaDDhn0LqbeyLbLtQIp0YOYAeREDJT1Pr4l7kM7ikux9/8EJuZ/cnGhHk1TJAjyjT9uYIJsiw==
X-Received: by 10.107.137.214 with SMTP id t83mr11930828ioi.20.1467712061504;
 Tue, 05 Jul 2016 02:47:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.168.168 with HTTP; Tue, 5 Jul 2016 02:47:40 -0700 (PDT)
In-Reply-To: <577AD8FB.3040909@gmail.com>
References: <1466856870-17153-1-git-send-email-prasannatsmkumar@gmail.com> <577AD8FB.3040909@gmail.com>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Tue, 5 Jul 2016 15:17:40 +0530
Message-ID: <CANc+2y5mJDv9Vrg2q+2VVNFGr6BYOydhjF_jcJrB6q4_erMecQ@mail.gmail.com>
Subject: Re: [RFC] mips: Add MXU context switching support
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        John Stultz <john.stultz@linaro.org>, mguzik@redhat.com,
        athorlton@sgi.com, mhocko@suse.com, ebiederm@xmission.com,
        gorcunov@openvz.org, luto@kernel.org, cl@linux.com,
        serge.hallyn@ubuntu.com, Kees Cook <keescook@chromium.org>,
        jslaby@suse.cz, akpm@linux-foundation.org, macro@imgtec.com,
        mingo@kernel.org, alex.smith@imgtec.com,
        markos.chandras@imgtec.com, Leonid.Yegoshin@imgtec.com,
        david.daney@cavium.com, zhaoxiu.zeng@gmail.com, chenhc@lemote.com,
        Zubair.Kakakhel@imgtec.com, james.hogan@imgtec.com,
        Paul Burton <paul.burton@imgtec.com>, ralf@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54213
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

> This is all well and good and seems useful, but you have not stated why
> this is even useful in the first place?

Sorry, should have done that already. MXU is the name for SIMD
instructions found in Ingenic SoC. Registers xr0 to xr16 is used by
MXU instructions. I will add info when I submit next version of the
patch.

>> +     unsigned int mxu_used;
>> +     /* Saved registers of Xburst MXU, if available. */
>> +     struct xburst_mxu_state mxu;
>
> That's adding about 17 * 4 bytes to a structure that is probably best
> kept as small as possible, might be worth adding an ifdef here specific
> to the Ingenic platforms w/ MXU?

Yes, makes sense. Will do.

>> @@ -410,4 +423,10 @@ extern int mips_set_process_fp_mode(struct task_struct *task,
>>  #define GET_FP_MODE(task)            mips_get_process_fp_mode(task)
>>  #define SET_FP_MODE(task,value)              mips_set_process_fp_mode(task, value)
>>
>> +extern int mips_enable_mxu_other_cpus(void);
>> +extern int mips_disable_mxu_other_cpus(void);
>> +
>> +#define ENABLE_MXU_OTHER_CPUS()         mips_enable_mxu_other_cpus()
>> +#define DISABLE_MXU_OTHER_CPUS()        mips_disable_mxu_other_cpus()
>
> Where is the stub when building for !MIPS? Have you build a kernel with
> your changes for e.g: x86?

I have missed it. Will add it for sure. Did not check for other arch,
will do it before submitting next revision.

>> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
>> index a8d0759..b193d91 100644
>> --- a/include/uapi/linux/prctl.h
>> +++ b/include/uapi/linux/prctl.h
>> @@ -197,4 +197,7 @@ struct prctl_mm_map {
>>  # define PR_CAP_AMBIENT_LOWER                3
>>  # define PR_CAP_AMBIENT_CLEAR_ALL    4
>>
>> +#define PR_ENABLE_MXU_OTHER_CPUS        48
>> +#define PR_DISABLE_MXU_OTHER_CPUS       49
>> +
>>  #endif /* _LINUX_PRCTL_H */
>> diff --git a/kernel/sys.c b/kernel/sys.c
>> index 89d5be4..fbbc7b2 100644
>> --- a/kernel/sys.c
>> +++ b/kernel/sys.c
>> @@ -2270,6 +2270,12 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>>       case PR_GET_FP_MODE:
>>               error = GET_FP_MODE(me);
>>               break;
>> +     case PR_ENABLE_MXU_OTHER_CPUS:
>> +             error = ENABLE_MXU_OTHER_CPUS();
>> +             break;
>> +     case PR_DISABLE_MXU_OTHER_CPUS:
>> +             error = DISABLE_MXU_OTHER_CPUS();
>> +             break;
>
> Is not there a way to call into an architecture specific prctl() for the
> unhandled options passed to prctl()? Not everybody will
> want/implement/support that, and, more importantly changing generic code
> here looks fishy and probably the wrong abstraction.

PR_GET_FP_MODE is specific to MIPS and is present in arch independent
code. I followed similar structure. If it makes sense to put into arch
specific prctl() I will do that.

Thanks for your review. Really appreciate it.
