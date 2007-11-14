Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Nov 2007 08:26:54 +0000 (GMT)
Received: from fk-out-0910.google.com ([209.85.128.186]:1806 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20024865AbXKNI0q (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 14 Nov 2007 08:26:46 +0000
Received: by fk-out-0910.google.com with SMTP id f40so95874fka
        for <linux-mips@linux-mips.org>; Wed, 14 Nov 2007 00:26:36 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=D8tQCcUSeg1/mPL6dfvMfUtk2xFcplY1Vow7KaTLBZQ=;
        b=aDSglRRJWel5Igc12je8wLumoIOj67U93htaZp6j69GivXseozv50MPL3YAxx44IWxRRd5bvjKQl9usgUhfYs0Rle6L3XtKQstDWMrILEaXcgjo1V16buRjnlww+lVRhu/01aCaDDy96lLjRW+Xwn7VT7KerLgSJeVhsARnkqgI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=cztoGC4SuySmtC0lRfYRBoh+39VFObhSFXuIxlb6fvzbRGRWJJEwK21l8HvoxCDHyiSvfX74+tJWL3ABiRraSQ6P437AA53NcjQrvEDN/t4vVvhdXYtHe0YvM+YbJh7dx7KytWJqI4lNwx5AkZVUcW61rQACJ9EZgHd09c1c8so=
Received: by 10.82.119.17 with SMTP id r17mr3638701buc.1195028795532;
        Wed, 14 Nov 2007 00:26:35 -0800 (PST)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id g1sm616777muf.2007.11.14.00.26.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Nov 2007 00:26:34 -0800 (PST)
Message-ID: <473AB0B6.2070208@gmail.com>
Date:	Wed, 14 Nov 2007 09:24:22 +0100
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
X-archive-position: 17494
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:
> Franck Bui-Huu wrote:
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

Is the following correct ?

NESTED(memset, 16, ra)
        PTR_ADDU        sp, sp, -16
        LONG_S          a0,  8(sp)
        LONG_S          ra, 16(sp)
        jal             __fill_user
        LONG_L          v0,  8(sp)
        LONG_L          ra, 16(sp)
        PTR_ADDU        sp, sp, 16
        jr              ra
END(memset)

I know it doesn't respect any mips ABI but in this case do
we really care ?

thanks.

		Franck
