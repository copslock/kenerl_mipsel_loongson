Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Oct 2007 20:38:12 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.184]:37343 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20035414AbXJNTiD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 14 Oct 2007 20:38:03 +0100
Received: by nf-out-0910.google.com with SMTP id c10so1094751nfd
        for <linux-mips@linux-mips.org>; Sun, 14 Oct 2007 12:38:03 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=a0V4KC5wcxV6qCZp4IzVExB7mmnr7KTbLDbRQCIcrHo=;
        b=WwRVcVmGbig9USMhA4V55B5iaVlTyY3hrGf9zy9oYukEysQwyxV25U1kZfLP9s1wL73KEwYoBcXKT5WpLFNca/ZsR4IjAqdRBD+/qYo/+fVNoUkeWb/BXDHZ+kOw1kUUINnUR7XipJBD1rQC5YlbbcX1G7UVaT9e7eqqZDNkkE0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=H1Cz1wGKVg9ksos5xeqC5xUx4SicCVhMh0oiMBf94/KMrFHTPRwWUqEuQMo9rn0vQUFtUPNgWfnH2wQGZC7prmTvuk7tPKmJxhh5CfN2L6AfkLWWKbikKEhvzxZI9y0FAVt2g/bBrTNCDi1UJYgc3KF2+zz4W71qaeytEOoi5Tg=
Received: by 10.86.58.3 with SMTP id g3mr4364735fga.1192390683006;
        Sun, 14 Oct 2007 12:38:03 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id i5sm5734970mue.2007.10.14.12.38.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Oct 2007 12:38:02 -0700 (PDT)
Message-ID: <47126FEE.5000400@gmail.com>
Date:	Sun, 14 Oct 2007 21:37:18 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	Nigel Stephens <nigel@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: [SPAM?]  Re: [PATCH] mm/pg-r4k.c: Dump the generated code
References: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl> <20071002141125.GC16772@networkno.de> <20071002154918.GA11312@linux-mips.org> <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de> <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de> <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org> <4705004C.5000705@gmail.com> <Pine.LNX.4.64N.0710041616570.10573@blysk.ds.pg.gda.pl> <4705EFE5.7090704@gmail.com> <Pine.LNX.4.64N.0710051312490.17849@blysk.ds.pg.gda.pl> <470A4349.9090301@gmail.com> <Pine.LNX.4.64N.0710081611460.8873@blysk.ds.pg.gda.pl> <470BE1F4.3070800@gmail.com> <Pine.LNX.4.64N.0710101231290.9821@blysk.ds.pg.gda.pl> <470CC0CE.9080303@mips.com> <Pine.LNX.4.64N.0710111242530.16370@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0710111242530.16370@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17022
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> 
>  Though either way I am not sure these would have to be put in Kconfig or 
> Makefile anywhere.  A generic way should be enough for the insistent as 
> the potentially useful options may proliferate; we have the CFLAGS_KERNEL 
> and CFLAGS_MODULE Makefile variables that would suit for setting upon 
> `make' invocation.
> 

In that case very few people would use this optimization.

We could just have one new Kconfig option in kernel hacking submenu:

config EXTRA_CFLAGS
	string
	help
	  If you want to pass additionnal option to GCC
	  for optimization purpose for example, use this.


		Franck 
