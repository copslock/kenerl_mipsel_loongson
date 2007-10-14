Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Oct 2007 20:33:56 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.186]:7116 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20035422AbXJNTds (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 14 Oct 2007 20:33:48 +0100
Received: by nf-out-0910.google.com with SMTP id c10so1094106nfd
        for <linux-mips@linux-mips.org>; Sun, 14 Oct 2007 12:33:30 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=p9NhzuDoyLH5o//qt7Whgd5IsZ3CX41f/F8RBN+O5UM=;
        b=eKo8qu1XUzD11Xjj3h5QtHu7jHDGhcWdNYs7DzrQwGERWIcpifW9z4XTn5EHr8B4Kc6MaakATUAHJi7bFKF8diBbny3S++mkd5eeVT7Tg/9HKhbTg8iDc9ZWHuWdtemnrQ2w6MWxqNiH7xmXXqOL6vbtu2Nd9nP3o0B6EXLxkzs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Xrhm1aSBIse3skb7Oe1e3wMB4dH5f4NT4Gscc2Ywc5iiw0OK5twn59X+65QsYxU/59QkktwW47FVUJ3ky/eb7417uHKhX73GtX6+BcbtWRrzgxsYqHDNAfPEQ9tMN18pMr3jLOoyF1hSABiwn2mKE6JdbbWvBXegJvDcXJUC9mg=
Received: by 10.86.77.5 with SMTP id z5mr4355286fga.1192390410400;
        Sun, 14 Oct 2007 12:33:30 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id w7sm5709448mue.2007.10.14.12.33.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Oct 2007 12:33:29 -0700 (PDT)
Message-ID: <47126EDC.1060305@gmail.com>
Date:	Sun, 14 Oct 2007 21:32:44 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
References: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl> <20071002141125.GC16772@networkno.de> <20071002154918.GA11312@linux-mips.org> <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de> <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de> <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org> <4705004C.5000705@gmail.com> <Pine.LNX.4.64N.0710041616570.10573@blysk.ds.pg.gda.pl> <4705EFE5.7090704@gmail.com> <Pine.LNX.4.64N.0710051312490.17849@blysk.ds.pg.gda.pl> <470A4349.9090301@gmail.com> <Pine.LNX.4.64N.0710081611460.8873@blysk.ds.pg.gda.pl> <470BE1F4.3070800@gmail.com> <Pine.LNX.4.64N.0710101231290.9821@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0710101231290.9821@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17021
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Tue, 9 Oct 2007, Franck Bui-Huu wrote:
> 
>>>  What would be the gain for the kernel from using "-march=4ksd" rather 
>>> than "-march=mips32r2"?
>>>
>> It actually results in a kernel image ~30kbytes smaller for the former
>> case. It has been discussed sometimes ago on this list. I'm sorry but
>> I don't know why...
> 
>  Perhaps the pipeline description for the 4KSd CPU is different from the 
> default for the MIPS32r2 ISA.  Barring a study of GCC sources, if that 
> really troubles you, you could build the same version of the kernel with 
> these options:
> 
> 1. "-march=mips32r2"
> 
> 2. "-march=4ksd"
> 
> 3. "-march=mips32r2 -mtune=4ksd"
> 
> and compare the results.  I expect the results of #2 and #3 to be the same 
> and it would just back up my suggestion about keeping CPU-specific 
> optimisations separate from the CPU selection.

I think you misunderstood me, my own fault: the kernel was smaller
with "-march=4ksd". It was bigger when using "-march=mips32r2 -smartmips".

I was using SDE gcc.

		Franck
