Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Sep 2009 20:27:41 +0200 (CEST)
Received: from mail-yx0-f185.google.com ([209.85.210.185]:49260 "EHLO
	mail-yx0-f185.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493535AbZIWS1e (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 23 Sep 2009 20:27:34 +0200
Received: by yxe15 with SMTP id 15so1203166yxe.22
        for <linux-mips@linux-mips.org>; Wed, 23 Sep 2009 11:27:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=VWSkP4KCQxMT/NjDYaAjz9uPHgC7XesJCJjIV0jGt5A=;
        b=tp1cG7ZhEE8zMOnC7OavkXfGlNa/YqGQgajLlM2JM62kOYkfoLcpLJsHZAo8ak+dqi
         mqK8aYSnuaEPevqP+6PWibu+jpg1HHxbK+XRX1f57CVIVwWpiutAksZHtIzN0+XJgHkC
         xIdYr519LlL5cjn1crDRXR5zZQUQqbFCGX6a8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=OJ5Jc7/SFKAd6uzvTV64BizVEpYeAIzTiW8TNMo1eOVdijZluHBmYA3wc2s+sWk6G5
         LamUoKhMm++RWgBehffqSpcMmS8wLdgF9jCmQI60yPexNWkU4Kx8lygL4mEaWxn67x5y
         ZU4/3BQvcgC6KZDqudcVsQQwNo9gIXqvazsP8=
MIME-Version: 1.0
Received: by 10.90.22.29 with SMTP id 29mr1495910agv.25.1253730446199; Wed, 23 
	Sep 2009 11:27:26 -0700 (PDT)
Date:	Wed, 23 Sep 2009 14:27:26 -0400
Message-ID: <21f828e90909231127h70f69047v91b9261226681d53@mail.gmail.com>
Subject: MIPS: [raw_]smp_processor_id uses current_thread_info
From:	Randy MacLeod <rwmacleod@gmail.com>
To:	linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <rwmacleod@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24079
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rwmacleod@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

I'd like advice on changing the implementation of smp_processor_id on
Cavium specifically and/or MIPS generally.

Currently we have: arch/mips/include/asm/smp.h
#define raw_smp_processor_id() (current_thread_info()->cpu)

A co-worker has an issue where the current thread pointer is corrupted
on a Cavium MIPS system running 2.6.14 (but the same code exists in 2.6.31).
During the resulting panic() the kernel calls smp_processor_id()
which dereferences the corrupt task pointer again - ouch. I've notice that
other arches have raw_smp_processor_id() defined to
 - a platform specific register read, or
 - a percpu variable or
 - have a hard_smp_processor_id() defined
This last one is presumably for times when you don't trust the kernel
data structures to be
sane.

I can create a patch that calls cvmx_get_core_num(); for cavium.
Is there a more generic way to get the cpu number on MIPS?

Thanks,
-- 
../Randy/..
