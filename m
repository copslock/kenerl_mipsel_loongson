Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Sep 2016 22:09:49 +0200 (CEST)
Received: from mail-lf0-f51.google.com ([209.85.215.51]:34894 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991061AbcI1UJme6KeV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Sep 2016 22:09:42 +0200
Received: by mail-lf0-f51.google.com with SMTP id l131so63727076lfl.2
        for <linux-mips@linux-mips.org>; Wed, 28 Sep 2016 13:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=B3Fsj0CsXOE0c6NwdQOnCTGyL/EO77L+yKhhLKKddC4=;
        b=0a128i+l7Cs241UBBiFwXQ9rShcHt+ZmAgaQyhHxdCV1bPbElWXoYAcl5iNOECY2qn
         7rp9yFYbFNxuNfcJ+oD+UNackESMSoWBjEPUeWFwQkG6L5/ZdUaPVqnOdgPRTTrPEA9G
         wVmh/RoSNAfcrqqM7Ij5mX83otuSS5KJY836xVrnvCedsTKypfwakLb13nbKe4QggCwq
         +TlSkfRbeRDOkrDNM9R8y8WFTrGVpuMp1okEHja9qTBC1taopHx/OWSbGhqYLKxXAVKa
         7M6w4FC0/h1OAWuO7hPlt1JxvpbIyDzcF9+FW30yu/pCjEeND9/Y9dTAjNMFZILRsuKf
         iyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=B3Fsj0CsXOE0c6NwdQOnCTGyL/EO77L+yKhhLKKddC4=;
        b=fIM0RtPYluQc0Do2/Gn7pL1MFsKYPG/br36/vKGSTbpGYXBDTHHRn6mzdiGgTu3J2w
         GOX75ShOlWO31ihDSJwn8a3AnFSf/b5E26SNvPlYxMWEbSapZ3TYiAE8EIEkWRmMazVD
         CAjTTD/8Dyf8qKoQNc+AsyxFJt6Q0b0M6lcCFHX2Z04TgCBu1axyKLgfjVW2OCuIsI6J
         ervpk7MJAO6tQ4ZLbmeJtbyiSHm9/RLc7WmHBa6Axt3S/BNTFuUUGUSd041X177Tr0IW
         7yFyvxb2N3rUaSar88TYIqDl4/BgvFBd2bOG0ChrtPmf/oNbPC+ttDyqCajfYGNkJ1Rb
         gHyA==
X-Gm-Message-State: AA6/9RkSlrQTifUaHgm+EVuUo7gO0TBXlUkyUenznJ1twEqjPKHsjH4Za+GouRYiDA5KK497haIsLrYtY/ayXg==
X-Received: by 10.46.1.136 with SMTP id f8mr4915092lji.34.1475093376640; Wed,
 28 Sep 2016 13:09:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.99.152 with HTTP; Wed, 28 Sep 2016 13:09:36 -0700 (PDT)
From:   Stefan Koch <stefan.koch10@gmail.com>
Date:   Wed, 28 Sep 2016 22:09:36 +0200
Message-ID: <CABnvfGbvdPxMGuH5482ripAxJFSFPL_DPvzVfzc6QH457X=wvg@mail.gmail.com>
Subject: [QUESTION] Physical memory allocation for VPE without mmap
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <stefan.koch10@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55288
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stefan.koch10@gmail.com
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

Hi

My question is around physical memory allocation.

This is used by VPE1 to enable FXS (analogue telephone ports) support, details:
https://dev.openwrt.org/browser/branches/barrier_breaker/target/linux/lantiq/patches-3.10/0152-VPE-extensions.patch?rev=43158

https://forum.openwrt.org/viewtopic.php?id=62696

The command line used by a MIPS based lantiq router (VRX288) at command line:
"phym=64M mem=62M vpe1_load_addr=0x83e00000 vpe1_mem=2M"

Is it possible to do this by a smoother way? So with removing the phym
and mem arguments.

I tried the following in the driver. Therefore I changed the command
line to "vpe1_load_addr=0x83e00000" (removed phym, mem, and 2M parts).
I used this within the driver: reserve_bootmem(load_addr, size,
BOOTMEM_DEFAULT). But then I will get a kernel panic at
mark_bootmem+0xec/0x120.

I have read some about QMA, too. But this needs some additional kernel
dependencies.
But in general is this useful for this problem?

Do you have some idea? What would be a good/beautiful approach?
What is the best way to alloc physical continuous public memory?
The memory should also accessible without SEGFAULT in userspace and by
other drivers.

Optional: Is there also a way that is transparent to other drivers and
userspace?
So that the drivers/userspace see still 64M max memory, but 2M as used.
With mmem way the userspace see's 62M max mem.
Especially because this bug, WIFI doesn't work with 62M :(
https://bugzilla.kernel.org/show_bug.cgi?id=110091

Thanks :)

Best regards

Stefan
