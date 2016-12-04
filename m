Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Dec 2016 22:37:20 +0100 (CET)
Received: from mail-qk0-f179.google.com ([209.85.220.179]:36782 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993139AbcLDVhNmFOkf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 4 Dec 2016 22:37:13 +0100
Received: by mail-qk0-f179.google.com with SMTP id n21so329096159qka.3
        for <linux-mips@linux-mips.org>; Sun, 04 Dec 2016 13:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=20F/xddCveKSXuWm0LE6/5xFZeUQC7rRi0ys+HG44dc=;
        b=T07UbQ7BVu66i+73xdB8CaizX0ndRu9hH3isgqh0Por9CokkKqVQTImsaE7NmYNlRN
         p5zm9MQleyL5lB8l9RmnRQbdSU4i9GusM3OymGGQ/BQe5OTLIen+qqWGRYDyGB2gmzZo
         KMp0w5NsONXfX1xl5Vq/ph0jFwB9mViyvkD8LBpEVPt3i2YKtRXI6IWgU9pWrJArNqDL
         AxaPqctejFkqkVaxK0OCABSjhwXxdR8jn5KMv0LC2iElhhJWl5eHmfk2ziguVwruzT67
         EktMgiNy4Hd1c16xsN9d9RGxRI8J3H1sQnqc9y2EM2odRntHjhMzxMb95kXnt/4C6t2z
         Qmqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=20F/xddCveKSXuWm0LE6/5xFZeUQC7rRi0ys+HG44dc=;
        b=lmREuzdkxV4EZMCysZwQXGiNuUlQ1VKzQSIIOESX8THOfkkSuM7zBOC3KYuyBvIED7
         T762Q41d5VQ+PBpm70nrbPkRbfia+n0jQxlDqKQ4d0OVePiDxncz68AbY8VV6BuLjhWg
         T3jjI7nTRV0hkKF/84gzXqU1YEP3ll5GS7Adn0hXdfpficGkhn8PCJUZVA0eEVkFL3jS
         G6jF92HjuYR1ZSpaeiOgALLL2fOwiHjCzL5jYGa2ci3AoxU5AHKjCdH4YwF1/Ptx9Zd9
         GZ4v1GHwNvB61QEJOgK0Ne1Y59Qua5sswLyGSj8vP7QkvYRYbJzr9G5McIiqcwd0ZBRr
         JySQ==
X-Gm-Message-State: AKaTC03IF1KbIiSiWtQbU7Ind6PCd4nzfplz/qGG0bQYFFmaWGmp5/Nvrr3htii1o+8ozwd6jNIcqfnAy/y0cw==
X-Received: by 10.55.123.129 with SMTP id w123mr52477672qkc.288.1480887427773;
 Sun, 04 Dec 2016 13:37:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.170.215 with HTTP; Sun, 4 Dec 2016 13:36:47 -0800 (PST)
From:   Sagar Borikar <sagar.borikar@gmail.com>
Date:   Sun, 4 Dec 2016 13:36:47 -0800
Message-ID: <CAFwMWxtEOWEA=EUzj_-k6GSqSeK9fNj9YwvjZVXX-y3nM-Sk5A@mail.gmail.com>
Subject: Crash doesn't detect the highmem addresses.
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <sagar.borikar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55940
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

Hi,

While debugging panic triggered by kernel modules in Interaptiv MIPS
platform, I see that that crash doesn't decode the high mem addresses
as the crash notes depend upon "System RAM" regions in /proc/iomem.

# cat /proc/iomem | grep -i "System"
00044000-042fffff : System RAM
09b00000-0d1fffff : System RAM

But highmem regions(0x20000000 onwards on this platform) are not
included in that segment due to following code in resource_init:

732         if (start >= HIGHMEM_START)
733             continue;

Any reason why highmem is not parsed under resource_init? How can
crash decode the high mem addresses correctly if the region is not
specified in /proc/iomem?

Thanks
Sagar
