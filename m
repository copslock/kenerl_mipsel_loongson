Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Nov 2011 10:42:04 +0100 (CET)
Received: from mail.lemote.com ([222.92.8.141]:46725 "EHLO lemote.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904027Ab1KQJkp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 Nov 2011 10:40:45 +0100
Received: from localhost (localhost [127.0.0.1])
        by lemote.com (Postfix) with ESMTP id CD1FA31D74D
        for <linux-mips@linux-mips.org>; Thu, 17 Nov 2011 17:14:24 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from lemote.com ([127.0.0.1])
        by localhost (www.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Q44-nt9qmyfZ for <linux-mips@linux-mips.org>;
        Thu, 17 Nov 2011 17:14:14 +0800 (CST)
Received: from mail-fx0-f49.google.com (mail-fx0-f49.google.com [209.85.161.49])
        by lemote.com (Postfix) with ESMTP id 9F6CD31D74A
        for <linux-mips@linux-mips.org>; Thu, 17 Nov 2011 17:14:13 +0800 (CST)
Received: by faar25 with SMTP id r25so3318321faa.36
        for <linux-mips@linux-mips.org>; Thu, 17 Nov 2011 01:40:20 -0800 (PST)
Received: by 10.204.141.24 with SMTP id k24mr19042694bku.97.1321522820211;
 Thu, 17 Nov 2011 01:40:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.85.201 with HTTP; Thu, 17 Nov 2011 01:39:56 -0800 (PST)
From:   Chen Jie <chenj@lemote.com>
Date:   Thu, 17 Nov 2011 17:39:56 +0800
Message-ID: <CAGXxSxWUfNysqpfG0hWGYC0WyOMWS5R+K4euZ9miD3UD43F94A@mail.gmail.com>
Subject: [Question] What's difference between ioremap_wc and ioremap_uncached_accelerated?
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 31719
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenj@lemote.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14297

Hi all,

I noticed mips defines an ioremap_uncached_accelerated in
arch/mips/include/asm/io.h, not reuse the name of "ioremap_wc", what
is the difference?

Some drivers use ioremap_wc, e.g. ttm_bo_ioremap() in
drivers/gpu/drm/ttm/ttm_bo_util.c, I wonder whether these ioremap_wc
invocations can be replaced with "ioremap_uncached_accelerated"?



Regards,
-- Chen Jie
