Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Apr 2012 15:08:51 +0200 (CEST)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:42034 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903667Ab2DYNIe convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Apr 2012 15:08:34 +0200
Received: by ghbf11 with SMTP id f11so60443ghb.36
        for <multiple recipients>; Wed, 25 Apr 2012 06:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=/As8ERqEKJSm+yxMCscwhVfo3iTTuV1RUSSP92pBDzg=;
        b=uIOCmafehakCyX7qYXuiaw8s9gfigUJ7A0hsat3sv6i7T5w2LkS07kyKE9sLoyKuoQ
         0RhHAtic+TgZOpaZ9EM38V2+fqxwTlvY16Hj9uc8JwzLArAFaflwv70N+iQFFq/qWFrf
         yIzHTO7IRcsRLqJhY1PiabjQNLYCyRRc7me80VBa5ze2g7+YCgOD2wqqSKjGjq7gvwUD
         c+fQ0qLE5BiaTU0C/zlMuUfHLsegmhJfDbWcPZ5x+4hil8FGVsei1XE3IYNxw2IICP5w
         flLFdm3RQnZ6pKJEkcqFpY9qhNR5Sw6WDcpH1sFCCZ+963wIEXkr8qBcNRuVYWdEZMM7
         fekQ==
MIME-Version: 1.0
Received: by 10.50.6.161 with SMTP id c1mr2213107iga.73.1335359308292; Wed, 25
 Apr 2012 06:08:28 -0700 (PDT)
Received: by 10.64.7.115 with HTTP; Wed, 25 Apr 2012 06:08:28 -0700 (PDT)
In-Reply-To: <CAJ8eaTzRZdO6a_p+qsuFZkF7LbVcBD1Np190vVPaoRpin5=RsQ@mail.gmail.com>
References: <CAJ8eaTzRZdO6a_p+qsuFZkF7LbVcBD1Np190vVPaoRpin5=RsQ@mail.gmail.com>
Date:   Wed, 25 Apr 2012 18:38:28 +0530
Message-ID: <CAJ8eaTyJnqkyVN4k_cVZ1SXvwGf_4JYGVWZDwZ_Zjvq34NGvtg@mail.gmail.com>
Subject: Re: backtrace issue in MIPS 3.0
From:   naveen yadav <yad.naveen@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 33010
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yad.naveen@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Add lkml also

On Wed, Apr 25, 2012 at 6:17 PM, naveen yadav <yad.naveen@gmail.com> wrote:
> Dear Ralf,
>
> We observe the following issue in kernel backtrace.
>
> Scenario:1
> Correct backtrace - if HAVE_FUNCTION_TRACER is disable.
>
> ====[ backtrace testing ]===========
> Testing a backtrace from process context.
> The following trace is a kernel self test and not a bug!
> Testing a backtrace.
> The following trace is a kernel self test and not a bug!
> Call Trace:
> [<80295134>] dump_stack+0x8/0x34
> [<c0946060>] backtrace_regression_test+0x60/0x94 [sisc_backtrcae]
> [<800004f0>] do_one_initcall+0xf0/0x1d0
> [<80060954>] sys_init_module+0x19c8/0x1c60
> [<8000a418>] stack_done+0x20/0x40
>
> Scenaro-2:
> if HAVE_FUNCTION_TRACER is enabled
>        HAVE_FUNCTION_TRACER function enables FRAME_POINTER
>      menuconfig->
>               kernel hacking->
>                                    tracers->
>                                                 Kernel Function Tracer
>
> ====[ backtrace testing ]===========
>
> Testing a backtrace from process context.
>
> The following trace is a kernel self test and not a bug!
>
> Testing a backtrace.
>
> The following trace is a kernel self test and not a bug!
>
> Call Trace:
>
> [<802e5164>] dump_stack+0x1c/0x50
>
> [<802e5164>] dump_stack+0x1c/0x50
>
> ====[ end of backtrace testing ]====
>  ----------------------------------------------------------------------------------------------------------------------------------------------------
>
> Sample Code:
>
> #include <linux/module.h>
> #include <linux/sched.h>
> #include <linux/delay.h>
> //static struct timer_list backtrace_timer;
>
> static void backtrace_test_timer()
> {
>        printk("Testing a backtrace.\n");
>        printk("The following trace is a kernel self test and not a bug!\n");
>        dump_stack();
> }
> static int backtrace_regression_test(void)
> {
>        printk("====[ backtrace testing ]===========\n");
>        printk("Testing a backtrace from process context.\n");
>        printk("The following trace is a kernel self test and not a bug!\n");
>        backtrace_test_timer();
>        msleep(10);
>        printk("====[ end of backtrace testing ]====\n");
>        return 0;
> }
> static void exitf(void)
> {
> }
>
> module_init(backtrace_regression_test);
> module_exit(exitf);
> MODULE_LICENSE("GPL");
>
>
> objdump is also attached.
>
> Thanks
