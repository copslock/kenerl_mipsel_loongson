Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 21:54:38 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.186]:63752 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S22317644AbYJXUy3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Oct 2008 21:54:29 +0100
Received: by nf-out-0910.google.com with SMTP id h3so499614nfh.14
        for <linux-mips@linux-mips.org>; Fri, 24 Oct 2008 13:54:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:message-id:content-type
         :content-transfer-encoding;
        bh=aU+d+FEGGF6tNpFJlOslHFGG+mWi4YH8kTqjiYO+Yzo=;
        b=b8nbZljTAXSxN1nVNgyQqngCUhJXY4+QCVjbkgIl9r3KQWAbgWsjZh66PB8ce1YqI5
         w4K81rnbB7grYTj/FnAS5By69v+hjYBYsFcvYlLPnBYKC41XfmyEPpdGrMj4Yhy8c9eD
         ZHcAFC2jnUXw7bYi4JUrCqvxcrCrKhgJqp0xw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:message-id:content-type
         :content-transfer-encoding;
        b=AD+Q/oRgR5S+Dq8I6Rz/YJmMGUCF7ZKr4/ZstGnW7/E+1gUr2PgW6LKn6WKYtJ5y3v
         HmbhFqLwj0NJ3RLxJQIhgWgMggdz6OV4uoAHFSUOLsvShp185EtRk1BasdPLwsJjqzl3
         l4wdintaH2nKYELyei6w5staj2woWRb3Au9IA=
Received: by 10.103.233.12 with SMTP id k12mr1328052mur.54.1224881665574;
        Fri, 24 Oct 2008 13:54:25 -0700 (PDT)
Received: from ?192.168.123.7? (chello089077041080.chello.pl [89.77.41.80])
        by mx.google.com with ESMTPS id u9sm2398144muf.9.2008.10.24.13.54.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Oct 2008 13:54:24 -0700 (PDT)
From:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] TXx9: Add TX4938 ATA support (v2)
Date:	Fri, 24 Oct 2008 22:52:25 +0200
User-Agent: KMail/1.9.10
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	linux-ide@vger.kernel.org, ralf@linux-mips.org
References: <20081023.011646.51867355.anemo@mba.ocn.ne.jp> <200810232206.50973.bzolnier@gmail.com> <4900F8DE.4070203@ru.mvista.com>
In-Reply-To: <4900F8DE.4070203@ru.mvista.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200810242252.25327.bzolnier@gmail.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-Path: <bzolnier@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20957
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bzolnier@gmail.com
Precedence: bulk
X-list: linux-mips

On Friday 24 October 2008, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> >>> From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> >>> Subject: [PATCH] TXx9: Add TX4938 ATA support (v3)
> >>>       
> >>> Add a helper routine to register tx4938ide driver and use it on
> >>> RBTX4938 board.
> >>>       
> >>> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> >>>       
> >>     The patch already had my
> >>
> >> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> >>     
> >
> > applied
> >   
> 
>    Hm, I thought that one was for Ralf...

Ralf ACK-ed the change and was fine with it going through ide tree.

Anyway it really doesn't matter through whose tree such patches are
going in as long as people are fine with them.

No need to add some more rigid kernel bureaucracy...
