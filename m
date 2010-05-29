Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 May 2010 05:15:59 +0200 (CEST)
Received: from mail-yw0-f201.google.com ([209.85.211.201]:37770 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491031Ab0E2DP4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 29 May 2010 05:15:56 +0200
Received: by ywh39 with SMTP id 39so1502441ywh.21
        for <multiple recipients>; Fri, 28 May 2010 20:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=x/AgJHtQ6Ahy8pNsIRGizE1ZU2jwx5EfoxRqv0PCOJk=;
        b=dtHP3FusGUHb81FhzxMjkhpID5SAQuyAw8buVvhDAOIy++xh1QIfDL0vClUnO3EfcS
         xWxGhVr8UI17TJKhJQK23RcGqO5GykSIcnntY/r+EXPLp7eEt+Lqu0em1iajgeY/hILa
         CIGeo1vtqWfY4B1RbCNZgNEr8rlBdXQvWbFQk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=YH4ipC8y2oIuIZJBcCDeK5BgicYcZarWuTg0a2l0t6VR3ObiH6SeaiXs+YEeunNLm0
         C53TfrMttc7FWK3gjsV6hK79Skti6iAE8rlUTplrNvbm0S5nozQEBY1DlvVdQReeOyvv
         +Nj89GJHbEKwmmdxw5n327jw2RN8Y00ot3l00=
MIME-Version: 1.0
Received: by 10.150.180.16 with SMTP id c16mr2130606ybf.59.1275102948403; Fri, 
        28 May 2010 20:15:48 -0700 (PDT)
Received: by 10.150.157.8 with HTTP; Fri, 28 May 2010 20:15:48 -0700 (PDT)
In-Reply-To: <4BFEFF3B.3080009@gmail.com>
References: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com>
        <1274965420-5091-12-git-send-email-dengcheng.zhu@gmail.com>
        <4BFEFF3B.3080009@gmail.com>
Date:   Sat, 29 May 2010 11:15:48 +0800
Message-ID: <AANLkTimDlXVsamu79obj_j2tN7NCpluY4D6dBUL5vkGU@mail.gmail.com>
Subject: Re: [PATCH v5 11/12] MIPS/Oprofile: use Perf-events framework as 
        backend
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
X-archive-position: 26911
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

2010/5/28 David Daney <david.s.daney@gmail.com>:
> The mips perf events system should already know what type of cpu it is
> running on.
>
> Can we have all this processor specific perf/counter stuff live in one place
> and simplify all of this?
[DC]: Do you mean to move init_hw_perf_events() out into perf_event.c, and
to deal with mipsxx/loongson2/rm9000/more together? If yes, that's OK.


> Too many magic numbers.  Lets have symbolic names.
[DC]: OK.


Deng-Cheng
