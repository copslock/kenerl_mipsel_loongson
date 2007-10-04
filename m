Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2007 08:36:12 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.189]:40225 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20022516AbXJDHgC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 Oct 2007 08:36:02 +0100
Received: by nf-out-0910.google.com with SMTP id c10so65044nfd
        for <linux-mips@linux-mips.org>; Thu, 04 Oct 2007 00:35:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=NY7yn15/xxRye/FirViXaW2c9AwQLnIItbl67y6I6Rs=;
        b=UEnN2XR9tL58J/vFL++ts4S4YnJ/jdyt/O6To4gxbrbrbY5icYW1ehuAOS0t88AcktvfMEkg99gXlE0VjIP3xOeD61QxqgkggsZXM/heuYmjcSk6l0xoYh9Bl3ETrnA8JhIvQikAvG+mzYFFLhdY0xo6xXIPWzUN7nPw7gzL+Bo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=pPWtXsEpJVD2ln8eQhlq7tqPzhq4dWVEzqvIDyitrQYiDrCpFMKW01sEP6FkWhyD9tdBKKz2+jy2Cud+rSmMYdXw4F9ZkrfmpoPqcjAD5Pys6MhEwDRCHl1vw6uXyP6GuzzXniTpaBz2DtrnAX0ibYA48dJZIi1vWLehwjFozNw=
Received: by 10.86.86.12 with SMTP id j12mr1210794fgb.1191483344821;
        Thu, 04 Oct 2007 00:35:44 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id j9sm2570407mue.2007.10.04.00.35.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Oct 2007 00:35:43 -0700 (PDT)
Message-ID: <47049734.6050802@gmail.com>
Date:	Thu, 04 Oct 2007 09:33:08 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Thiemo Seufer <ths@networkno.de>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
References: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl> <20071002141125.GC16772@networkno.de> <20071002154918.GA11312@linux-mips.org> <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de> <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de>
In-Reply-To: <20071003201800.GP16772@networkno.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16833
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:
> Franck Bui-Huu wrote:
>> Thiemo Seufer wrote:
>>> Then you have the worst of both approaches: The nicely readable
>>> disassembly will change under you feet, and you still need
>>> relocation annotations etc. for CPU-specific fixups. The end-result
>>> is likely more complicated and opaque than what we have now.
>> Let say we generate handlers with all possible cpu fixups. Very few
>> instructions would be removed so the disassembly should be quite
>> similar after patching.
> 
> No way. Just check the possible variations: 64bit, highmem, SMP,
> and so on.
> 

You just listed some variations that are known at compile time. What I
meant by "all possible cpu fixups" is all fixups for a specific cpu
which can be known only at runtime.

>> And by emitting some nice comments in the
>> generated code, it should be fairly obvious to get an idea of the
>> final code.
>>
>> All fixups would be listed in a table with some flags to identify them
>> and a list of instructions which need to be relocated.
> 
> At that point you have invented something which effectively emits
> the sourcecode for tlbex.c.
> 

Not really, I would say it's just an idea to remove tlbex.c from the
kernel code and to make it a tool called during compile time to
generate a handler skeleton which would be finalized by the kernel.

Thanks,
		Franck
