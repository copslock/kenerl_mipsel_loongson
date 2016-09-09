Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Sep 2016 05:34:30 +0200 (CEST)
Received: from mail-vk0-f54.google.com ([209.85.213.54]:34795 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990518AbcIIDeXgl0XM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Sep 2016 05:34:23 +0200
Received: by mail-vk0-f54.google.com with SMTP id v189so58537015vkv.1
        for <linux-mips@linux-mips.org>; Thu, 08 Sep 2016 20:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=ErLXiQu+BToDncoIjrp0LQGDdIE9bSSXySJcp361nZU=;
        b=aL1kDOi3bq0ebiPKlZcmc8EOmgpUVN2JTRUL/IuaKOXfKW4SYOVB9yAHHIB0dV/IKD
         aEEXKeMRoCpKbVg7IiN298qhUd45GLPopKQbFbFw1SfOs4WRpsc2PwBs8dO+Pt6WCqmJ
         qmCHgdFEHKQt19TL29tPy+43dgycO3/7dC1Y+XwSwVzCr6mSzOV67kmYsEYVuM65lptj
         blyqpi8lMsctPEzDvIF0fL/h0Yb7XxmXKELnCBXnGt2NkIzm520sRzpveTqcVXct87+E
         L1mzmJ5p6kH62AxglB0UgbpsM1AphNjVOkHjqYRWdyBeLrYCBbD0ADz0nNckKo2GDG9c
         lVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ErLXiQu+BToDncoIjrp0LQGDdIE9bSSXySJcp361nZU=;
        b=C6ytFDuB+eVMHEHdcf4Pcl/+kF+dRtSKd9sKWSvoWab/0AYSm4vQxdOSI9ml2Q4zNX
         x2veKHSICIetsy56FvW+ZzWHkAL577f6YTd+FWA7yHl7ODyUmLFGD20v1aMu4U9Rm3gH
         vpRZLCqda4CoNXP6vypCd4QSdFCWlv5rkJmzCrZP7d0axDSPg14mLPJfEvQPQT86MRlm
         sH/c7eXdt+hjGqO7jJGZpa1ksdbdAMvWSuZt6MXEfC5ZsPOqAsfDtvyDz4sMyLScRhuf
         bc2TuYg+gH1PVDtZC2HP0IZt72t2Z7DiadlDgowh9WkUS9lVN/fxRA4Ssp2yBL5Q6qBG
         ss/w==
X-Gm-Message-State: AE9vXwO8/EUOZmRwyuuDhFxONt970UyLXoN9EEkYMtMS8xHzab1oCBh8LsquMft/lPGyCZMmcaRaKMs4dKM0ug==
X-Received: by 10.31.131.195 with SMTP id f186mr822699vkd.147.1473392057645;
 Thu, 08 Sep 2016 20:34:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.242.73 with HTTP; Thu, 8 Sep 2016 20:33:57 -0700 (PDT)
From:   Sagar Borikar <sagar.borikar@gmail.com>
Date:   Thu, 8 Sep 2016 20:33:57 -0700
Message-ID: <CAFwMWxtUHa_Av34RrzFp3Dar0y-ghQRJNeXeUqYeUo3149zOsw@mail.gmail.com>
Subject: highmem issues with 3.14.10 (LST)
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <sagar.borikar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55078
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sagar.borikar@gmail.com
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

Hello,

I am upgrading kernel for a MIPS Interaptive CPU from 3.10.60 to
3.14.10 (stable) from:
https://www.linux-mips.org/wiki/Malta_Linux_Repository

 The platform has non-contiguous low memory and high memory. After the
upgrade, highmem is not getting enabled due to max_low_pfn and
highend_pfn not being the same.

The commit cce335ae47e231398269fb05fa48e0e9cbf289e0 introduced the
change apparently for sibyte platform. That change doesn't hold good
for all platforms where the high memory and low memory is sparsed.

If I comment out only following change in arch/mips/mm/init.c, highmem
gets initialized properly.

296     if (cpu_has_dc_aliases && max_low_pfn != highend_pfn) {
297         printk(KERN_WARNING "This processor doesn't support highmem."
298                " %ldk highmem ignored\n",
299                (highend_pfn - max_low_pfn) << (PAGE_SHIFT - 10));
300         max_zone_pfns[ZONE_HIGHMEM] = max_low_pfn;
301         lastpfn = max_low_pfn;
302     }

So wanted to know whether there is additional change required in
platform to work with above codebase.
Secondly, when the system proceeds (with commented code above), it
seems execve causes panic in copy_strings:

Kernel bug detected[#1]:
CPU: 0 PID: 177 Comm: mcp Not tainted 3.14.10 #19
task: 82c99070 ti: 829b0000 task.ti: 829b0000
$ 0   : 00000000 81a40018 00000001 00000528
$ 4   : 806805b0 00000294 00000000 81c76000
$ 8   : 82c99070 fe001ffc 00000000 805d0000
$12   : 00000000 00000000 00000000 00000001
$16   : 8214a760 00000000 81a40010 82c2c580
$20   : ffffffff 7fff7000 00000000 00000008
$24   : 00000000 801182a0
$28   : 829b0000 829b1e78 8214a760 801bb0bc
Hi    : 000000e1
Lo    : 00077c44
epc   : 801bb014 copy_strings+0x304/0x394
    Not tainted
ra    : 801bb0bc copy_strings_kernel+0x18/0x2c
Status: 1100fc03        KERNEL EXL IE
Cause : 10800034
PrId  : 0001a020 (MIPS interAptiv)
Modules linked in:
Process mcp (pid: 177, threadinfo=829b0000, task=82c99070, tls=770b82f0)
Stack : 00000080 00000000 00000000 00000000 00000017 829b1e98 00000000 00000000
          8214a760 82bba0b0 fe001000 00000ff4 80000000 00000080
82bba0b0 81a40000
          80b12b00 00000001 80b12b00 7fe5e66c 81c40000 801bb0bc
80b12b00 82c2c630
          82c2c580 00000080 82c2c580 801bc4d4 00000003 8013452c
7649e000 7648fa08
          82c99234 00000000 00000601 80b12b34 7649e000 7648fa08
7649e000 7fe5dc50
         ...
Call Trace:
[<801bb014>] copy_strings+0x304/0x394
[<801bb0bc>] copy_strings_kernel+0x18/0x2c
[<801bc4d4>] do_execve+0x2fc/0x4c4
[<8010d37c>] handle_sys+0x11c/0x140
Code: 0806ec05  00000000  24020001 <00020336> 0c045e64  02002021
0c0651dd  02002021  0806ec1d
---[ end trace ed487c3c490d886b ]---
BUG: Bad rss-counter state mm:828bd6a0 idx:1 val:2

This panic occurs only when I spawn nested fork/execve. If I spawn the
process directly without nesting, I don't see this panic.

Looks like there are several reports about "Bad rss-counter state"
panic with 3.14-stable. But I couldn't find any concrete solution to
the panic.

Any pointers?

Thanks

Sagar
