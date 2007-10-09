Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Oct 2007 21:18:42 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.184]:12694 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20022028AbXJIUSe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 9 Oct 2007 21:18:34 +0100
Received: by nf-out-0910.google.com with SMTP id c10so1323285nfd
        for <linux-mips@linux-mips.org>; Tue, 09 Oct 2007 13:18:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=rIwpyXM1p+lsUdds5T3eihybHiUr7fN5fzLPfuEWi3c=;
        b=Pq/gD/oddRuHqT9MLDg9d7UpSxsaY0eyMKHgzaKMuAzl66XdHq+JKrEhejNKK03nkVDVnKKUgfC5OosLkgnbnxkBaF/Na+a3sPht9gSCFzbOHmwmD+dfev60gntbNeTOn14ZOCzFDDacOsPq6tHBn8Xcrx4bxVkbUR+daum3y64=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=l54EMSsYdEDJZJxqaXcPjzt47Fto/Czqsc55au8x7/x+tVvtnjQjjr9tKtLZhrwV4reZDGB22OuTBxKb6J5Ygt2vZLM78YbszkriSj4uWzpfZSoX96nqEtVoDuLCbitmrxTEle4AXbgrhGWLqqWwsQWxWHqRDSs69BHHku2/D+4=
Received: by 10.86.28.5 with SMTP id b5mr6277600fgb.1191961096131;
        Tue, 09 Oct 2007 13:18:16 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id m1sm14342779fke.2007.10.09.13.18.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Oct 2007 13:18:14 -0700 (PDT)
Message-ID: <470BE1F4.3070800@gmail.com>
Date:	Tue, 09 Oct 2007 22:17:56 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
References: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl> <20071002141125.GC16772@networkno.de> <20071002154918.GA11312@linux-mips.org> <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de> <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de> <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org> <4705004C.5000705@gmail.com> <Pine.LNX.4.64N.0710041616570.10573@blysk.ds.pg.gda.pl> <4705EFE5.7090704@gmail.com> <Pine.LNX.4.64N.0710051312490.17849@blysk.ds.pg.gda.pl> <470A4349.9090301@gmail.com> <Pine.LNX.4.64N.0710081611460.8873@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0710081611460.8873@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16909
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
>  What would be the gain for the kernel from using "-march=4ksd" rather 
> than "-march=mips32r2"?
> 

It actually results in a kernel image ~30kbytes smaller for the former
case. It has been discussed sometimes ago on this list. I'm sorry but
I don't know why...

> 
>  What if you want to run a single kernel image regardless of the CPU 
> installed in the system.  Rebuilding the kernel (or having to keep a large 
> collection of binaries) just because you want to swap the CPU does not 
> seem like a terribly attractive idea.  Some systems come with their CPU(s) 
> on a daughtercard (each), you know...
> 

ok, I wasn't aware about this. You could have started by this point ;)

So now I think the right direction is to stick with tlbex.c and
make it smaller like Ralf did.

Thanks,
		Franck
