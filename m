Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Jun 2013 04:05:58 +0200 (CEST)
Received: from mail.lemote.com ([222.92.8.138]:44454 "EHLO mail.lemote.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816022Ab3FWCF5kzgBy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 23 Jun 2013 04:05:57 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.lemote.com (Postfix) with ESMTP id 276DA22BC8;
        Sun, 23 Jun 2013 10:05:49 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from mail.lemote.com ([127.0.0.1])
        by localhost (mail.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BclKufqgE1-i; Sun, 23 Jun 2013 10:05:40 +0800 (CST)
Received: from mail.lemote.com (localhost [127.0.0.1])
        (Authenticated sender: chenhc@lemote.com)
        by mail.lemote.com (Postfix) with ESMTPA id 0463C22979;
        Sun, 23 Jun 2013 10:05:38 +0800 (CST)
Received: from 172.16.2.208
        (SquirrelMail authenticated user chenhc)
        by mail.lemote.com with HTTP;
        Sun, 23 Jun 2013 10:05:39 +0800
Message-ID: <0052cc5d666a1685259dcd473026aa67.squirrel@mail.lemote.com>
In-Reply-To: <20130622130914.GC19237@mails.so.argh.org>
References: <1366030028-5084-1-git-send-email-chenhc@lemote.com>
    <1366030028-5084-7-git-send-email-chenhc@lemote.com>
    <20130622130914.GC19237@mails.so.argh.org>
Date:   Sun, 23 Jun 2013 10:05:39 +0800
Subject: Re: [PATCH V10 06/13] MIPS: Loongson 3: Add HT-linked PCI support
From:   chenhc@lemote.com
To:     "Andreas Barth" <aba@ayous.org>
Cc:     "Ralf Baechle" <ralf@linux-mips.org>,
        "John Crispin" <john@phrozen.org>, linux-mips@linux-mips.org,
        "Fuxin Zhang" <zhangfx@lemote.com>,
        "Zhangjin Wu" <wuzhangjin@gmail.com>,
        "Hongliang Tao" <taohl@lemote.com>, "Hua Yan" <yanh@lemote.com>
User-Agent: SquirrelMail/1.4.22
MIME-Version: 1.0
Content-Type: text/plain;charset=gb2312
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37103
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

> * Huacai Chen (chenhc@lemote.com) [130415 14:49]:
>> Loongson family machines use Hyper-Transport bus for inter-core
>> connection and device connection. The PCI bus is a subordinate
>> linked at HT1.
>>
>> With UEFI-like firmware interface, We don't need fixup for PCI irq
>> routing.
>
> ops-loongson3 looks to my untrained eyes much like ops-loongson2.
> Would it be possible to merge the two (without useing #ifdef)?

ops-loongson2.c has some #ifdef at present. And Loongson-3 will support
more chipsets than now, so ops-loongson2 and ops-loongson3 will have more
differences in future.

>
>
> Andi
>
