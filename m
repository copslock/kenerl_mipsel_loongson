Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Aug 2013 06:59:31 +0200 (CEST)
Received: from mail-lb0-f169.google.com ([209.85.217.169]:49989 "EHLO
        mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822678Ab3H2E733gl5j (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Aug 2013 06:59:29 +0200
Received: by mail-lb0-f169.google.com with SMTP id u10so303853lbi.0
        for <linux-mips@linux-mips.org>; Wed, 28 Aug 2013 21:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=zSc4YBLD1YRx5XNrh1s0Cd/tjL7ecsx8lURs8pt3JDc=;
        b=X07AwCD93yXLxjLDCd1hbuYsGALDhkvwbenxbQVQdfhnpbd0n7g8d0dZGoDzJkTiw9
         ZV+XCMOxdBulaJbLjwzJuimTju2d8AyA10RvbnMEOuxDoCmKX3Z5kpUMTKKW1FLQtyVN
         2Jb8cXZ1CpRLNe4Ai82flVxZ11zLi6aXqawbaP9sjoSTpLD2jPyoZKOn5iRVCywA6+u7
         qVqbJMZG+yt7wxKp39IqOAsFbKHkRXbwmAKgIodUIWLDofAQJY6/9JqDnXKmDn/qKOCP
         gZK3iY2W2ANlwwaoAYr23zg+navivoww3dztpV+ZASn+xoWdFoSldgf8CS2He0+1chXY
         oDFg==
MIME-Version: 1.0
X-Received: by 10.152.116.7 with SMTP id js7mr1325634lab.11.1377752363839;
 Wed, 28 Aug 2013 21:59:23 -0700 (PDT)
Received: by 10.152.124.179 with HTTP; Wed, 28 Aug 2013 21:59:23 -0700 (PDT)
Date:   Thu, 29 Aug 2013 12:59:23 +0800
Message-ID: <CAF1ivSaRL91Xi0zianDp5C6XrwKp5N88dBEzLmtiDPqbdURFAw@mail.gmail.com>
Subject: Question: how could stack pointer overflow to high address?
From:   Lin Ming <minggr@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <minggr@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37705
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: minggr@gmail.com
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

Hi list,

An application segmentation faults, as below.
The stack pointer($29) at: 0x7ffcbd60
The stack memory is:
7f86b000-7f880000 rwxp 00000000 00:00 0          [stack]

I can understand stack overflow to low address, for example, due to
very deep recursive call.

But in this case, 0x7ffcbd60 > 0x7f880000
The stack overflow to high address. How could it be possible?

=====

ssk/340: potentially unexpected fatal signal 11.

Cpu 1
$ 0   : 00000000 10008d00 00000001 00000001
$ 4   : 00000001 ffffffff 00000000 7ffcbd84
$ 8   : 00000007 00000002 00000020 fffffffc
$12   : 00000807 00000800 00000400 00000008
$16   : 2ace3466 7ffcbf10 0000000a 0000000a
$20   : 004040b0 7ffcbda0 7ffcc7c8 7ffcbd84
$24   : 00000000 2b070200
$28   : 2b0b2560 7ffcbd60 7ffcbe20 2b069438
Hi    : 00000000
Lo    : 00000000
epc   : 2b07023c 0x2b07023c
    Tainted: P
ra    : 2b069438 0x2b069438
Status: 00008d13    USER EXL IE
Cause : 80000008
BadVA : 00000001
PrId  : 0002a080 (Broadcom4350)

Thanks,
Lin Ming
