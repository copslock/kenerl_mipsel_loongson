Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Nov 2007 12:37:02 +0000 (GMT)
Received: from fk-out-0910.google.com ([209.85.128.188]:3784 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20026277AbXKNMgx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 14 Nov 2007 12:36:53 +0000
Received: by fk-out-0910.google.com with SMTP id f40so152892fka
        for <linux-mips@linux-mips.org>; Wed, 14 Nov 2007 04:36:43 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=L4ZWNm9CS0TIPtCphL9PcZWzzLlJTsrXCIPOndF6TeM=;
        b=UiKq1F3KoZY/D6W7ILacMgAajmlK7KiZI0AclyWGfHocx9l686sAp7mQsH0hI8OFcPjfXD3MyHri1sZFxOUVR5zxcILaSDAWc/WbcbmK35pBgfvvqDGa1+hf4BhcfT3VGQKZUNhv3hgYPRh2LGwIRYVbUw8gABTebeRBWQQYuBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=RUE+s1wvDlOed4b198HJ76I5dmJsflqdqpGCEPNxshmtjWD2/DGq/zNmwpsPaGs9pN56kg77SxEs162QVw3MdnmcJBFyZU/dkPZPcA/rrrmC18zN+YOtUjNLPJ5VtOuH8mmUh9j+nSmWvMQy1Y8IkrDkUxViNMdH8IgTUy6lGjc=
Received: by 10.82.190.2 with SMTP id n2mr121460buf.1195043803161;
        Wed, 14 Nov 2007 04:36:43 -0800 (PST)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id j9sm1010829mue.2007.11.14.04.36.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Nov 2007 04:36:42 -0800 (PST)
Message-ID: <473AEB52.40501@gmail.com>
Date:	Wed, 14 Nov 2007 13:34:26 +0100
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Thiemo Seufer <ths@networkno.de>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Introduce __fill_user() and kill __bzero()
References: <4736C1EA.2050009@gmail.com> <20071111130130.GB8363@networkno.de> <473AB0B6.2070208@gmail.com> <20071114115807.GL8363@networkno.de>
In-Reply-To: <20071114115807.GL8363@networkno.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17498
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:
> In general we do (think of stack unwinding etc.).  I believe this
> implementation should move to C, as it doesn't need an assembler
> implementation:
> 
> void *memset (void *s, int c, kernel_size_t n)
> {
> 	__fill_user(s, c, n);
> 	return s;
> }
> 
> It looks much nicer that way. :-)
> 

Sure but memset.S was a really good place to implement memset(), wasn't
it ?

And since the implementation should have been trivial, I thought it was
ok to implement in assembly.

Ok, I'll look for another place.

Thanks,
		Franck
