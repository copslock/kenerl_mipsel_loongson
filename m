Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Nov 2014 15:03:40 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:46059 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006529AbaKUODisKGy1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 21 Nov 2014 15:03:38 +0100
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 3772628BF1F;
        Fri, 21 Nov 2014 15:02:06 +0100 (CET)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-qg0-f42.google.com (mail-qg0-f42.google.com [209.85.192.42])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 1B19C28BD0A;
        Fri, 21 Nov 2014 15:02:03 +0100 (CET)
Received: by mail-qg0-f42.google.com with SMTP id z107so2204407qgd.29
        for <multiple recipients>; Fri, 21 Nov 2014 06:03:29 -0800 (PST)
X-Received: by 10.140.43.133 with SMTP id e5mr6939654qga.10.1416578609087;
 Fri, 21 Nov 2014 06:03:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.95.79 with HTTP; Fri, 21 Nov 2014 06:03:08 -0800 (PST)
In-Reply-To: <20141121134141.GF30205@linux-mips.org>
References: <CAOiHx=nG0Td=9_A521NVjoixitTFxVnkvTCatubuFMKuHR+PEQ@mail.gmail.com>
 <20141121134141.GF30205@linux-mips.org>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Fri, 21 Nov 2014 15:03:08 +0100
Message-ID: <CAOiHx=nJbFvUR4mBCTGdjDFkEX1onRK8P8_c3dwGwDxoox5mow@mail.gmail.com>
Subject: Re: git caching(?) issues with http(s)
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44342
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On Fri, Nov 21, 2014 at 2:41 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Fri, Nov 21, 2014 at 02:27:58PM +0100, Jonas Gorski wrote:
>> Date:   Fri, 21 Nov 2014 14:27:58 +0100
>> From: Jonas Gorski <jogo@openwrt.org>
>> To: Ralf Baechle <ralf@linux-mips.org>
>> Cc: John Crispin <john@phrozen.org>, MIPS Mailing List
>>  <linux-mips@linux-mips.org>
>> Subject: git caching(?) issues with http(s)
>> Content-Type: text/plain; charset=UTF-8
>>
>> Hi,
>>
>> I noticed that git over http(s) seems to get stale data (just done a
>> few minutes ago):
>>
>> ~$ git clone http://git.linux-mips.org/pub/scm/ralf/upstream-sfr.git
>> Cloning into 'upstream-sfr'...
>> ~$ cd upstream-sfr/
>> ~/upstream-sfr$ git log -1
>> commit 475d5928b79bb78326a645863d46ff95c5e25e5a
>> Merge: c6b7b9f 1062080
>> Author: Ralf Baechle <ralf@linux-mips.org>
>> Date:   Sat Aug 2 00:07:03 2014 +0200
>>
>>     Merge branch '3.16-fixes' into mips-for-linux-next
>
> Odd - but I have an idea what might be wrong.
>
> Are you seeing this only with the upstream-sfr tree?

Hadn't checked anything else, but looks like it also affects other trees:

~# git clone http://git.linux-mips.org/pub/scm/ralf/upstream-linus.git
Cloning into 'upstream-linus'...
~$ cd upstream-linus/
~/upstream-linus$ git log -1
commit 475d5928b79bb78326a645863d46ff95c5e25e5a
Merge: c6b7b9f 1062080
Author: Ralf Baechle <ralf@linux-mips.org>
Date:   Sat Aug 2 00:07:03 2014 +0200

    Merge branch '3.16-fixes' into mips-for-linux-next


(strangely the same commit)

Jonas
