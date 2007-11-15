Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Nov 2007 21:16:56 +0000 (GMT)
Received: from mu-out-0910.google.com ([209.85.134.186]:25458 "EHLO
	mu-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20032656AbXKOVQr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Nov 2007 21:16:47 +0000
Received: by mu-out-0910.google.com with SMTP id g7so704719muf
        for <linux-mips@linux-mips.org>; Thu, 15 Nov 2007 13:16:37 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=zkBxyQzYkDvKnJyvu2batJvPxTh+apCWIOHxywC6GGo=;
        b=O4hKEiUJw3Uo8ullcYeneO8NKKZkwBOEtEEWU+YOjZHhhOfq5kQBje+jR+efpbDLBSzOXT5UGsffUOqCRFiR0vpk4w4ziqpOL6WKuVMbUrfxyRIpbkv9OaaelyJsDrlAyZHXkG37THaO6ZaTo8QprcTxtak85WT2NKkwn/lI2sQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=rPhic0jnwHpQYVndFYTrlZIp1SwpDeUQqMrpxuboCO/wbl/aFcksRz7KS1rK3JS9I3mX3UK2XLGwT+ux/jMJ2p2TjfxrzA35+3VJ8ea6PwshkYwQNdJh/QLNifm7SvxO3TChgXPftofoNcT5DrH7ksY3AfmknkJTjny29wjN16s=
Received: by 10.86.84.5 with SMTP id h5mr1039380fgb.1195161397214;
        Thu, 15 Nov 2007 13:16:37 -0800 (PST)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id 4sm1196735fge.2007.11.15.13.16.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Nov 2007 13:16:36 -0800 (PST)
Message-ID: <473CB727.8010106@gmail.com>
Date:	Thu, 15 Nov 2007 22:16:23 +0100
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Geert Uytterhoeven <geert@linux-m68k.org>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Thiemo Seufer <ths@networkno.de>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Introduce __fill_user() and kill __bzero() [take #2]
References: <473C720B.7000100@gmail.com> <Pine.LNX.4.64.0711151744580.31039@anakin>
In-Reply-To: <Pine.LNX.4.64.0711151744580.31039@anakin>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17517
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Geert Uytterhoeven wrote:
> On Thu, 15 Nov 2007, Franck Bui-Huu wrote:
>>  I put the out of line version of memset in kernel/mips_ksym.c. I
>>  haven't found a better place. But if you really think we should
>>  create a lib/memset.c and rename lib/memset.S into lib/fill_user.S, I
>>  can change it.
> 
> kernel/mips_ksym.c is not a good place.

Sigh... thanks for spotting this.

So since I've no idea where I could put this function I'll follow
Thiemo's suggestion but instead of calling the new file lib/memset.c,
I'll use lib/string.c since we could move or implement other stuffs in
it.

Is it ok ?

		Franck
