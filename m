Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Mar 2010 18:02:22 +0100 (CET)
Received: from mail-pz0-f185.google.com ([209.85.222.185]:45827 "EHLO
        mail-pz0-f185.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492300Ab0CKRCT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Mar 2010 18:02:19 +0100
Received: by pzk15 with SMTP id 15so137595pzk.21
        for <linux-mips@linux-mips.org>; Thu, 11 Mar 2010 09:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=VmK3+9byw9jVNm3Bj3AiujA26wQCYtrD69OovXsovbo=;
        b=jn7F8Fp8McIjq+en3nWi0tEYJi88vimI9qx6sOzhoFRXWRMY01VVofZ8TcGThADLWn
         EdVZ6hkBSsT+iC37FImce5MhMKrJZW78EuZkXfXcTsYyMhudiMmQR1IlTyGZN5yfzuTU
         GLTGX+erKQc2/iyFneV0zT7kugfvHL1pWgQ48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=ugXT09E8Jz6571robkYEnEkjSBn74FQg9AGfDEAyd6qezK3jGL/BBle4E6lyRwfTsG
         BHmpPn8EpG8kRQ4NqJcWILytNeq75FQg98HDjp525yOYPjRiddBK0ai0vHKbrLtK/+6X
         2UvHYURiafptXH3m3f8KUA4/FBCpxVFgmkTR8=
MIME-Version: 1.0
Received: by 10.142.75.21 with SMTP id x21mr1464873wfa.212.1268326933081; Thu, 
        11 Mar 2010 09:02:13 -0800 (PST)
Date:   Fri, 12 Mar 2010 01:02:13 +0800
Message-ID: <3a665c761003110902o1da6dea9ib2723066b68f5f54@mail.gmail.com>
Subject: some question about memory usage in mips
From:   loody <miloody@gmail.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <miloody@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26202
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: miloody@gmail.com
Precedence: bulk
X-list: linux-mips

Dear all:
I test usb driver under mips machine and I have some questions always bother me.
1. what is the difference between dma_pool_create and
dma_alloc_coherent and where they are defined? from the result it
return, dma_pool_create will return non-cache area, but
dma_alloc_coherent returns catched area.
why they get the dma in it? Does that have special meaning?

2. what are wmb() and rmb(). used for?
do they use to flush cache? and what these 3 leterr mean?
wmb, write memory back
rmb, read memory back
appreciate your help,
miloody
