Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 May 2010 05:13:30 +0200 (CEST)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:36590 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491031Ab0E2DN0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 29 May 2010 05:13:26 +0200
Received: by gyb11 with SMTP id 11so1627225gyb.36
        for <multiple recipients>; Fri, 28 May 2010 20:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=ZLqDfxIOvbQDnT0tEXTHGGuddKmcsWd8hQs4tmmU/D4=;
        b=JFx/OKpnQUyIr2kQNzp2kDm4bei4BSIGOOlSurkiS9YAeq/j4PDiidhxztzzp96qEZ
         6dCigKenZhS6WtXyAd07U7OA0b30VvEWRVfxh4ZggaZ3CcAsawRXZJ66a+8VXZ89ZG4O
         f5rW33qHSwCZdt6viCb6XJ4GTyOsd+S7ZcU0U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=c+Naf2pSDbTwTde4I4oyEh3GBSiqcXbR6AOBEULGzW1JLzpFtx3ycuYLvgqF4voHob
         jcfgBW7zeYhJlPK0vIF+ltDD0JdZT8i3pCxM/4+6JZcF5HQd7OFhg1WPL7gYda/QQTy+
         YSu5k56THJG3unE1zut35Pro2bIHuig1awr/o=
MIME-Version: 1.0
Received: by 10.150.210.16 with SMTP id i16mr2789894ybg.70.1275102799679; Fri, 
        28 May 2010 20:13:19 -0700 (PDT)
Received: by 10.150.157.8 with HTTP; Fri, 28 May 2010 20:13:19 -0700 (PDT)
In-Reply-To: <4BFEFBEE.7050108@gmail.com>
References: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com>
        <1274965420-5091-10-git-send-email-dengcheng.zhu@gmail.com>
        <4BFEFBEE.7050108@gmail.com>
Date:   Sat, 29 May 2010 11:13:19 +0800
Message-ID: <AANLkTikfXMJr9yBg31ssM1dn_5tjV_vGoRLoDHGXtfoH@mail.gmail.com>
Subject: Re: [PATCH v5 09/12] MIPS/Perf-events: replace pmu names with numeric 
        IDs
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
X-archive-position: 26909
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

2010/5/28 David Daney <david.s.daney@gmail.com>:
> I don't like this one.
>
> In cpu-probe.c we used to have this same type of parallel name array, and it
> was messy.
>
> You know what type of cpu you are running on, so I don't understand the
> advantage of querying by name.  What possible use could there be to knowing
> the names of processors that are not applicable to the current runtime?
[DC]:
1) It's not "querying by name", but "querying name by enum numbers".
2) Oprofile (now a client of Perf-events) needs to print out the PMU names
to the user. If we don't want this patch, we have 2 methods to do this:
- Export the whole mipspmu, and use mipspmu->name;
- Like the old Oprofile (mipsxx), do a 2nd "switch(current_cpu_type())",
the 1st is in perf_event_mipsxx.c init_hw_perf_events().
3) Exporting a single name array indexed by enum IDs should be convenient
for maintaince. Maybe I'm missing some considerations... But how do we
allow Oprofile to get the string name to the user? Not even need to do it?


Deng-Cheng
