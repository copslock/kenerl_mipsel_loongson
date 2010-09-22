Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Sep 2010 20:49:42 +0200 (CEST)
Received: from mxout1.idt.com ([157.165.5.25]:34984 "EHLO mxout1.idt.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491199Ab0IVStj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Sep 2010 20:49:39 +0200
Received: from mail.idt.com (localhost [127.0.0.1])
        by mxout1.idt.com (8.13.1/8.13.1) with ESMTP id o8MInVWI003714
        for <linux-mips@linux-mips.org>; Wed, 22 Sep 2010 11:49:31 -0700
Received: from corpml3.corp.idt.com (corpml3.corp.idt.com [157.165.140.25])
        by mail.idt.com (8.13.8/8.13.8) with ESMTP id o8MInSea016459
        for <linux-mips@linux-mips.org>; Wed, 22 Sep 2010 11:49:30 -0700 (PDT)
Received: from CORPEXCH1.na.ads.idt.com (localhost [127.0.0.1])
        by corpml3.corp.idt.com (8.11.7p1+Sun/8.11.7) with ESMTP id o8MInQk10343
        for <linux-mips@linux-mips.org>; Wed, 22 Sep 2010 11:49:27 -0700 (PDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Which Linux driver (source code) is used for tty0 (console) on MALTA? 
Date:   Wed, 22 Sep 2010 11:49:25 -0700
Message-ID: <AEA634773855ED4CAD999FBB1A66D07601113E58@CORPEXCH1.na.ads.idt.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
thread-topic: Which Linux driver (source code) is used for tty0 (console) on MALTA? 
thread-index: ActahuDesXg48CQ3SXaBAu+lo68aZA==
From:   "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
To:     <linux-mips@linux-mips.org>
X-Scanned-By: MIMEDefang 2.43
X-archive-position: 27796
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Andrei.Ardelean@idt.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 17445

Hi,

I am using MALTA and my goal is to port MIPS Linux on a new platform.
Which driver (source code) is used for tty0 (console)? I see the support
for "early console" but I think that this is not the real Linux driver
used after boot stage.

More general, how to find which code source is used for an embedded
driver (part of the Kernel at compiling time) for each h/w resource.
MIPS Linux distribution comes with a lot of drivers but I have
difficulties to figure out which one is used for MALTA. Is it a files
where all those are registered?

Thanks,
Andrei
  
