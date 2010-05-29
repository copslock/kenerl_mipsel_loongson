Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 May 2010 05:08:52 +0200 (CEST)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:58151 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491031Ab0E2DIs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 29 May 2010 05:08:48 +0200
Received: by yxe42 with SMTP id 42so183245yxe.36
        for <multiple recipients>; Fri, 28 May 2010 20:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=sh4cOLPVIToxBK+JO5MW4rJeqGcIRTInUaLsNwJ2PUw=;
        b=WclXvG23/mRd27hEy2hw+bIGy5Citku20QtU6bXsUvcOtCMHLtvSG2RJ557f45Ws0e
         ost/abZoIX1Vt/Gqr1VBxpn2Eoe8bgENIbR+y3hqX+QrrgxeFMft2SuSQaZsX7wEIJx5
         JZ0UNNCQMdTsZHxbYgrWu2LzSbhNGgt1CST5E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=xexOGNQG7cRsFFS8NZJ+alIDj5+KdNF70d4wN3eMURGisM5vM43NAuE8wHAhd0sFuK
         U7Nl+GjO8R+z5o6c+lyh9PP0VYM6aE0+++WymBrsVcMenCZ+JJ8IO4X9vw19lqUfBJo0
         BrJOxy9pv/8PYltM8YIulZUVD/+E9o9BremRE=
MIME-Version: 1.0
Received: by 10.151.93.18 with SMTP id v18mr2949690ybl.178.1275102521487; Fri, 
        28 May 2010 20:08:41 -0700 (PDT)
Received: by 10.150.157.8 with HTTP; Fri, 28 May 2010 20:08:41 -0700 (PDT)
In-Reply-To: <4BFEF327.2020701@gmail.com>
References: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com>
        <1274965420-5091-5-git-send-email-dengcheng.zhu@gmail.com>
        <4BFEF327.2020701@gmail.com>
Date:   Sat, 29 May 2010 11:08:41 +0800
Message-ID: <AANLkTik8wDrdH3vTbvRDsoCUBk9fEI3KmNHRPRBnneXq@mail.gmail.com>
Subject: Re: [PATCH v5 04/12] MIPS: add support for hardware performance 
        events (skeleton)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     David Daney <david.s.daney@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, will.deacon@arm.com
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26905
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

2010/5/28 David Daney <david.s.daney@gmail.com>:
> This depends on not consistent with the #if conditions in [01/12] for pmu.h.
>  They should be I think.
[DC]: It's a subset. If the code passes the test on other CPUs (such as
CPU_SB1), we can add them here.


> Probably removing the tests from pmu.h and encoding them here is better.
[DC]: According to my comments for [1/12], how about keeping them untouched
for now?


> IANAL, but who holds the copyright?  You or MTI ?
[DC]: OK. Will change like this:
Copyright (C) 2010 MIPS Technologies, Inc.
Author: Deng-Cheng Zhu


> This shadows the declaration in asm/time.h.  Declare it in exactly one place
> please.
[DC]: OK.


> Same thing about the copyright.
[DC]: OK.


> Not quite true.  They use the high bit, that can be either 31 or 63
> depending on the width of the counters.
[DC]: OK. Will change to consider 64-bit counters.


> Counters can be 64-bits wide, unsigned int is only 32-bits wide.
[DC]: OK.


Deng-Cheng
