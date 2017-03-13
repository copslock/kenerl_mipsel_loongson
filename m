Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Mar 2017 02:44:20 +0100 (CET)
Received: from mail-yw0-x234.google.com ([IPv6:2607:f8b0:4002:c05::234]:33910
        "EHLO mail-yw0-x234.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993958AbdCMBoNqdgZW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Mar 2017 02:44:13 +0100
Received: by mail-yw0-x234.google.com with SMTP id p77so51133075ywg.1
        for <linux-mips@linux-mips.org>; Sun, 12 Mar 2017 18:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=m8Y2ixJn2U/hwoMJAY9O6Q0torjKosxqTJJtljA6yVs=;
        b=FW45gjT14/6sGUijPHVdKy0N8FYFEBcg43Tvfw2noOh0NQ1ViCouDu3n9WY4w8LYAS
         WxILG8kAUJS3P0xX6CN9YMANr/ZqsKvOgtvZDluMz6v/LjBXL8yW3SqnSHYl06/Bop0c
         pIr9g0OrRvwws7QjUdtWj+IuEmaWIEwdK4YG8oX+/vR2RLVCAw02qDmYTMmtVoRaExL/
         1fUPCbLJ4y0/so3hk+k3oHKmhko3Z0Vpook2/9L+uP9EJV2Zn/hq2T2Wf1OPvkMwzait
         Neb8m/Tsw9cOtO1QatY1E/9k/2/BkNI4tPublWVfQ6BWp7mrsZRWUqXaZVUM5A5z0Oqn
         xiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=m8Y2ixJn2U/hwoMJAY9O6Q0torjKosxqTJJtljA6yVs=;
        b=i+jgN73Ea+i9E5PAccJqSvJm81F80b7hjsYK6AZTNEaY9TdEBTKDyqdyjr/0oHVbeK
         zX/5a+7g5qEtqcU/mxHPrzoFV1kDYfjTSfqKAIlaO+rXmM56wcLpe04LdbbiI4teaI1M
         KFCYbu2pjYdLpYNV499H2Q/p/djmaYfUKzo5/R/kXoLyB0A7IooaVg6I36OtRM929Zp5
         xI45J2VNt7FYYC/6zdd8JxlmwNO/1TBZM+WEXDBKOXVfXK4jN30xB+nTfYAeG8IMl9+d
         JwbhxyHClOC7JQkRmjiVOfiqHNz2O+RVovoiqjA7dvSWyJcuXV3isKg2HnSepYuRMbkA
         tAgA==
X-Gm-Message-State: AMke39md01PKOrN0FnaKJjPR3ro7jNsbu1PnY6VkWniKo/2TOLgMkMIT4kfkPBtVHhIBI8hdhhfm6bqw/XiirQ==
X-Received: by 10.129.57.70 with SMTP id g67mr16841584ywa.119.1489369448074;
 Sun, 12 Mar 2017 18:44:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.49.66 with HTTP; Sun, 12 Mar 2017 18:43:47 -0700 (PDT)
From:   Matt Turner <mattst88@gmail.com>
Date:   Sun, 12 Mar 2017 18:43:47 -0700
Message-ID: <CAEdQ38HcOgAT6wJWWKY3P0hzYwkBGSQkRSQ2a=eaGmD6c6rwXA@mail.gmail.com>
Subject: NFS corruption, fixed by echo 1 > /proc/sys/vm/drop_caches -- next
 debugging steps?
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        linux-nfs@vger.kernel.org
Cc:     Manuel Lauss <manuel.lauss@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <mattst88@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57145
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
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

On a Broadcom BCM91250a MIPS system I can reliably trigger NFS
corruption on the first file read.

To demonstrate, I downloaded five identical copies of the gcc-5.4.0
source tarball. On the NFS server, they hash to the same value:

server distfiles # md5sum gcc-5.4.0.tar.bz2*
4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2
4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.1
4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.2
4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.3
4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.4

On the MIPS system (the NFS client):

bcm91250a-le distfiles # md5sum gcc-5.4.0.tar.bz2.2
35346975989954df8a8db2b034da610d  gcc-5.4.0.tar.bz2.2
bcm91250a-le distfiles # md5sum gcc-5.4.0.tar.bz2*
4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2
4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.1
35346975989954df8a8db2b034da610d  gcc-5.4.0.tar.bz2.2
4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.3
4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.4

The first file read will contain some corruption, and it is persistent until...

bcm91250a-le distfiles # echo 1 > /proc/sys/vm/drop_caches
bcm91250a-le distfiles # md5sum gcc-5.4.0.tar.bz2*
4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2
4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.1
4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.2
4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.3
4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.4

the caches are dropped, at which point it reads back properly.

Note that the corruption is different across reboots, both in the size
of the corruption and the location. I saw 1900~ and 1400~ byte
sequences corrupted on separate occasions, which don't correspond to
the system's 16kB page size.

I've tested kernels from v3.19 to 4.11-rc1+ (master branch from
today). All exhibit this behavior with differing frequencies. Earlier
kernels seem to reproduce the issue less often, while more recent
kernels reliably exhibit the problem every boot.

How can I further debug this?
