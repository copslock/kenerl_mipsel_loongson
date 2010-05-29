Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 May 2010 05:12:34 +0200 (CEST)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:34989 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491031Ab0E2DMa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 29 May 2010 05:12:30 +0200
Received: by gyb11 with SMTP id 11so1626944gyb.36
        for <multiple recipients>; Fri, 28 May 2010 20:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=a7svlzV1ShvVTzzrpCEM8jkmbEJAXAAMlH0uJa7BOWk=;
        b=GRv4ayMAB4rgcp/vU1i09sTeKV67T0/yO/VscKw7rakHcQfUuzKA/UfzcxRmxthwvl
         NZRqT7+2e5RgyQ/9Od8XVoZc8wGbO++Q0gjPmexJv+W9h608svrFiSYvncrff+jIDhpK
         r/wAU4b8gCHoOEUdNMJeWfkRVjYeLQ7hxA0dQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=bsbPw/gNxxF645Jpa/bjTECOH3NHamkpklmDNgg3bCCaIjbwVzfyV/KHCSF4V+iUlT
         kgL4aVt+SCFUhfmleGSCYxH58oLd9ZpZicEaxBOLQ0VwI/7IgPS27kNj018fGBjyhNQG
         1qL5CwH5z2dI89Zps3M/nZztUpnzPg078xdfo=
MIME-Version: 1.0
Received: by 10.150.142.18 with SMTP id p18mr2269625ybd.126.1275102741971; 
        Fri, 28 May 2010 20:12:21 -0700 (PDT)
Received: by 10.150.157.8 with HTTP; Fri, 28 May 2010 20:12:21 -0700 (PDT)
In-Reply-To: <4BFEF7B5.9090804@gmail.com>
References: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com>
        <1274965420-5091-9-git-send-email-dengcheng.zhu@gmail.com>
        <4BFEF7B5.9090804@gmail.com>
Date:   Sat, 29 May 2010 11:12:21 +0800
Message-ID: <AANLkTilQStnxUNEhbGNa3FZCA4z-YQ93paCP_LeHkSLW@mail.gmail.com>
Subject: Re: [PATCH v5 08/12] MIPS: move mipsxx pmu helper functions to 
        Perf-events
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
X-archive-position: 26908
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

2010/5/28 David Daney <david.s.daney@gmail.com>:
> Is is possible to fold this patch also?  I don't think we need to follow the
> exact evolution of the new files.
[DC]: Patches 1~7 are the primary implementation for MIPS Perf-events. And
patches 8~12 make Oprofile use Perf-events as backend. By doing this, 1~7
can be reviewed/applied/built/tested independently. Maybe you are referring
to Patchwork, so the [00/12] is not visible, here is the link:
http://www.linux-mips.org/archives/linux-mips/2010-05/msg00326.html


Deng-Cheng
