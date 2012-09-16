Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Sep 2012 17:38:40 +0200 (CEST)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:62413 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903052Ab2IPPid (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Sep 2012 17:38:33 +0200
Received: by eaai12 with SMTP id i12so2046096eaa.36
        for <multiple recipients>; Sun, 16 Sep 2012 08:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=htV8wC9q/4GjeN07lmsoUzdY0tQUFc2M1i88ToaEvEY=;
        b=q+C3Zaf8Am+6vgi9GEaL08Y7ni0K0cTgBInV0nlgwgBMa8iWM1wx5iNiuytpTVrdW7
         29SCNr2GpPH6SJKjafP4ueFdwcLYVXonc1aAB9Pk3RA9cuT3vbMXa5VKNYWChhdWn8c7
         qIYMD3C05UdrgAwLZ6aQHG/bqebC9ciTe4J73l02ZTqjy6UjJ/BkaQMsZaFOc9eam0xe
         +Zpi0SAEQz2PkosLCZ3UXdFWfNwicIEht2/Be1R33A7HuELGP0nQGcQn2kC8UPQ3FXuN
         d2LyiSojxRsPgPXcqhUhGiWaNWjfat96E4WAUX0lPCdFic5xWCmRbZE5PTZvipQRYeuV
         c+JQ==
MIME-Version: 1.0
Received: by 10.14.173.9 with SMTP id u9mr10543738eel.8.1347809908368; Sun, 16
 Sep 2012 08:38:28 -0700 (PDT)
Received: by 10.14.179.71 with HTTP; Sun, 16 Sep 2012 08:38:28 -0700 (PDT)
In-Reply-To: <1347806915-25132-1-git-send-email-hauke@hauke-m.de>
References: <1347806915-25132-1-git-send-email-hauke@hauke-m.de>
Date:   Sun, 16 Sep 2012 08:38:28 -0700
Message-ID: <CAJiQ=7B+ohpoksFcH2Z9Twwc=3SbED1hSvssfmx5-kfb4dPJnQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: BCM47XX: select BOOT_RAW
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Cc:     john@phrozen.org, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 34519
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Sun, Sep 16, 2012 at 7:48 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> All the boot loaders I have seen are booting the kernel in raw mode by
> default. CFE seams to support elf kernel images too, but the default

Nitpick: "seems"

> case is raw for the devices I know of. Select this option to make the
> kernel boot on most of the devices with the default options.

CONFIG_BOOT_RAW only adds about 8 bytes to the kernel image.  Since
early 2008 it's just been implemented as a single jump instruction,
and it's harmless on platforms that don't need it.

Do you think it is worthwhile to delete the Kconfig option, and enable
BOOT_RAW behavior on all builds?
