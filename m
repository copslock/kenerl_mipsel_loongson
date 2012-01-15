Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Jan 2012 16:07:36 +0100 (CET)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:44180 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903559Ab2AOPHX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 15 Jan 2012 16:07:23 +0100
Received: by eaaa13 with SMTP id a13so813913eaa.36
        for <linux-mips@linux-mips.org>; Sun, 15 Jan 2012 07:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding:message-id;
        bh=CRBBRBtNG4krNYCyQBpUJo09Cz/PdZXU6isUzZP5JpQ=;
        b=X5nbjkzJJJiwR5wntpTf9EHzcxv3ipE5srDK2YlaP9K1mtoRmZfw7/IEF+bwy7C/BA
         qKgA7TjXZfs9bzhZtmyAJJULeAc0B5FfV0k4o84KQwOlccv+7ugBk3yWWxrjfO5Lnxow
         R3QXNt/R6R+oRiRHCfvq7RNUfQonsSiP/D7go=
Received: by 10.213.113.208 with SMTP id b16mr927108ebq.55.1326640038346;
        Sun, 15 Jan 2012 07:07:18 -0800 (PST)
Received: from mashiro.localnet (vasut.kolej.mff.cuni.cz. [78.128.198.52])
        by mx.google.com with ESMTPS id y12sm59292471eeb.11.2012.01.15.07.07.17
        (version=SSLv3 cipher=OTHER);
        Sun, 15 Jan 2012 07:07:17 -0800 (PST)
From:   Marek Vasut <marek.vasut@gmail.com>
To:     loody <miloody@gmail.com>
Subject: Re: Kernel coredump about kblockd deadlock
Date:   Sun, 15 Jan 2012 16:07:16 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.0-1-amd64; KDE/4.6.5; x86_64; ; )
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
References: <CANudz+um5XG2Qua6a1O7ENnBeYcfiG5mOyyA6-=ctccXMYEFhg@mail.gmail.com> <201201140129.34399.marek.vasut@gmail.com> <CANudz+txP0tQQTjtxP99AqcnJcQadHdFEHVuoPXLYfKXB0EgAA@mail.gmail.com>
In-Reply-To: <CANudz+txP0tQQTjtxP99AqcnJcQadHdFEHVuoPXLYfKXB0EgAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201201151607.16792.marek.vasut@gmail.com>
X-archive-position: 32242
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marek.vasut@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

> hi Marek:
> 
> 2012/1/14 Marek Vasut <marek.vasut@gmail.com>:
> >> Dear all:
> >> I use kernel 2.6.35.13 and cpu for mips
> > 
> > Does this happen with anything less ancient ?
> 
> Sorry for my broken English, your "less ancient" mean?

ALWAYS keep the MLs in CC. Less ancient == less old. Don't you have a 
dictionary?
> 
> Thanks for your reply.
> 
> > M
> > 
> >> When I plug in/out usb stick for several times I got following warning
> >> messages as I append at the end of mail.
> >> 
> >> is it possible correlate to below issue
> >> http://thread.gmane.org/gmane.linux.kernel/1177383/focus=69879
> >> Thanks for your help,
> >> 
> >> 
> >> INFO: task kblockd/0:10 blocked for more than 120 seconds.
> >> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
> >> message. kblockd/0        D [87016a78] 802d1e48     0    10 0x00100000
> >>      2 11       9      (kernel thread)
> >> Stack : 00000001 80107148 8562ed80 800e9098 00000001 00000001 7fffffff
> >> 00000000 00000000 7fffffff 87053d38 ffffffff 87053d38 87053d28 872ff00c
> >> 802d1e48 00000001 00000009 00000102 80071c80 00005965 0056addf 00005965
> >> 00000001 00000000 00000000 7fffffff 80020c64 00000000 00000002 00000000
> >> 00000000 7fffffff 802d1ca8 00000000 80024538 00000004 0000000a 00000001
> >> 87016a78 ...
> >> Call Trace:
> >> [<802d1764>] schedule+0x648/0x70c from[<802d1e48>]
> >> schedule_timeout+0x30/0x324 [<802d1e48>] schedule_timeout+0x30/0x324
> >> from[<802d1ca8>]
> >> wait_for_common+0xf8/0x1c0
> >> [<802d1ca8>] wait_for_common+0xf8/0x1c0 from[<80044400>]
> >> __cancel_work_timer+0x188/0x210
> >> [<80044400>] __cancel_work_timer+0x188/0x210 from[<801a48c4>]
> >> blk_cleanup_queue+0x18/0x6c
> >> [<801a48c4>] blk_cleanup_queue+0x18/0x6c from[<802098f4>]
> >> scsi_device_dev_release_usercontext+0x174/0x1e4
> >> [<802098f4>] scsi_device_dev_release_usercontext+0x174/0x1e4
> >> from[<80043aa8>] execute_in_process_context+0x30/0x5c
> >> [<80043aa8>] execute_in_process_context+0x30/0x5c from[<801eeda8>]
> >> device_release+0x54/0x90
> >> [<801eeda8>] device_release+0x54/0x90 from[<801b0180>]
> >> kobject_release+0x70/0xa8 [<801b0180>] kobject_release+0x70/0xa8
> >> from[<801b17bc>] kref_put+0x80/0x98 [<801b17bc>] kref_put+0x80/0x98
> >> from[<80203c04>] scsi_request_fn+0x51c/0x61c [<80203c04>]
> >> scsi_request_fn+0x51c/0x61c from[<801a482c>]
> >> generic_unplug_device+0x38/0x7c
> >> [<801a482c>] generic_unplug_device+0x38/0x7c from[<80043e90>]
> >> worker_thread+0x1ec/0x2d4
> >> [<80043e90>] worker_thread+0x1ec/0x2d4 from[<800482c4>]
> >> kthread+0x7c/0x84 [<800482c4>] kthread+0x7c/0x84 from[<80007818>]
> >> kernel_thread_helper+0x10/0x18
> >> 
> >> ------------------------------------------------------------------------
> >> --- ---------- hub 1-0:1.0: state 7 ports 1 chg 0000 evt 0002
> >> hub 1-0:1.0: port 1, status 0000, change 0001, 12 Mb/s
> >> usb 1-1: USB disconnect, address 35
> >> usb 1-1: unregistering device
> >> usb 1-1: unregistering interface 1-1:1.0
> >> usb 1-1: usb_disable_device nuking all URBs
> >> hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x0
> >> hub 1-0:1.0: state 7 ports 1 chg 0000 evt 0002
> >> ehci-ehci ehci-ehci.0: GetStatus port 1 status 000803 sig=j CSC CONNECT
> >> hub 1-0:1.0: port 1, status 0401, change 0001, 480 Mb/s
> >> hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x401
> >> ehci-ehci ehci-ehci.0: port 1 high speed
> >> ehci-ehci ehci-ehci.0: GetStatus port 1 status 00000d sig=se0 PEC PE
> >> CONNECT usb 1-1: new high speed USB device using ehci-ehci and address
> >> 36 ehci-ehci ehci-ehci.0: port 1 high speed
> >> ehci-ehci ehci-ehci.0: GetStatus port 1 status 00000d sig=se0 PEC PE
> >> CONNECT usb 1-1: default language 0x0409
> >> usb 1-1: udev 36, busnum 1, minor = 35
> >> ....
> >> .....
