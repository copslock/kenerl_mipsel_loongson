Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Apr 2010 18:39:11 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:50034 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492419Ab0DOQit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Apr 2010 18:38:49 +0200
Received: by pwj4 with SMTP id 4so1289591pwj.36
        for <multiple recipients>; Thu, 15 Apr 2010 09:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=kcPhAHKifHLEL21oLKW+xVV1+jJD9XfNr9XBV8GrIb0=;
        b=k603VkG9MLZjTzKBzF5d7L7IrOSq2E4CCUy8ub7ZTeoVv4AFgsogeJdZII636oE3UM
         o8T28pzUftHSHjHT9tAoxtWDKxmnasGjjmGbMQUUZ0zmFFbE669uOtZvrC4sVjDGkfn7
         Yg3+rKIt/b8At8ptmeSZTv9yvgEuouKLl1Ivs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        b=meqL2bArF7Ot4NPBQr/2LbjlZQEpNPbJTKbuzEA0fSyETk/4TSx0KP0SUJ9y5wuRMO
         09lcrO6nUfaWjkjp8vexdn5IP1MB6mvumpQkPl6/oKa/o3HR47UrK7MXgwGwdgMQBOM8
         qd/YvnaYr8x7umnrB2SVDS9Sl4nXXnbautkVI=
Received: by 10.142.1.35 with SMTP id 35mr296375wfa.26.1271349520527;
        Thu, 15 Apr 2010 09:38:40 -0700 (PDT)
Received: from [192.168.1.101] ([114.84.94.52])
        by mx.google.com with ESMTPS id 21sm456994yxe.39.2010.04.15.09.38.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Apr 2010 09:38:40 -0700 (PDT)
Subject: [PATCH 0/3] MIPS performance event support initial version
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 16 Apr 2010 00:38:31 +0800
Message-ID: <1271349511.7467.419.camel@fun-lab>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26414
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

This patch series implemented the low-level logic for the Linux
performance counter subsystem on MIPS, which enables the collection of
all sorts of HW/SW performance events based on per-CPU or per-task.

An overview of this implementation is as follows:

- Using generic atomic64 operations from lib.
- SMVP/UP kernels are supported (not for SMTC).
- 24K/34K/74K cores are implemented.
- Currently working when Oprofile is _not_ available.
- Minimal software perf events are supported.

Tests were carried on the Malta-R board. The mentioned cores and kernel
flavors were tested. For more information, please refer to the particular
patches.

Deng-Cheng Zhu (3):
- MIPS: use the generic atomic64 operations for perf counter support
- MIPS: adding support for software perf events
- MIPS: implement hardware perf event support
