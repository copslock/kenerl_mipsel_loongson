Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 09:47:08 +0200 (CEST)
Received: from mail-wg0-f41.google.com ([74.125.82.41]:39741 "EHLO
        mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010665AbaJGHrHWgqyi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 09:47:07 +0200
Received: by mail-wg0-f41.google.com with SMTP id b13so8636691wgh.24
        for <linux-mips@linux-mips.org>; Tue, 07 Oct 2014 00:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ljhMuyd51f4k0Z5zW98JIwCujsPK9bIbZfKS9koq4X8=;
        b=xyDG0do2YlEKTn/8WIr+lcRHKvoNZt7xJ179n9+YabPWYfgIi1eMCRMtxYiR2lp/Wk
         gZBpQ/cK288xubTR0VzK4V9mGSfQnatNphJj/bLSwwB3VfFtdn76JmTB4mqyq4FTnKN1
         CDIUkVqoQypnfB9uEkQx3IL0jvD/DVzQH3WBKGSy908id60v8GanRFmSYLQuJ3IB9NYb
         NHzvgn2HbKGLpNlkXQX6+cMhGo34LXgjqch/MOlgbzqqfvbrhUx6uT2yTu4BpYoKCSrV
         BpQLpPU9Elerv+4M6e9RG90XSkmMOSK5FaxzPzExiAEKfRNCWShjh+Ayr994vVMaffv3
         Q/lQ==
X-Received: by 10.194.93.193 with SMTP id cw1mr2662708wjb.50.1412668022144;
        Tue, 07 Oct 2014 00:47:02 -0700 (PDT)
Received: from [128.178.145.84] (lsro1pc38.epfl.ch. [128.178.145.84])
        by mx.google.com with ESMTPSA id am1sm19684284wjc.29.2014.10.07.00.47.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Oct 2014 00:47:01 -0700 (PDT)
Message-ID: <54339A73.40107@gmail.com>
Date:   Tue, 07 Oct 2014 09:46:59 +0200
From:   =?windows-1252?Q?Philippe_R=E9tornaz?= 
        <philippe.retornaz@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
MIME-Version: 1.0
To:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org
CC:     linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
        linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Len Brown <len.brown@intel.com>, linux-xtensa@linux-xtensa.org,
        Pavel Machek <pavel@ucw.cz>, devel@driverdev.osuosl.org,
        linux-s390@vger.kernel.org, lguest@lists.ozlabs.org,
        linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
        linux-sh@vger.kernel.org, Alexander Graf <agraf@suse.de>,
        linux-acpi@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        xen-devel@lists.xenproject.org, devicetree@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        linux-pm@vger.kernel.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-m68k@lists.linux-m68k.org, linux-am33-list@redhat.com,
        linux-tegra@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-alpha@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Romain Perier <romain.perier@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 01/44] kernel: Add support for poweroff handler call chain
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net> <1412659726-29957-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1412659726-29957-2-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <philippe.retornaz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43038
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: philippe.retornaz@gmail.com
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

Hello

This seems exactly what I would need on the mc13783 to handle cleanly 
the poweroff,
but after reading this patchset I have the following question:

[...]

> +/*
> + *	Notifier list for kernel code which wants to be called
> + *	to power off the system.
> + */
> +static ATOMIC_NOTIFIER_HEAD(poweroff_handler_list);

[...]

> +void do_kernel_poweroff(void)
> +{
> +	atomic_notifier_call_chain(&poweroff_handler_list, 0, NULL);
> +}
> +

It seems that the poweroff callback needs to be atomic as per
_atomic_notifier_call_chain documentation:

	"Calls each function in a notifier chain in turn.  The functions
	 run in an atomic context"

But this is a problem for many MFD (mc13783, twl4030 etc ...) which are
accessible on only a blocking bus (SPI, I2C).

What I am missing here ?

Thanks,

Philippe
