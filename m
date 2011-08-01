Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Aug 2011 15:22:58 +0200 (CEST)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:38997 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491134Ab1HANWy convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Aug 2011 15:22:54 +0200
Received: by gwb1 with SMTP id 1so4061945gwb.36
        for <linux-mips@linux-mips.org>; Mon, 01 Aug 2011 06:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=bVWPyWDEQc0+YXs3W2kQC1ZDQ7KXRt86TaRkxirgMQ0=;
        b=A7Py5PWwP0ClOeHrO94GxZvcHsiTGbhRMwOdcfZEwMc+ds0ZN9ufDXX01Ne7lkIJXY
         Y2pbFIVUR5OB5pIhOOHJ4dBgNUBUxySgoaitsEtMcnEE4B4nfc32L3lYKu/XW4vvm2Wz
         /9qnEcJMaadeMVutfR1P12G+BkLybevyStMd0=
MIME-Version: 1.0
Received: by 10.236.184.197 with SMTP id s45mr3242852yhm.157.1312204968535;
 Mon, 01 Aug 2011 06:22:48 -0700 (PDT)
Received: by 10.236.103.172 with HTTP; Mon, 1 Aug 2011 06:22:48 -0700 (PDT)
In-Reply-To: <20110801131137.GA10508@albatros>
References: <CAOLZvyEQNS3dwQ+6bh2o6kADp7Gd3xOpah8y1_AhqJ2FWSP9VA@mail.gmail.com>
        <20110801131137.GA10508@albatros>
Date:   Mon, 1 Aug 2011 15:22:48 +0200
Message-ID: <CAOLZvyHaXcQ0RK8SNX+tTtQ=fJsLq9LxpyszCF82sK985XWQJg@mail.gmail.com>
Subject: Re: shm broken on MIPS in current -git
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Vasiliy Kulikov <segoon@openwall.com>
Cc:     linux-kernel@vger.kernel.org,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 30783
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 414

On Mon, Aug 1, 2011 at 3:11 PM, Vasiliy Kulikov <segoon@openwall.com> wrote:
> On Mon, Aug 01, 2011 at 14:51 +0200, Manuel Lauss wrote:
>> Commits 5774ed014f02120db9a6945a1ecebeb97c2acccb
>> (shm: handle separate PID namespaces case)
>> and 4c677e2eefdba9c5bfc4474e2e91b26ae8458a1d
>> (shm: optimize locking and ipc_namespace getting)
>> break on my MIPS systems.
>
> Can you please identify what commit breaks the system?

Reverting this one fixes the oops for good:

5774ed014f02120db9a6945a1ecebeb97c2acccb
 (shm: handle separate PID namespaces case)


>>  The following oops is
>> printed on boot, and as a result, more than  300 zombie kworker
>> kernel processes are resident.  I don't see this oops on x86 or x64.
>
> Do you have the same configs for x86 and mips?

MIPS is UP, SLAB without preempt, x86 is UP/SMP, SLUB with preempt.
It's not SLAB/SLUB and not preempt, and both MIPS+x86 have all
namespace options enabled.

both configs are temporarily available here:
http://mlau.at/config-mips
http://mlau.at/config-x64

Thanks!
     Manuel Lauss
