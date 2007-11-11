Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Nov 2007 13:59:53 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.188]:5358 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20026792AbXKKN7o (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 11 Nov 2007 13:59:44 +0000
Received: by nf-out-0910.google.com with SMTP id c10so747391nfd
        for <linux-mips@linux-mips.org>; Sun, 11 Nov 2007 05:59:43 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=neVcTXFPSfP8rSxdiGkkgDRfYwjtnGilTTLB0FRC0Zw=;
        b=O2assTj2ZeBG+/xHaYobd6oAyxTSOnmGnxX5lAxXnTO3fQc6alGkE3voIyW24Bek0ExrnSjmlWoXIpGTJ5L1AIVEYWc5IAA+VXsIU0yf8XiThWwSqbchPKGVyi8bZTYIAuKIdiQScdn2o0qqYgWO1pwq+CjIMLFcarrnucnqtqA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=iqIGVVvcqbTGS4kg/JVYznnMMmkN4yrI1/viyPntTJpkqHmqiu72NW9UgltX2Wyp4WgtPEqhdjUYXDA7Chr2WiPgPuWKuwuQYreg0mMY0VXlEK4LoN/34YnQwvG895HlcwK9x/JxdNMWpRi11eY/SvI85XewOMRrXSIE0CTnEho=
Received: by 10.86.49.13 with SMTP id w13mr3543323fgw.1194789583605;
        Sun, 11 Nov 2007 05:59:43 -0800 (PST)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id e32sm518447fke.2007.11.11.05.59.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Nov 2007 05:59:42 -0800 (PST)
Message-ID: <47370A5C.8060200@gmail.com>
Date:	Sun, 11 Nov 2007 14:57:48 +0100
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Thiemo Seufer <ths@networkno.de>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Introduce __fill_user() and kill __bzero()
References: <4736C1EA.2050009@gmail.com> <20071111130130.GB8363@networkno.de>
In-Reply-To: <20071111130130.GB8363@networkno.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17461
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:
>>  /*
>> - * memset(void *s, int c, size_t n)
>> + * An outline version of memset, which should be used either by gcc or
>> + * by assembly code.
>> + */
>> +NESTED(memset, 24, ra)
>> +	PTR_ADDU	sp, sp, -24
>> +	LONG_S		a0, 16(sp)
>> +	LONG_S		ra, 20(sp)
>> +	jal		__fill_user
>> +	LONG_L		v0, 16(sp)
>> +	LONG_L		ra, 20(sp)
>> +	PTR_ADDU	sp, sp, 24
>> +	jr		ra
>> +END(memset)
> 
> This will break on 64bit kernels.
> 

Obviously...

Looks like I should find a good place to implement it in C... or do
you know a sane way (without too many #ifdef) to do that in assembly
code ?

thanks,
		Franck
