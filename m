Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Oct 2007 20:53:36 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.184]:26149 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20035438AbXJNTx2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 14 Oct 2007 20:53:28 +0100
Received: by nf-out-0910.google.com with SMTP id c10so1096766nfd
        for <linux-mips@linux-mips.org>; Sun, 14 Oct 2007 12:53:27 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=kXxUrVFf+PxHhylMiAkNrrvEGS60cN5ONfDZEiPRE7M=;
        b=kBkRXRAHOn9YMyjLL8CnHUEK5z192FYDP5+Ey4MtpCo/51qnRV9FMvgIEuulpjc3ADq7oZlDg3bFlnchqEfX22L13W9i4mKHcuEqpDb1h6A6MEHwQjGLHmOHeqqNTavhZG3W+CRPrVt0LjUyx1U/Ma6EY5P8fHK9NVe0jWcGpdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=o7TxH4eeOse3tgH7jrpW8bvs2dFsMfE2xkovzvWLLDmGmUfGqKvSwIYMifg+lLaEYPImYAI6TD9G7aLvv6SA1oZaBsI3jVeBNqEPVvBlTyeCkF4OisBoUtYcwcGLzZnBiAWXgHYFYhevNB5xJPZLOIatUftP7EwLwc8/eMd01OU=
Received: by 10.86.96.18 with SMTP id t18mr4378635fgb.1192391607798;
        Sun, 14 Oct 2007 12:53:27 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id e32sm6422021fke.2007.10.14.12.53.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Oct 2007 12:53:27 -0700 (PDT)
Message-ID: <4712738A.5000703@gmail.com>
Date:	Sun, 14 Oct 2007 21:52:42 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [RFC] Add __initbss section
References: <470DF25E.60009@gmail.com> <Pine.LNX.4.64N.0710111307180.16370@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0710111307180.16370@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17024
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Thu, 11 Oct 2007, Franck Bui-Huu wrote:
> 
>> and the kernel image is bigger after the patch is applied !
>>
>> $ ls -l vmlinux*
>> -rwxrwxr-x 1 fbuihuu fbuihuu 2503324 2007-10-11 11:41 vmlinux*
>> -rwxrwxr-x 1 fbuihuu fbuihuu 2503264 2007-10-11 11:41 vmlinux~old*
>>
>> Could anybody explain me why ? The time is missing and I probably
>> couldn't investigate into this until this weekend. 
> 
>  I guess for a bss-type section you want to use something like:
> 
> 	.section .init.bss,"aw",@nobits
> 

Sorry but I'm missing your point here. This indeed should be added
for assembler code but I don't see how it's related with the kernel
image size difference I was seeing.

> 
>  Well, there should be no need for an extra segment -- just rearrange the 
> order of the sections in the linker script appropriately.  You should 
> probably add __exitbss for consistency too.  You can make all the three 
> sections adjacent so that no separate initialisation is required.
> 

I'll do that.

		Franck
