Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2007 20:45:02 +0000 (GMT)
Received: from fk-out-0910.google.com ([209.85.128.189]:25011 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S28575294AbXKEUow (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Nov 2007 20:44:52 +0000
Received: by fk-out-0910.google.com with SMTP id f40so1735733fka
        for <linux-mips@linux-mips.org>; Mon, 05 Nov 2007 12:44:42 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=gw6EXNvxV40Jzla3qHU6BCiO8rXpSjk+jnwq4POPzdE=;
        b=oEgyyLR9b5gdm/7PwT+JtCzUgIx82FacBGm2HYGYdRbo6skZauatbEU6RYa6ohy5zePX/UPuVPu4pKeiNlscJ0Yo3T/2zlftJObVeBCEFbf72Yk4uGp0fq/nqttZABMJ6kFmoS10UKk6RZSffGfXzU0kSqzNuWn72Xfy7bW8MPs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Yin+I+KRZ1sQ3uxENC+wtIwElrYEt0kbQ0mLdBfUFjRvRXqG6k5Qk6Y4TL+939sVrHPZ9a2asFL8sKzO84yRNcpg5Rtdct7nRJuBaqzbrVYQRPDOrCCOzZHMp0Bj0bmQP0G+dgA1ANfyy1jS2dKTO4HYKfy0lWygmEGzBGw0VTw=
Received: by 10.82.124.10 with SMTP id w10mr10184136buc.1194295482329;
        Mon, 05 Nov 2007 12:44:42 -0800 (PST)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id j9sm15646076mue.2007.11.05.12.44.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Nov 2007 12:44:41 -0800 (PST)
Message-ID: <472F806C.3060005@gmail.com>
Date:	Mon, 05 Nov 2007 21:43:24 +0100
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Nigel Stephens <nigel@mips.com>
CC:	Thiemo Seufer <ths@networkno.de>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
References: <47126EDC.1060305@gmail.com> <20071014195324.GT3379@networkno.de> <4713C11F.3010903@gmail.com> <4713C958.8080805@mips.com> <47147551.1010004@gmail.com> <4714B58E.8020005@mips.com> <4715C039.7090603@gmail.com> <20071017123046.GY3379@networkno.de> <47160D31.5080201@mips.com> <472D8110.2080506@gmail.com> <20071104174710.GA9363@networkno.de> <472E2955.3000803@gmail.com> <472F3D93.1070400@mips.com>
In-Reply-To: <472F3D93.1070400@mips.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17408
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Nigel Stephens wrote:
> 
> A supported toolchain which now includes SmartMIPS support is the
> CodeSourcery MIPS Linux toolchain, based on gcc-4.2, see
> http://www.codesourcery.com/store/catalogue/c3/p17

Interesting.

It seems that MIPS toolchains are not part of the 'lite edition' though.

Thanks,
		Franck
