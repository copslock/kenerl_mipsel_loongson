Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jan 2011 04:01:54 +0100 (CET)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:49816 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490952Ab1ARDBv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Jan 2011 04:01:51 +0100
Received: by wyf22 with SMTP id 22so5593711wyf.36
        for <linux-mips@linux-mips.org>; Mon, 17 Jan 2011 19:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=l6kq2ZMzGjEtEEnXdoTsUT9VbtiBPDOyN1zfBpyZ6YA=;
        b=x6GVhzFqfSrMS5+YoocpSBseIRTSVWuYWy7+ZupGcR5ownP+crNvTzGl1EvCXvk//o
         09Zo6QJKAW/k+V3QQDfCDcpkRxlaciZBxofFavyz/0b8KsB4CnAd0kMGiw7sZSZCUH6e
         KgcZrBmiOxc9RL50sB22HzcpSsOAbY2Oel/Ao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Iv+52pufZRDJ56ooiQ2XDkNtwGh2++cEpdMw/CObz9kfqm+M0+T/FnaDyOrsBBVNBY
         pA6zru8s8jwz29od1wF2AVeK2S36icbb2uPMIWsU4jJoEAIgIWNQsr76zSiqviFDxzYV
         Fn8Ka6BUXM2qkSeM1aw7CeO1RIM7KGGpzLMIo=
MIME-Version: 1.0
Received: by 10.216.78.212 with SMTP id g62mr550487wee.78.1295319705557; Mon,
 17 Jan 2011 19:01:45 -0800 (PST)
Received: by 10.216.89.134 with HTTP; Mon, 17 Jan 2011 19:01:45 -0800 (PST)
Date:   Tue, 18 Jan 2011 11:01:45 +0800
Message-ID: <AANLkTin+TzF2QtbfRi8Ltqwp97ME-JtuwwEBn8cYt1zS@mail.gmail.com>
Subject: about oprofile callgraph on linux-mips
From:   "Amker.Cheng" <amker.cheng@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <amker.cheng@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28965
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: amker.cheng@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,
    Previously I have run oprofile on linux-mips and have two
questions about it.
    It seems that oprofile does not support callgraph on linux-mips
currently, since there is no
backtrace function in oprofile kernel module for mips target.
    Is it possible or easy to support callgraph on mips target? If I
am right, it's some kind of
difficult to calculate stack frames of interrupted user space
programs, at least for O32 ABI.

Any tips would be appriciated. thanks.


-- 
Best Regards.
