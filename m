Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Apr 2010 07:04:38 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:56067 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490977Ab0DQFEf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Apr 2010 07:04:35 +0200
Received: by pvc30 with SMTP id 30so2241701pvc.36
        for <multiple recipients>; Fri, 16 Apr 2010 22:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=6E/y1khOdL382TV8UDb67NDew8WYJGgp2hHBeZak2rQ=;
        b=QAIEgqaFacMkr6l98WkN3OJluAweBx+pNz1KIVLvmjXnE5G9AoZ7KbrKsyNkpuKw08
         4YPK6jpFATsYiF0FOo627EE8r4loMdMvqddbFpcYhyt0nZxGNORTHZ4m5O9tMm20/65c
         dUNBRnljmNv9ulaXObmbqW9yY6H33Nfm5LPY4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=DoVkXSXXJ61KEq/KHfoDtNESxj0ShptoEdHs48wHwAbxBB5uMcc7F/cEu6mhcQaSJi
         YGerOPpHjXox70/1+47DvcgYgi56asVNRkUdZnHnnTh4ZZo1mT1fQhw3yFk9BviSYQVN
         za3lGYXkQSmQlxK51lkJ2YTYUPMYw08Pj5iOg=
Received: by 10.114.188.4 with SMTP id l4mr2510638waf.19.1271480667723;
        Fri, 16 Apr 2010 22:04:27 -0700 (PDT)
Received: from [192.168.2.243] ([202.201.14.140])
        by mx.google.com with ESMTPS id 23sm2877812pzk.10.2010.04.16.22.04.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 16 Apr 2010 22:04:26 -0700 (PDT)
Subject: Re: [PATCH 3/3] MIPS: implement hardware perf event support
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     "dengcheng.zhu" <dengcheng.zhu@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com
In-Reply-To: <u2p1b4d75291004161849z3e9ff5afw8dc64226e82fb1ac@mail.gmail.com>
References: <1271349557.7467.424.camel@fun-lab>
         <1271353636.20625.99.camel@falcon>
         <u2p1b4d75291004161849z3e9ff5afw8dc64226e82fb1ac@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Sat, 17 Apr 2010 13:04:21 +0800
Message-ID: <1271480661.1860.36.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26424
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Sat, 2010-04-17 at 09:49 +0800, dengcheng.zhu wrote:
[...]
> >
> > I think it will not work on rm9000 and loongson2 for their performance
> > counters are different from mipsxx. so suggest you only enable this for
> > mipsxxx(refer to arch/mips/oprofile/Makefile) via #ifdef and renaming
> > the current perf_event.c to perf_event_mipsxx.c.
> OK, I'll try to move the control/count help functions/defines and the
> specific mips_pmu stuff into a file called perf_event_mipsxx.c, and leave
> the common things in perf_event.c, so that when we implement Perf for
> loongson2 or rm9000, we can simply add new files like
> perf_event_loongson2.c.
> 
> > And to reduce the source code duplication, perhaps we need a solution to
> > share the source code between Oprofile and Perf, and also among mipsxx,
> > rm9000 and loongson2.
> I think there is almost nothing for the count/control things which can be
> shared among mipsxx/rm9000/loongson2. As for sharing between Oprofile and
> Perf, how about moving mipsxx/rm9000/loongson2 count/control things into a
> new file asm/pmu.h, where we use #ifdef's.
> 

It looks good, based on your work, I will try to add the loongson2
specific perf support, then we can get more details about the common
parts.

Regards,
	Wu Zhangjin
