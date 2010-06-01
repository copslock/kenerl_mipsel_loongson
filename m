Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jun 2010 06:04:52 +0200 (CEST)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:55629 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490966Ab0FAEEs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Jun 2010 06:04:48 +0200
Received: by gwj18 with SMTP id 18so3332645gwj.36
        for <linux-mips@linux-mips.org>; Mon, 31 May 2010 21:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=FTPEMqlbshwvxP8nhoSIuosdzkPyqrAq2UpG+K3bx54=;
        b=yGHCXY5RY05itXg74s1aTrayPwGvfuc9+X7wmq0izqcslFZu8WIKCYqmsKQH2uD6Eh
         PyDTXkpD8eNntFrwkBqsqfkvqGRT1Ydp9JRbVa8fgnbHvMo8Rmq7S7pFkMBxqLfXOo/F
         VFJgVebLpVEehDehOY83WgjKtail8FOG9zuxE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=NmVK81IWSgYiFmOXAYE7qyDdzZCk7eZPurKR1enPq7KiypjrzDQrMDCISh5M6Nnvus
         G+ZxW2C41jOtI9FY1zrkgDiNCSy3EWsV2YrchVM97y2U4APk3XolJfGy5ymVDo3o0YKJ
         Kq7a/yAKQcOyMDgE9pQo+C+eWwHtmVdqsvFJQ=
MIME-Version: 1.0
Received: by 10.151.3.25 with SMTP id f25mr6003489ybi.183.1275365082679; Mon, 
        31 May 2010 21:04:42 -0700 (PDT)
Received: by 10.150.158.2 with HTTP; Mon, 31 May 2010 21:04:42 -0700 (PDT)
In-Reply-To: <20100601031528.GC15411@linux-sh.org>
References: <ede63b5a20af951c755736f035d1e787772d7c28@localhost>
        <20100601031528.GC15411@linux-sh.org>
Date:   Mon, 31 May 2010 21:04:42 -0700
Message-ID: <AANLkTinY8Htz2bb2I_oN5iWtAjxuDkGzAvX_4TbtmKBh@mail.gmail.com>
Subject: Re: [PATCH v2] printk: fix delayed messages from CPU hotplug events
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Paul Mundt <lethal@linux-sh.org>
Cc:     mingo@elte.hu, akpm@linux-foundation.org,
        simon.kagstrom@netinsight.net, David.Woodhouse@intel.com,
        rgetz@analog.com, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 26953
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 42

On Mon, May 31, 2010 at 8:15 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> If this is to be entirely restricted to CPU hotplug then you could use
> the hotcpu notifier here instead of the open-coded cpu notifier directly,
> the former wraps to the latter in the CPU hotplug case and is simply a
> nop for the regular SMP case.

I ran some tests and saw the same problem during the regular MIPS SMP
boot.  i.e. adding "while (1) { }" at the end of __cpu_up() prevents
any of the probing/calibration messages originating on CPU1 from ever
being echoed to the console.  Adding the semaphore code before the
while loop caused the CPU1 messages to reappear.

Under normal circumstances you won't ever notice the problem at boot
time, because printing "Brought up %ld CPUs" has the undocumented side
effect of flushing out any messages that got stuck during SMP init.
And if that printk() wasn't there, the next one (from NET, PCI, SCSI,
...) would surely take its place.

But in the case of MIPS CPU hotplug, there is no such printk() at the
end, and so our luck runs out.
