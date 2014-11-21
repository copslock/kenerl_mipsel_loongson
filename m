Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Nov 2014 14:28:27 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:44308 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006519AbaKUN2Zrhiv2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 21 Nov 2014 14:28:25 +0100
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id A02FB28C0F4;
        Fri, 21 Nov 2014 14:26:55 +0100 (CET)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-qa0-f43.google.com (mail-qa0-f43.google.com [209.85.216.43])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 0B34D28C0F0;
        Fri, 21 Nov 2014 14:26:53 +0100 (CET)
Received: by mail-qa0-f43.google.com with SMTP id bm13so3369181qab.2
        for <multiple recipients>; Fri, 21 Nov 2014 05:28:19 -0800 (PST)
X-Received: by 10.224.67.8 with SMTP id p8mr6370994qai.97.1416576498972; Fri,
 21 Nov 2014 05:28:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.95.79 with HTTP; Fri, 21 Nov 2014 05:27:58 -0800 (PST)
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Fri, 21 Nov 2014 14:27:58 +0100
Message-ID: <CAOiHx=nG0Td=9_A521NVjoixitTFxVnkvTCatubuFMKuHR+PEQ@mail.gmail.com>
Subject: git caching(?) issues with http(s)
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44340
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

Hi,

I noticed that git over http(s) seems to get stale data (just done a
few minutes ago):

~$ git clone http://git.linux-mips.org/pub/scm/ralf/upstream-sfr.git
Cloning into 'upstream-sfr'...
~$ cd upstream-sfr/
~/upstream-sfr$ git log -1
commit 475d5928b79bb78326a645863d46ff95c5e25e5a
Merge: c6b7b9f 1062080
Author: Ralf Baechle <ralf@linux-mips.org>
Date:   Sat Aug 2 00:07:03 2014 +0200

    Merge branch '3.16-fixes' into mips-for-linux-next

while using git:
~$git clone git://git.linux-mips.org/pub/scm/ralf/upstream-sfr.git sfr-git
Cloning into 'sfr-git'...
remote: Counting objects: 4487760, done.
remote: Compressing objects: 100% (686908/686908), done.
Receiving objects: 100% (4487760/4487760), 823.18 MiB | 47.58 MiB/s, done.
remote: Total 4487760 (delta 3795897), reused 4457674 (delta 3768509)
Resolving deltas: 100% (3795897/3795897), done.
~$ cd sfr-git
~/sfr-git$ git log -1
commit 8d3c99536e8ea7b5d0ca927982d88fa487b1bfe2
Merge: 884013a 3278c5a
Author: Ralf Baechle <ralf@linux-mips.org>
Date:   Fri Nov 21 01:13:48 2014 +0100

    Merge branch '3.18-fixes' into mips-for-linux-next


Jonas
