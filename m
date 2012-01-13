Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jan 2012 14:36:34 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:50590 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901761Ab2AMNg2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Jan 2012 14:36:28 +0100
Received: by ggnl1 with SMTP id l1so1856958ggn.36
        for <linux-mips@linux-mips.org>; Fri, 13 Jan 2012 05:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Wr+ckNT7TjnbyYFFsQ1epf7j71wliFPOAq1y1mh0rzg=;
        b=S4XQpyM8IhyBa5ckID9wXRnAtywNPtuEF1L+pTF13fcsyg6QmttJQ7QGN7flPsZmC7
         W8kUcd8b05Of87JRMxxBuMcgKjgzSi7D5GfnReIuYATiDF9IZeNBv6u5umKoiSE11zCB
         ruv6QJ7pVXnn3rAxYeC7L1qcUjAQHwz/XIa0I=
MIME-Version: 1.0
Received: by 10.50.183.166 with SMTP id en6mr938808igc.7.1326461780740; Fri,
 13 Jan 2012 05:36:20 -0800 (PST)
Received: by 10.42.244.65 with HTTP; Fri, 13 Jan 2012 05:36:20 -0800 (PST)
Date:   Fri, 13 Jan 2012 21:36:20 +0800
Message-ID: <CANudz+um5XG2Qua6a1O7ENnBeYcfiG5mOyyA6-=ctccXMYEFhg@mail.gmail.com>
Subject: Kernel coredump about kblockd deadlock
From:   loody <miloody@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 32239
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: miloody@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Dear all:
I use kernel 2.6.35.13 and cpu for mips
When I plug in/out usb stick for several times I got following warning
messages as I append at the end of mail.

is it possible correlate to below issue
http://thread.gmane.org/gmane.linux.kernel/1177383/focus=69879
Thanks for your help,


INFO: task kblockd/0:10 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kblockd/0        D [87016a78] 802d1e48     0    10 0x00100000      2
          11       9      (kernel thread)
Stack : 00000001 80107148 8562ed80 800e9098 00000001 00000001 7fffffff 00000000
        00000000 7fffffff 87053d38 ffffffff 87053d38 87053d28 872ff00c 802d1e48
        00000001 00000009 00000102 80071c80 00005965 0056addf 00005965 00000001
        00000000 00000000 7fffffff 80020c64 00000000 00000002 00000000 00000000
        7fffffff 802d1ca8 00000000 80024538 00000004 0000000a 00000001 87016a78
        ...
Call Trace:
[<802d1764>] schedule+0x648/0x70c from[<802d1e48>] schedule_timeout+0x30/0x324
[<802d1e48>] schedule_timeout+0x30/0x324 from[<802d1ca8>]
wait_for_common+0xf8/0x1c0
[<802d1ca8>] wait_for_common+0xf8/0x1c0 from[<80044400>]
__cancel_work_timer+0x188/0x210
[<80044400>] __cancel_work_timer+0x188/0x210 from[<801a48c4>]
blk_cleanup_queue+0x18/0x6c
[<801a48c4>] blk_cleanup_queue+0x18/0x6c from[<802098f4>]
scsi_device_dev_release_usercontext+0x174/0x1e4
[<802098f4>] scsi_device_dev_release_usercontext+0x174/0x1e4
from[<80043aa8>] execute_in_process_context+0x30/0x5c
[<80043aa8>] execute_in_process_context+0x30/0x5c from[<801eeda8>]
device_release+0x54/0x90
[<801eeda8>] device_release+0x54/0x90 from[<801b0180>] kobject_release+0x70/0xa8
[<801b0180>] kobject_release+0x70/0xa8 from[<801b17bc>] kref_put+0x80/0x98
[<801b17bc>] kref_put+0x80/0x98 from[<80203c04>] scsi_request_fn+0x51c/0x61c
[<80203c04>] scsi_request_fn+0x51c/0x61c from[<801a482c>]
generic_unplug_device+0x38/0x7c
[<801a482c>] generic_unplug_device+0x38/0x7c from[<80043e90>]
worker_thread+0x1ec/0x2d4
[<80043e90>] worker_thread+0x1ec/0x2d4 from[<800482c4>] kthread+0x7c/0x84
[<800482c4>] kthread+0x7c/0x84 from[<80007818>] kernel_thread_helper+0x10/0x18

-------------------------------------------------------------------------------------
hub 1-0:1.0: state 7 ports 1 chg 0000 evt 0002
hub 1-0:1.0: port 1, status 0000, change 0001, 12 Mb/s
usb 1-1: USB disconnect, address 35
usb 1-1: unregistering device
usb 1-1: unregistering interface 1-1:1.0
usb 1-1: usb_disable_device nuking all URBs
hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x0
hub 1-0:1.0: state 7 ports 1 chg 0000 evt 0002
ehci-ehci ehci-ehci.0: GetStatus port 1 status 000803 sig=j CSC CONNECT
hub 1-0:1.0: port 1, status 0401, change 0001, 480 Mb/s
hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x401
ehci-ehci ehci-ehci.0: port 1 high speed
ehci-ehci ehci-ehci.0: GetStatus port 1 status 00000d sig=se0 PEC PE CONNECT
usb 1-1: new high speed USB device using ehci-ehci and address 36
ehci-ehci ehci-ehci.0: port 1 high speed
ehci-ehci ehci-ehci.0: GetStatus port 1 status 00000d sig=se0 PEC PE CONNECT
usb 1-1: default language 0x0409
usb 1-1: udev 36, busnum 1, minor = 35
....
.....
