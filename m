Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2007 21:36:27 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.187]:27231 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S28575972AbXKEVgS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Nov 2007 21:36:18 +0000
Received: by nf-out-0910.google.com with SMTP id c10so1261011nfd
        for <linux-mips@linux-mips.org>; Mon, 05 Nov 2007 13:36:18 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=GJC0VXEXYsZPLUh30Cg4JEpZYB62wXM/i4of6WajLw8=;
        b=JHOfMhivng1+2SJb6PmltTZleQvPxfRnAaxApOLJZqXJX5w8yJ2EBpDo9RCGwe2YhDpfaZKMe0UJw0hlIvZ+A0sU7FCLr4hvcsv5CNpaxb9J3NyNFmIHV8KKyI+bAcP+b/9dBT09pZ+WSTVsn7CT5JNlqe6opH39WgeNR0/eyoA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=CLaImnFetrNbbxpFhXtT+Cnmof4KFt9c28mmo0VRMu0cnEXe1kuhR4ohbMbB5DRqrFQocKf28Jq2/msrGrrABxOMm2gv6j57F+S8a3aRbSVgb7pQD0ZfCZpiysIG2kWhxMq+Q11HA2c7vTecx55Z1bZaGtjryAF6xYe1sB07O30=
Received: by 10.86.87.5 with SMTP id k5mr199657fgb.1194298577599;
        Mon, 05 Nov 2007 13:36:17 -0800 (PST)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id p9sm13081710fkb.2007.11.05.13.36.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Nov 2007 13:36:16 -0800 (PST)
Message-ID: <472F8C82.4080406@gmail.com>
Date:	Mon, 05 Nov 2007 22:34:58 +0100
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Thiemo Seufer <ths@networkno.de>, Nigel Stephens <nigel@mips.com>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
References: <4713C11F.3010903@gmail.com> <4713C958.8080805@mips.com> <47147551.1010004@gmail.com> <4714B58E.8020005@mips.com> <4715C039.7090603@gmail.com> <20071017123046.GY3379@networkno.de> <47160D31.5080201@mips.com> <472D8110.2080506@gmail.com> <20071104174710.GA9363@networkno.de> <472E2955.3000803@gmail.com> <20071105113618.GD27893@linux-mips.org>
In-Reply-To: <20071105113618.GD27893@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17409
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Sun, Nov 04, 2007 at 09:19:33PM +0100, Franck Bui-Huu wrote:
> 
>>> Latest GCC upstream supports it (in SVN since 2007-07-05).
>>>
>> Good news although gcc 4.3 release is planed for end of January.
>>
>> Is SDE gcc going to be obsolete after this release ?
> 
> As for the kernel I don't really care.  The policy is that a working kernel
> must be buildable with a stock gcc.  Which at times is painful, search for
> all the great use of .word in include/asm-mips/ ...  This doesn't say
> anything against taking advantage of other toolchains such SDE; it's just

It's actually hard to know the advantages of using SDE over a stock gcc.
The only difference I'm aware of is the smartmips ASE support in SDE.
But since this support is going to be added in stock gccs, I don't see
any advantages now and I'm wondering if I can give up using SDE...

		Franck
