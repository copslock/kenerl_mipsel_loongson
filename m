Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 May 2010 05:18:36 +0200 (CEST)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:60108 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491031Ab0E2DSX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 29 May 2010 05:18:23 +0200
Received: by gwj18 with SMTP id 18so1616497gwj.36
        for <multiple recipients>; Fri, 28 May 2010 20:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=UI0HcMkZ3wLLq4CG8bZ+0wv0jz9/QNefdTP3DuN2KIk=;
        b=k8LRNl8L9nEYWzKY0xOoAzt+rC+tSqzo4mZDURLI1jAcwO8BlrUhBSEltLoXxmILYJ
         2WpUgOxya98w0rbEvGioJXkSRLN63PK8l5GvxHXotabs/ttCXsOpt3a2x4c84D1h2Vym
         sTC+mTsAfMVqEDSIV9mcLdLvb62og5YRtBnLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=wgkxxJIob1+mqlRr0NQRB0XXf7RsqWS6j3pYfkN4yH3uzonwnwecp07ttLMmoVyd4S
         roJgL0Z+KtSoP5q9JRreDxzmHdEXCZdzaEgKJXwuZ+evCVPy3rpFftarWoSvfQlckTgr
         U93rHDKwd1fSxr4oklW5CxrIQtEmUjTvTcD9w=
MIME-Version: 1.0
Received: by 10.151.16.4 with SMTP id t4mr2121589ybi.107.1275103096135; Fri, 
        28 May 2010 20:18:16 -0700 (PDT)
Received: by 10.150.157.8 with HTTP; Fri, 28 May 2010 20:18:16 -0700 (PDT)
In-Reply-To: <4BFEFFA6.8040904@gmail.com>
References: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com>
        <1274965420-5091-13-git-send-email-dengcheng.zhu@gmail.com>
        <4BFEFFA6.8040904@gmail.com>
Date:   Sat, 29 May 2010 11:18:16 +0800
Message-ID: <AANLkTinJBOlZ4jsifXz-VJxFt7B5fMCuGTvJq9lEqWTM@mail.gmail.com>
Subject: Re: [PATCH v5 12/12] MIPS/Oprofile: remove old files and update 
        Kconfig/Makefile
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
X-archive-position: 26912
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

2010/5/28 David Daney <david.s.daney@gmail.com>:
> This patch could be folded into the previous one.
>
> If the previous patch really makes these unused, it shouldn't leave them
> hanging around.
[DC]: OK.


Thanks again for your time!

Deng-Cheng
