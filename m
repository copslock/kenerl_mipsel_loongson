Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Oct 2007 09:04:21 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.186]:38611 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20023400AbXJEIEN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 5 Oct 2007 09:04:13 +0100
Received: by nf-out-0910.google.com with SMTP id c10so368840nfd
        for <linux-mips@linux-mips.org>; Fri, 05 Oct 2007 01:03:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=qf2OZ+ojxHJa5g4iqPXY3ldH/5iWER/ReDlCpN5YiW4=;
        b=Gkjir32f8jtH9Iz0OrxV739i4uwZcbRdDDEB7JdqOg011S9zgUxlkukUOx3v/Rc1XyJuPJLXBY1mQNs4xtnikL2JcPzUDgZalEXX8i6wsuojH61cU5CR91DZOua4LoxjG5oED0oMBbYCqDngvkV1volo1RsE7XvHdu5UDW/FDlA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=W5t4TbPFd70ncXMApXZ3ITxj0jk+fn9rD5VarW5dIcVZ+7BZ4s0HYOW3Wknlw888Vz6EegxMxKBKfTLP6LB+PKa4uQ+XsjqmenR2kDZO+tWjHkEdK83VAxqBAiCLy8kNkDCV9OzWb9Dm/A516Pr29KzJTTysKl3T6ziE4Kf+yDI=
Received: by 10.86.62.3 with SMTP id k3mr2245479fga.1191571435220;
        Fri, 05 Oct 2007 01:03:55 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id f31sm4979063fkf.2007.10.05.01.03.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Oct 2007 01:03:54 -0700 (PDT)
Message-ID: <4705EFE5.7090704@gmail.com>
Date:	Fri, 05 Oct 2007 10:03:49 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
References: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl> <20071002141125.GC16772@networkno.de> <20071002154918.GA11312@linux-mips.org> <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de> <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de> <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org> <4705004C.5000705@gmail.com> <Pine.LNX.4.64N.0710041616570.10573@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0710041616570.10573@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16863
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Thu, 4 Oct 2007, Franck Bui-Huu wrote:
> 
>> It's just a bit sad to see my TLB handler generated at each boot and
>> to embed the whole tlbex generator inside the kernel which is quite
>> big:
>>
>>    $ mipsel-linux-size arch/mips/mm/tlbex.o
>>       text    data     bss     dec     hex filename
>>      10116    3904    1568   15588    3ce4 arch/mips/mm/tlbex.o
>>
>> specially if my cpu doesn't have any bugs.
> 
>  Well, most systems are there to work and not to be rebooted repeatedly 
> all the time. ;-)  All of tlbex.o is discarded after bootstrap.
> 

Yes, but some systems out there have some constraints on their boot time
and others have ones on their persistent storage device size.

>> Maybe having, 2 default implementations in tlbex-r3k.S, tlbex-r4k.S
>> for good cpus (the ones which needn't any fixups at all) and otherwise
>> the tlbex.c is used. And with luck the majority of the cpus are
>> good...
> 
>  Well, most of the differences are not due to CPU bugs, but different cp0 
> hazards.  The MIPS32r2 and MIPS64r2 architecture specs introduce the "ehb" 
> and "jr.hb" instructions to sort them out, but most of the processors we 
> support predate them.
> 
>  The existence of the definitions in <asm/war.h> is there so that 
> workarounds for CPU bugs are optimised away at the kernel build time if 
> not activated.
> 

Just to be sure I haven't missed anything, it seems that we _could_ generate
the whole tlb handler at compile time since the CPU type is known at that
time, no need to have any fixups at runtime, isn't it ?

		Franck
 
