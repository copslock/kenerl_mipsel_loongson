Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Sep 2010 16:00:46 +0200 (CEST)
Received: from mxout1.idt.com ([157.165.5.25]:42601 "EHLO mxout1.idt.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491919Ab0I0OAn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Sep 2010 16:00:43 +0200
Received: from mail.idt.com (localhost [127.0.0.1])
        by mxout1.idt.com (8.13.1/8.13.1) with ESMTP id o8RE0YGr005593;
        Mon, 27 Sep 2010 07:00:35 -0700
Received: from corpml1.corp.idt.com (corpml1.corp.idt.com [157.165.140.20])
        by mail.idt.com (8.13.8/8.13.8) with ESMTP id o8RE0XB9010087;
        Mon, 27 Sep 2010 07:00:33 -0700 (PDT)
Received: from CORPEXCH1.na.ads.idt.com (localhost [127.0.0.1])
        by corpml1.corp.idt.com (8.11.7p1+Sun/8.11.7) with ESMTP id o8RE0WQ26568;
        Mon, 27 Sep 2010 07:00:32 -0700 (PDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Does Linux MIPS use scratch pad ram?
Date:   Mon, 27 Sep 2010 07:00:30 -0700
Message-ID: <AEA634773855ED4CAD999FBB1A66D07601159E63@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <4C9D3153.8020901@paralogos.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
thread-topic: Does Linux MIPS use scratch pad ram?
thread-index: ActcPwdQCurd/eumR6WDFFf2IEYQcgCDJpCQ
References: <AEA634773855ED4CAD999FBB1A66D07601159CB4@CORPEXCH1.na.ads.idt.com> <4C9D3153.8020901@paralogos.com>
From:   "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
To:     "Kevin D. Kissell" <kevink@paralogos.com>
Cc:     <linux-mips@linux-mips.org>
X-Scanned-By: MIMEDefang 2.43
X-archive-position: 27831
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Andrei.Ardelean@idt.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 21271

Hi Kevin,

I don't have the new h/w yet so I don't know how the Flash will react.
In the mem map of the new board I see Flash at 0x1c000000 where MALTA
Linux probes for spram and my job so far is to port Linux for the new
board. So, I understand from your email that spram probing will not mess
up with my Flash and I should ignore it.

Thanks,
Andrei


-----Original Message-----
From: Kevin D. Kissell [mailto:kevink@paralogos.com] 
Sent: Friday, September 24, 2010 7:17 PM
To: Ardelean, Andrei
Cc: linux-mips@linux-mips.org
Subject: Re: Does Linux MIPS use scratch pad ram?

I find it hard to believe that you've got Flash responding in place of 
the CP0 cache tag registers.

On 09/24/10 14:45, Ardelean, Andrei wrote:
> Hi,
>
> I am using MALTA platform and try to port Linux on a new platform.
> It seems to me that in spram.c the sprams are probed  if they are
> available or not but I cannot see Linux really using those afterwards.
> My platform has no spram so I am trying to avoid this probing. The
> problem is that spram.c is not MALTA specific but as the comment says
in
> spram.c there are some MALTA specific addresses. Unfortunately I have
> some Flash at those addresses.
> How to fix this issue?
>
> Thanks,
> Andrei
>
>
>    
