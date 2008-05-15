Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 May 2008 14:32:56 +0100 (BST)
Received: from yw-out-1718.google.com ([74.125.46.155]:30776 "EHLO
	yw-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S28573931AbYEONcx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 May 2008 14:32:53 +0100
Received: by yw-out-1718.google.com with SMTP id 9so217746ywk.24
        for <linux-mips@linux-mips.org>; Thu, 15 May 2008 06:32:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=5itivuZ/TkdrJZrbvJJAobJza0u7t72699W4GDhuURc=;
        b=wqMmrKYzKtbLXbXddGXiKO4N8PqXzXidac15NbqyNBZZBeK9n8bILmLVPg3xeCDhXBeLgyF0bCW4vm5JaGlrZ78Fm4vWU7TSwR7jae0WULKAJv0tXGJt93Men4GfJovkl+3ScqAv0+mHHcCLT3mE7CCDEveSa4vrot6S7JF37LQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sJgaL3JSwhXQjNwPpddQKuE4+ViCgIKrpfL8Y7ME8MnbEJ+9+ReqCi7Xr3CjfO13B8vOKF/SG/yL1EbEcRTFFL9O28k2FXYDZYUzXvxEVAaGirk8J1ey+VB62eC6TN/8rr6/qTJ/GSsaHjnxbBu1sn3KPJt/70kd/W1EhV5Ql3M=
Received: by 10.150.50.3 with SMTP id x3mr2260716ybx.31.1210858346681;
        Thu, 15 May 2008 06:32:26 -0700 (PDT)
Received: by 10.151.41.11 with HTTP; Thu, 15 May 2008 06:32:26 -0700 (PDT)
Message-ID: <5a8aa6680805150632m48e4fc5ck527b25c03e441986@mail.gmail.com>
Date:	Thu, 15 May 2008 15:32:26 +0200
From:	"Michael Wood" <esiotrot@gmail.com>
To:	abhiruchi.g@vaultinfo.com
Subject: Re: MIPS toolchain : should I choose shared library option for Alchemy DB1200
Cc:	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	kernel-testers <kernel-testers@vger.kernel.org>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <56119.192.168.1.70.1210857264.webmail@192.168.1.70>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <56119.192.168.1.70.1210857264.webmail@192.168.1.70>
Return-Path: <esiotrot@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19281
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: esiotrot@gmail.com
Precedence: bulk
X-list: linux-mips

Hi

On Thu, May 15, 2008 at 3:14 PM,  <abhiruchi.g@vaultinfo.com> wrote:
> hi,
>   To build cross toolchain for MIPS, should I choose shared library option. My kernel hangs after :
>
> Warning: unable to open an initial console.
> /sbin/init

The "unable to open an initial console" message is a red herring.  I
have seen it many times, e.g. running OpenWrt.  It doesn't seem to be
a problem.

> The function is in init/main.c.
>
> static int noinline init_post(void)
> {
>        ..
>        ..
>        ..
>
>        if (sys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
>                printk(KERN_WARNING "Warning: unable to open an initial console.
> \n");
>
>        (void) sys_dup(0);
>        (void) sys_dup(0);
>
>        if (ramdisk_execute_command) {
>                run_init_process(ramdisk_execute_command);
>                printk(KERN_WARNING "Failed to execute %s\n",
>                                ramdisk_execute_command);
>        }
>
>        ..
>        ..
>        printk(KERN_WARNING "-- ag. sbin init\n");
>        run_init_process("/sbin/init");
>        printk(KERN_WARNING "-- ag. etc init\n");
>        run_init_process("/etc/init");
>        printk(KERN_WARNING "-- ag. bin init\n");
>        run_init_process("/bin/init");
>        printk(KERN_WARNING "-- ag. bin sh\n");
>        run_init_process("/bin/sh");
>
>        panic("No init found.  Try passing init= option to kernel.");
>
>  }

-- 
Michael Wood <esiotrot@gmail.com>
