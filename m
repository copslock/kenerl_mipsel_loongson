Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Aug 2014 13:36:17 +0200 (CEST)
Received: from mail-we0-f179.google.com ([74.125.82.179]:33181 "EHLO
        mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6839123AbaHKLgOOGDO0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Aug 2014 13:36:14 +0200
Received: by mail-we0-f179.google.com with SMTP id u57so8452465wes.10
        for <linux-mips@linux-mips.org>; Mon, 11 Aug 2014 04:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=GZy1gxWj11retZooN8aXi9HY1Ytyu8/x9Bea/1YR0Mw=;
        b=mvnx4E4UHd3ZVbuSPAWQaalKKL0EaaDf1SEHIq71SSyPS3TtwkAO6kJEiGtgurRtnV
         R8tx8ePz46c4ZfkrLKg0X9ITAFidQS8iynO6g+53M1SPcVY0ecWb+R8oJFwZ8pa7y70c
         wn7tKJl/8CKB1X+Rb65w0ernAq6ldTH9RZAvoJgxSb5CR4IiAiCxvxiZpERJ0hUcRfWX
         SdI4WIOUn/oGOJUjlDymuSg9Ry8DATA8oeCmMznC2KRnefL39iXkQEemTLBO/0WPJKTa
         i/ZpvT+VXw1tg+jsCti4brfIlxe8mJz1KddODnsnlA0EYqcG7XueMOnrEgg5honJB7nA
         S85Q==
X-Received: by 10.180.86.202 with SMTP id r10mr20952651wiz.6.1407756968826;
 Mon, 11 Aug 2014 04:36:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.216.36.67 with HTTP; Mon, 11 Aug 2014 04:35:28 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Mon, 11 Aug 2014 13:35:28 +0200
Message-ID: <CAOLZvyFuDqi4+pEae=n7+ZJoAx-vca-pRS8ZAQqvTk-tSyPiwg@mail.gmail.com>
Subject: MIPS: hang in kmalloc with seccomp writer locks
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41949
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

Hi Kees,

My MIPS32 toys hang early during bootup at the first kmalloc() with
seccomp enabled.
I've bisected it to commit dbd952127d11bb44a4ea30b08cc60531b6a23d71
("seccomp: introduce writer locking").  And indeed, reverting this
commit fixes the hang.

I'm not sure if seccomp is even working on MIPS, but I've never had
problems with
it before so I thought I let you know.

Thanks, and have a nice day!
      Manuel
