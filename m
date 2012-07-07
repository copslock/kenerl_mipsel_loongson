Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Jul 2012 12:46:14 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:64115 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903536Ab2GGKqL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 Jul 2012 12:46:11 +0200
Received: by pbbrq13 with SMTP id rq13so17992104pbb.36
        for <linux-mips@linux-mips.org>; Sat, 07 Jul 2012 03:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=oJJzLxk/hth57NsKmfLEIdZ8/cQGoSR5jz7JIRkPZ3U=;
        b=Mi66/lqepcnEk7WZDBN9cCPrl5JnVrE/kVfZ2zO4MxrAZTn0tTyuC2ysuMhAV7lV84
         JwwJ9chWQJOaYRy4uWU6+TYbNfKxD/NEtfHGV2WqbGh0jhK5mIDkkWHftb3zykCNwxY2
         SwZTN7Z6/Atwh/+CAsbUhRlV6hVauXOeLUzWO+UUUtgf6gW7MFL9Vifuyz+yTTqj/oeo
         WXgpwEs6O/k/p+sjYNuCJOz8GMjq/rz/KOqLpi5VWtD2uHNd237EbDPnD7kX3G6caYI1
         edaeJpVJ6Q3fpvkwoJe/vGHpB8ofojg0GyQ5d5TbEjonoB3FWSxi7iZcjfLa/eaXuDVG
         3rEQ==
MIME-Version: 1.0
Received: by 10.68.221.74 with SMTP id qc10mr43793629pbc.31.1341657964685;
 Sat, 07 Jul 2012 03:46:04 -0700 (PDT)
Received: by 10.68.240.41 with HTTP; Sat, 7 Jul 2012 03:46:04 -0700 (PDT)
Date:   Sat, 7 Jul 2012 18:46:04 +0800
Message-ID: <CANudz+soE9jkRERLbMLJYnYR5GXpkkt2owhQSDxXSMCVY7uF2Q@mail.gmail.com>
Subject: some question about struct ktermios
From:   loody <miloody@gmail.com>
To:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Kernel Newbies <kernelnewbies@nl.linux.org>,
        kernelnewbies@kernelnewbies.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 33882
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: miloody@gmail.com
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

Dear all
"struct ktermios" is the struct used for terminal.
Why the header file is put at arch/mips/include/asm/termbits.h
Doesn't it should located at kernel/include?


-- 
Regards
