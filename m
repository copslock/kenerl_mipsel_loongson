Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 May 2016 18:48:54 +0200 (CEST)
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38313 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27028060AbcEEQsxbaMR5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 May 2016 18:48:53 +0200
Received: by mail-wm0-f43.google.com with SMTP id g17so37480833wme.1
        for <linux-mips@linux-mips.org>; Thu, 05 May 2016 09:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to;
        bh=ordYhRqnSON1Bzu9+/zvNKhUyiuex8pTDKGmHO7ILu8=;
        b=iS7UjHPhWX1H8IQkH+Ayru4mrDutmEiWNu3IdqNOvNBg5OtUYrIhyvxQ78BaRGedLW
         9/jEFJlCjuyZ/DKTuCVsozU470PvmpSCaZSFqpUbE5hRkodKfLXmh4tRDLezyCUbIMh8
         uOELSOmwIgKF1OSlbXjWYiNZ2i1DBi0VzyNJVzeVkK3soHtBzgQ35u73iMGQ/XBPfIUc
         RneklprtOsShQ9Qug8y+hOY5I6lVg/nVBON95nkLGyLSxUVWRJor+ygUT1UChHjXbojZ
         /hMU9ptRvrttFHBo/vOTkrZ7083EN71Uhk+9VXIXS3n81AnCXEUoqrx8VwQ+jJaluwzD
         eXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:date:message-id:subject:from
         :to;
        bh=ordYhRqnSON1Bzu9+/zvNKhUyiuex8pTDKGmHO7ILu8=;
        b=haGi84eoDHeFUAd8GtjM6w2B3REGDqPnwBmqt+0gk86IkIJpaQL/i4hOItvBjYEuSe
         H82hTBwHbBDTse8789MzND0ePnSAT5WnMQedP+qtLYAJiA/Sqcdo3NSfKXBPhAq6nX2u
         YaFCc+gUq9CDA5R9ApddYvP6gzL8eqTUgrR1Nbll4h/76JV+OFMqPvggLQfFuYpLK2Vs
         ERe1tl5yE3yDfRjkqiaTd4POj6LMjnGhkoMRP0HDuRyzdVqdC7K44pap7aFREzC7BYVd
         pyGaAoq5Ta/ZXXv6/sj2hhE4I2d9UQqkI9NOt0s6XyGAa29amAGgXDWF+GhVpOi7ayHD
         x2sA==
X-Gm-Message-State: AOPr4FX9chvXDcUIc30LlwNlZOjLdbDpFPlWmzEr/R7FS1fUpA0N77fpqPWs8mWole7qNR0dK8O154wJxCHGBA==
MIME-Version: 1.0
X-Received: by 10.28.210.72 with SMTP id j69mr4725150wmg.12.1462466928236;
 Thu, 05 May 2016 09:48:48 -0700 (PDT)
Received: by 10.194.135.235 with HTTP; Thu, 5 May 2016 09:48:48 -0700 (PDT)
Date:   Thu, 5 May 2016 18:48:48 +0200
X-Google-Sender-Auth: 9ZGk8oFpear35DrNKlrVrvNvRXs
Message-ID: <CADrDvBfps3oLpY0Xp8Wd4Mbb7Q=b0wi9RBE0NxBKErVne5xAYg@mail.gmail.com>
Subject: proposed patches for io.h & lantiq/irq.c out of OpenWrt tickets
From:   Gerald Hollfelder <gho@gmx.de>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <ghollf@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gho@gmx.de
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

Hi,

there exists two proposed patches out of USB/PCI issues in OpenWrt CC
(and still DD)...

arch/mips/include/asm/io.h:
https://dev.openwrt.org/attachment/ticket/20997/0400-fix-IO_SPACE_LIMIT-constant.patch

arch/mips/lantiq/irq.c:
https://dev.openwrt.org/attachment/ticket/21318/0401-fix-irq-chip-for-exins.patch

Unluckily I'm not the author. So it would be great if someone could
adopt these to get some more devices working properly (again).

Kind regards

gh
