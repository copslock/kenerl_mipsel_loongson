Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Apr 2011 17:47:53 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:46206 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493077Ab1DRPru (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Apr 2011 17:47:50 +0200
Received: by wyb28 with SMTP id 28so5106883wyb.36
        for <linux-mips@linux-mips.org>; Mon, 18 Apr 2011 08:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=QyRLLGxY/FSqlugykx1mskrRCd/l1ol9tQh7da5H5YE=;
        b=pCLQgWzbmtztCzewVqln7YHeEaCw+2ruwJNqokK8dRKFKeGYvFCKxLtkqRPRL8aADy
         LKQFBU1m/XQw7IgfY8rwrzHg5JWGXxo2utpsQARanCGR2PFw3fLpP7KKjJAXgzbZCYwG
         l99Z7A3uLloWXNN86yGJt4Jf0H7F6RzrdppHs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=gUitwkGeJnUkl6BxfaYy6sIvOclI68qqY7KhgntB62ECokJ/vlcGk01++JmAoN7ZT7
         6uyuO7hOj9rfLRzr6NxJEts+w65U7bpSyxFg+OcOYfnHhzpO5nRQNXfwKVIOA+IV6Nui
         RuXK+YCL4bISRiqygMSW+Lx31XBjSXZBfrSTo=
MIME-Version: 1.0
Received: by 10.216.82.68 with SMTP id n46mr5061771wee.57.1303141663946; Mon,
 18 Apr 2011 08:47:43 -0700 (PDT)
Received: by 10.216.237.218 with HTTP; Mon, 18 Apr 2011 08:47:43 -0700 (PDT)
In-Reply-To: <AEA634773855ED4CAD999FBB1A66D07601988DFA@CORPEXCH1.na.ads.idt.com>
References: <AEA634773855ED4CAD999FBB1A66D07601988DFA@CORPEXCH1.na.ads.idt.com>
Date:   Mon, 18 Apr 2011 17:47:43 +0200
Message-ID: <BANLkTi=QLZe68o2=1Vk+4QTu-ru1T6H=vQ@mail.gmail.com>
Subject: Re: How can I access h/w registers in user space?
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29775
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Mon, Apr 18, 2011 at 5:41 PM, Ardelean, Andrei
<Andrei.Ardelean@idt.com> wrote:
> 1. My video processor has many h/w registers mapped in MIPS CPU physical
> memory space. Do I have in Linux MIPS something like iopl() to allow me
> to access h/w registers in user space? Is it anything similar available?

I believe iopl() is a x86-specific hack.


> 2. I studied mmap() solution but what I found unpleased is that I need
> to malloc() space in user space equal to the IO memory space I want to
> access which it is quite lot and it takes from system DDR RAM available
> I have here. What I need is just to access a physical space which I know
> that is mapped on internal registers.

I usually open /dev/mem then simply mmap() the base of the physical area
I'm interested in.

Hope that helps!
      Manuel Lauss
