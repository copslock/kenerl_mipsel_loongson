Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Sep 2005 13:06:05 +0100 (BST)
Received: from zproxy.gmail.com ([64.233.162.202]:24262 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133525AbVIZMFo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 26 Sep 2005 13:05:44 +0100
Received: by zproxy.gmail.com with SMTP id j2so193329nzf
        for <linux-mips@linux-mips.org>; Mon, 26 Sep 2005 05:05:38 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=AihEOyNcP+aGufApcrJNKVZLv4/ALYyTymmlJxNcJoQyDlZEvu92aDlHYCyGaxZJpRvyrotPTNP8c2YCU6XCGZA9PdSfP+t22U1IBchJe3x8AeGxrirTd3fqDuFQyby2djPHRURi9jE6WOrEEMUn4wTOMmQ92ysPQvjnBNuoUjk=
Received: by 10.36.33.15 with SMTP id g15mr1527660nzg;
        Mon, 26 Sep 2005 05:05:36 -0700 (PDT)
Received: by 10.36.49.3 with HTTP; Mon, 26 Sep 2005 05:05:36 -0700 (PDT)
Message-ID: <cda58cb805092605057f7cad7d@mail.gmail.com>
Date:	Mon, 26 Sep 2005 14:05:36 +0200
From:	Franck <vagabon.xyz@gmail.com>
Reply-To: Franck <vagabon.xyz@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] minor fix in asm-mips/module.h
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20050926115539.GB3175@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_3490_19956359.1127736336430"
References: <cda58cb8050926000665f843dc@mail.gmail.com>
	 <20050926115539.GB3175@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9040
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_3490_19956359.1127736336430
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

2005/9/26, Ralf Baechle <ralf@linux-mips.org>:
> On Mon, Sep 26, 2005 at 09:06:50AM +0200, Franck wrote:
>
> > This patch replaces an empty preprocessor condition #elif by #else. It
> > adds 4ksc and 4ksd as well.
>
> You forgot to include the patch ...

sorry for that, here it is...

Thanks
--
               Franck

------=_Part_3490_19956359.1127736336430
Content-Type: text/x-patch; name="module.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="module.patch"

LS0tIG1vZHVsZS5ofm9sZAkyMDA1LTA5LTI2IDE0OjAyOjMyLjAwMDAwMDAwMCArMDIwMAorKysg
bW9kdWxlLmgJMjAwNS0wOS0yNiAwOTo1NDowOC4wMDAwMDAwMDAgKzAyMDAKQEAgLTExMyw3ICsx
MTMsMTEgQEAgc2VhcmNoX21vZHVsZV9kYmV0YWJsZXModW5zaWduZWQgbG9uZyBhZAogI2RlZmlu
ZSBNT0RVTEVfUFJPQ19GQU1JTFkgIlJNOTAwMCIKICNlbGlmIGRlZmluZWQgQ09ORklHX0NQVV9T
QjEKICNkZWZpbmUgTU9EVUxFX1BST0NfRkFNSUxZICJTQjEiCi0jZWxpZgorI2VsaWYgZGVmaW5l
ZCBDT05GSUdfQ1BVXzRLU0MKKyNkZWZpbmUgTU9EVUxFX1BST0NfRkFNSUxZICI0S1NDIgorI2Vs
aWYgZGVmaW5lZCBDT05GSUdfQ1BVXzRLU0QKKyNkZWZpbmUgTU9EVUxFX1BST0NfRkFNSUxZICI0
S1NEIgorI2Vsc2UKICNlcnJvciBNT0RVTEVfUFJPQ19GQU1JTFkgdW5kZWZpbmVkIGZvciB5b3Vy
IHByb2Nlc3NvciBjb25maWd1cmF0aW9uCiAjZW5kaWYKIAo=
------=_Part_3490_19956359.1127736336430--
