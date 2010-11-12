Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Nov 2010 16:19:19 +0100 (CET)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:43587 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491849Ab0KLPTQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Nov 2010 16:19:16 +0100
Received: by eyd9 with SMTP id 9so1826537eyd.36
        for <linux-mips@linux-mips.org>; Fri, 12 Nov 2010 07:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=8Uyj+PHbWdMmv7DCoIHtFVfmMRKh19vT0PQfEYzuG+s=;
        b=babu+diyYWllG1LAnH5OmBSEJS0Leq96iX7GZnhWjuGNf5WQSiByMfk1vNjX2N5oD2
         amZftiTUnO6770u4y1IqQt9pZHbSHIKanQtY4wz7uohVb0urjT0u9HMP43bmVeLQ0LbH
         b5Hp3c6hX2dvuQr6ZKXNMeFW5cmeB+5s2KdWA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=qM+wvYOspSYcAxnsgVu1mtsj+Asfm0KQKrXjUswGVVNX5aljI3MwZqYwbm0/n5p27P
         54FEkZkQ/HvCpIKPguy+vlFKhh9TDbxQmOp1CUjXg0eRPEjgNEKRE2ZgnK6/UW9ICCSI
         NXanuoTLLhqluNuLhmzFnkp2Ih9yEW24gFh/s=
MIME-Version: 1.0
Received: by 10.216.11.66 with SMTP id 44mr2078230wew.69.1289575154831; Fri,
 12 Nov 2010 07:19:14 -0800 (PST)
Received: by 10.216.154.147 with HTTP; Fri, 12 Nov 2010 07:19:14 -0800 (PST)
Date:   Fri, 12 Nov 2010 23:19:14 +0800
Message-ID: <AANLkTimes-JyBbeUw_euOVZQiP+8a8hev8qsmhYKKHuQ@mail.gmail.com>
Subject: printk failed in cpu bus/cache error
From:   "wilbur.chan" <wilbur512@gmail.com>
To:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wilbur512@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28361
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilbur512@gmail.com
Precedence: bulk
X-list: linux-mips

linux 2.6.21.7

mips  xlr 732 configured  with 32bits system


I found that when an cpu/cache error was triggered  by an  unaligned
access , printk does not  work well in the cache error handler.


printk hangs on  spin_lock(&logbuf_lock),    further more ,  the code
was  located exactly  to :

spin_lock -- > _raw_spin_trylock -->asm( " sc	%2, %1"  )
include/asm-mips/spinlock.h



If    ' sc ' instruction  unavailable when cache error occured?
