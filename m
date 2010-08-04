Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Aug 2010 09:02:06 +0200 (CEST)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:59088 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491077Ab0HDHCD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Aug 2010 09:02:03 +0200
Received: by eyd10 with SMTP id 10so2157324eyd.36
        for <linux-mips@linux-mips.org>; Wed, 04 Aug 2010 00:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=uWhoO6JscEUxA34AtG5sacAEYm2IL37D9yq0zGRAhX0=;
        b=SnCiW0A089C1N1CjGghOoWmjJmhO+pRMAlZw1bFNoHEVGLEli7zV+R8fY7trI5mYQv
         cvICSDsInuNN++MnOc9LvFS/ht8n1oH2WrA/mM/qSFZ9uLu8Ivc5L9Z5ZDcdEiKw9ZU8
         wERHy+QjL//2lWdPX9eZkHYNlqFLKKPu+8LmA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=jVPTkxS0Ip5w60mi9NTWAOBi5nwy4GiT1YcPt4Mgmhib+iKkg7wmBfnwtcEawTkumU
         MvkX81Yop7XesPpdfJ5G23eh3X6YTmCGjpa/v1oggARl0CTR+7O5tCANW9aLIBRd4vfH
         tc7ZBXOWVirC16iTuZzVyEmk2CQ7oKrckxGxg=
MIME-Version: 1.0
Received: by 10.213.48.131 with SMTP id r3mr6266498ebf.69.1280905321100; Wed, 
        04 Aug 2010 00:02:01 -0700 (PDT)
Received: by 10.14.127.13 with HTTP; Wed, 4 Aug 2010 00:02:01 -0700 (PDT)
Date:   Wed, 4 Aug 2010 15:02:01 +0800
Message-ID: <AANLkTinCjSTE7sYa7JdqwAEe-4nZJKAvVfg5q4YVVqC7@mail.gmail.com>
Subject: [Q] enabling FPU for vpe1
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27562
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,


I'm working on a 34Kf CPU. I understand that only one TC can use the
FPU at any given time.

My question is: If a TC is attached to the 2nd VPE (i.e. VPE1), can I
enable FPU for it?

I experimented on this, but failed to do it. Am I missing something?


Thanks

Deng-Cheng
