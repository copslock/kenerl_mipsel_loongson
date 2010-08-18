Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Aug 2010 14:37:22 +0200 (CEST)
Received: from mail-qy0-f170.google.com ([209.85.216.170]:53830 "EHLO
        mail-qy0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491159Ab0HRMhT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Aug 2010 14:37:19 +0200
Received: by qyk35 with SMTP id 35so1904997qyk.15
        for <linux-mips@linux-mips.org>; Wed, 18 Aug 2010 05:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=su5K4IYYNSgQup/IYoXE1E7BxIsXA8ZOB1EcahW6diE=;
        b=hy9aizNtKub/RAgECEud8f3aM7/sF8Q5toxXG1iLCi4A/bzE+3y7zyUopM3HP0iayM
         7A0EkE1gNbVmTMdyPvN+21DHcEZuev+S80xk9sHP6dCBm95RcdOmrG1xIQQZKt/xGeHK
         UEItMTpwPlzph/YjBnjySmiPnhAL2t+1xV0vY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=EtBfCYalAa6eiuHsVmx82co1k+qhXm52wfnV4N9ZC9xBUbyXfTSuwntBVbDisMKs5W
         iyw4ixu76fcxWjySJC1O+HBqvvmPMSlLtYuewhafPXvvErvf+1g44746G5Hca6eD7U6t
         4IKDFGRhMjjnBxnXPlujeSCW+7yuS5f6kDkhY=
MIME-Version: 1.0
Received: by 10.224.54.134 with SMTP id q6mr5346829qag.274.1282135032798; Wed,
 18 Aug 2010 05:37:12 -0700 (PDT)
Received: by 10.229.20.129 with HTTP; Wed, 18 Aug 2010 05:37:12 -0700 (PDT)
Date:   Wed, 18 Aug 2010 18:07:12 +0530
Message-ID: <AANLkTiniH42L=-DdJ_XHOm1Uo_=YoAqE-j9Jrm45imtG@mail.gmail.com>
Subject: kmalloc issue on MIPS target
From:   naveen yadav <yad.naveen@gmail.com>
To:     majordomo@kvack.org, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <yad.naveen@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27628
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yad.naveen@gmail.com
Precedence: bulk
X-list: linux-mips

Hi All,

We are using MIPS(mips32r2) target. when I alloc memory using kmalloc
suppose  28 bytes, the kernel still consume 128 bytes.

So when I check File on kernel source  mach-ip32/kmalloc.h

Since it is allign to 128 bytes so i understand that even if  I
consume 1 byte it will waste 128 bytes.

#ifndef __ASM_MACH_IP32_KMALLOC_H
#define __ASM_MACH_IP32_KMALLOC_H


#if defined(CONFIG_CPU_R5000) || defined(CONFIG_CPU_RM7000)
#define ARCH_KMALLOC_MINALIGN   32
#else
#define ARCH_KMALLOC_MINALIGN   128
#endif

#endif /* __ASM_MACH_IP32_KMALLOC_H */


So I could not understand why it is allign to 128 bytes. Is there any
specific reason for it. ?

thanks
