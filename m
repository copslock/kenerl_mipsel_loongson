Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Apr 2011 20:14:46 +0200 (CEST)
Received: from mxout1.idt.com ([157.165.5.25]:41490 "EHLO mxout1.idt.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493114Ab1DRSOn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Apr 2011 20:14:43 +0200
Received: from mail.idt.com (localhost [127.0.0.1])
        by mxout1.idt.com (8.13.1/8.13.1) with ESMTP id p3IIEYBQ020801;
        Mon, 18 Apr 2011 11:14:34 -0700
Received: from corpml1.corp.idt.com (corpml1.corp.idt.com [157.165.140.20])
        by mail.idt.com (8.13.8/8.13.8) with ESMTP id p3IIEXCs006894;
        Mon, 18 Apr 2011 11:14:33 -0700 (PDT)
Received: from CORPEXCH1.na.ads.idt.com (localhost [127.0.0.1])
        by corpml1.corp.idt.com (8.11.7p1+Sun/8.11.7) with ESMTP id p3IIEXf06258;
        Mon, 18 Apr 2011 11:14:33 -0700 (PDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: How can I access h/w registers in user space?
Date:   Mon, 18 Apr 2011 11:14:32 -0700
Message-ID: <AEA634773855ED4CAD999FBB1A66D07601988EC8@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <BANLkTi=QLZe68o2=1Vk+4QTu-ru1T6H=vQ@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How can I access h/w registers in user space?
Thread-Index: Acv94LXbFQYxe8swS82Fzq24UnJ9RQAEoqEw
References: <AEA634773855ED4CAD999FBB1A66D07601988DFA@CORPEXCH1.na.ads.idt.com> <BANLkTi=QLZe68o2=1Vk+4QTu-ru1T6H=vQ@mail.gmail.com>
From:   "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
To:     "Manuel Lauss" <manuel.lauss@googlemail.com>,
        <linux-mips@linux-mips.org>
X-Scanned-By: MIMEDefang 2.43
Return-Path: <Andrei.Ardelean@idt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29779
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Andrei.Ardelean@idt.com
Precedence: bulk
X-list: linux-mips

Hi,

Mmap() worked fine for one io memory region, but when I tried to open
twice for different io memory regions with different base addresses and
sizes it didn't work. It returned the same memory pointer value in both
cases. In my design the h/w guys put those h/w registers in two distinct
memory mapped regions with a large reserved area in between. Is it any
solution for this case?

Thanks,
Andrei
