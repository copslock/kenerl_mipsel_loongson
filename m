Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2007 16:04:34 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.185]:4539 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20026190AbXJDPEO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 Oct 2007 16:04:14 +0100
Received: by nf-out-0910.google.com with SMTP id c10so166530nfd
        for <linux-mips@linux-mips.org>; Thu, 04 Oct 2007 08:04:14 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=WW9vwBbz0Appz4k7pA1LHZb3HMzywlxwBKOrlDXWZ5g=;
        b=PCfBb6ivYiJJuKxrWv7wNJhyUFotTlOYDqWJRA6u09oNp7rm0kGi2+jizpuk+gaVlEDBZjCurh1bQJLOxgl/cJladym8vPLfOKe2XSxigvaDRguB7r/6A9Bd6eg5s34gghrI65P6VfOogL1SLS+Ds6NIXaTLyEN882KdX44+jn0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=FbYiqFLu8uHWf1jaQzIBCxI2NLAvWFZfx7NVVj5m98WUdk/LzxH489lkIOOf+X7kOIP5QxGNAGP8G0HRUGCg8Dl4zoEDnFn3rO7r9AI+Dq1cBTHjdJyYCw+UB3YAnPXBFk923gcdliwMtH6Igqg+7MiNBx3MmX4XYNtpXUhohEA=
Received: by 10.86.77.5 with SMTP id z5mr1554549fga.1191510253519;
        Thu, 04 Oct 2007 08:04:13 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id e9sm3449273muf.2007.10.04.08.04.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Oct 2007 08:04:11 -0700 (PDT)
Message-ID: <4705004C.5000705@gmail.com>
Date:	Thu, 04 Oct 2007 17:01:32 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Thiemo Seufer <ths@networkno.de>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
References: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl> <20071002141125.GC16772@networkno.de> <20071002154918.GA11312@linux-mips.org> <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de> <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de> <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org>
In-Reply-To: <20071004121557.GA28928@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16846
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Thu, Oct 04, 2007 at 09:33:08AM +0200, Franck Bui-Huu wrote:
> 
>> Not really, I would say it's just an idea to remove tlbex.c from the
>> kernel code and to make it a tool called during compile time to
>> generate a handler skeleton which would be finalized by the kernel.
> 
> IRIX was assembling its TLB exception handler from a few such skeletons
> or rather a few fractions.  That works reasonably well as long as there are
> not too many variants - but Linux supports about anything on earth.
> Another disadvantage of the IRIX approach was that the fragments are
> written in assembler but the tacking together happens in C code so the
> code is split in a somewhat unnatural way over a few files.
> 

That's what I was thinking too. It may require a lot of (ugly ?)
tricks to link the whole thing together. And if the idea was
previously used and showed it was inferior than what we have now, it's
just a bad idea.

It's just a bit sad to see my TLB handler generated at each boot and
to embed the whole tlbex generator inside the kernel which is quite
big:

   $ mipsel-linux-size arch/mips/mm/tlbex.o
      text    data     bss     dec     hex filename
     10116    3904    1568   15588    3ce4 arch/mips/mm/tlbex.o

specially if my cpu doesn't have any bugs.

Maybe having, 2 default implementations in tlbex-r3k.S, tlbex-r4k.S
for good cpus (the ones which needn't any fixups at all) and otherwise
the tlbex.c is used. And with luck the majority of the cpus are
good...

OK, probably a bad idea (again) ...

Thanks
		Franck
