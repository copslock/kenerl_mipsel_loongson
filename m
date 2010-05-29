Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 May 2010 05:14:44 +0200 (CEST)
Received: from mail-yw0-f201.google.com ([209.85.211.201]:61428 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491031Ab0E2DOl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 29 May 2010 05:14:41 +0200
Received: by ywh39 with SMTP id 39so1502024ywh.21
        for <multiple recipients>; Fri, 28 May 2010 20:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=8f/EzrjKQ8mYX3Mr3b0+Kg4LOYgb6t01lQkvuGw20ig=;
        b=lH/BgW1j36oPLZpzagxpELt0zu7zw5WYAVhgvUUejCaiEQqQvZECQumwRulRs8jjE4
         vubqwecKZbc4Zo8fpAkJcF1J2iDnrYzc6kYwLMLo5U61ycB1FfY9+I4HEyU0UWLKIKyT
         zTwdPOYdXDPuH0iXOts1cJpno68EXoJePZm2o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=nvxuXCynkrKJXjN8cP/3xwP0xky8sP7Sr7S1whwTjKoiba2wuPqU2T0LFL13R6cWWU
         FqFGrC6RKqUOwUserlLHqLZK8FnF0YQHMU5LZGNOgiUPKCPvJVipe0pYsH0oevCU7lc4
         iXjuUipX3zjQBA80eY5Jw08KHNrvUB94qU7to=
MIME-Version: 1.0
Received: by 10.151.16.4 with SMTP id t4mr2119460ybi.107.1275102873332; Fri, 
        28 May 2010 20:14:33 -0700 (PDT)
Received: by 10.150.157.8 with HTTP; Fri, 28 May 2010 20:14:33 -0700 (PDT)
In-Reply-To: <4BFEFD4D.4010801@gmail.com>
References: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com>
        <1274965420-5091-11-git-send-email-dengcheng.zhu@gmail.com>
        <4BFEFD4D.4010801@gmail.com>
Date:   Sat, 29 May 2010 11:14:33 +0800
Message-ID: <AANLkTinxpwh5qTr7DXPufDAcCtF7ZIFD07U3A-F3TS8w@mail.gmail.com>
Subject: Re: [PATCH v5 10/12] MIPS/Perf-events: allow modules to get pmu 
        number of counters
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
X-archive-position: 26910
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

2010/5/28 David Daney <david.s.daney@gmail.com>:
> Why is it called 'max_events' when it is returning the number of counters?
>  How about mipspmu_get_max_counters?
[DC]: OK.


> Do we even need this accessor?
>
> Why not just query it from the struct mips_pmu?  Don't you need the mipspmu
> structure anyhow to be able to use the counters?
[DC]: This is for the code outside of Perf-events, such as the module of
the new Oprofile which is a client of Perf-events. If we don't need this,
we have to export the whole mipspmu.


Deng-Cheng
