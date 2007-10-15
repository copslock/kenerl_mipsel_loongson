Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2007 21:07:28 +0100 (BST)
Received: from fk-out-0910.google.com ([209.85.128.187]:13579 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20037645AbXJOUHS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 15 Oct 2007 21:07:18 +0100
Received: by fk-out-0910.google.com with SMTP id f40so1771118fka
        for <linux-mips@linux-mips.org>; Mon, 15 Oct 2007 13:07:17 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=oKdYBCPtTrHmuCzka+Wi2GAT3LB1CbLgEtQSkuaMddY=;
        b=aH5agP1DX4dUxBw8REGtA+49/m/ZS6wr6qXZtKU+ZOcSxUvCH07/n16+wPs3b2nYB+H0z7GDmk2OQfGOKPz7SvKO7ECorQZYUEsMQ/0mHDRmF6O1mcZju3mOqkmgaD0NY/13cT4OfmtDgs/hbYJaPcRfT0QCqIPgHyna/4dSu58=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Se6w1K71fNsEHw1EPdIT2WisY5AdA78CjHEkLgB1bFcSY9AAIzXrxcfpUqsQHTAcQgD2TXOpJy9mqvRvD0S8c5hqfcGv2WYYwFI9EIZdrehU/MdQnz6nz+/87eiM/iHkvTsZjBqSGtscDzyX2Hd+/4jSxYl4PMdXDgNnJKXmUXY=
Received: by 10.82.178.11 with SMTP id a11mr11970306buf.1192478837664;
        Mon, 15 Oct 2007 13:07:17 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id j9sm8721565mue.2007.10.15.13.07.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Oct 2007 13:07:16 -0700 (PDT)
Message-ID: <4713C840.8080206@gmail.com>
Date:	Mon, 15 Oct 2007 22:06:24 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [RFC] Add __initbss section
References: <470DF25E.60009@gmail.com> <Pine.LNX.4.64N.0710111307180.16370@blysk.ds.pg.gda.pl> <4712738A.5000703@gmail.com> <Pine.LNX.4.64N.0710151311350.16262@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0710151311350.16262@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17056
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Sun, 14 Oct 2007, Franck Bui-Huu wrote:
> 
>>>  I guess for a bss-type section you want to use something like:
>>>
>>> 	.section .init.bss,"aw",@nobits
>>>
>> Sorry but I'm missing your point here. This indeed should be added
>> for assembler code but I don't see how it's related with the kernel
>> image size difference I was seeing.
> 
>  Well, otherwise the section is marked as containing data and therefore 
> taking space in the image.

Well, since .init.bss is declared as follow:

	.init.bss (NOLOAD) : {
		...
	}

data should not take any space in the image...

> 
>  What do you mean by "assembler code" in this context, BTW?

I meant to be able to put data into .init.bss section from assembly
code (*.S files) like __INITDATA does for .init.data section.

		Franck
