Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Aug 2007 17:34:18 +0100 (BST)
Received: from fk-out-0910.google.com ([209.85.128.189]:47935 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20024433AbXHGQeK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 7 Aug 2007 17:34:10 +0100
Received: by fk-out-0910.google.com with SMTP id f40so1785364fka
        for <linux-mips@linux-mips.org>; Tue, 07 Aug 2007 09:33:52 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ocCRNcHs5ka6EcPMBVKVWIWzycAwRDIiLJoYyTS3SPRlKI5edQan5qOMYV2NqLV1ZUnB6pMt5GixEXSHRs7z5bxDmRZNKo1ikvdovWiVkBlqyeXB3cKVvnQbKn28TNnZoLp28FBJK3Z8PgV+Kt7Or5zd2tWOjTabBjNY6Kzmkk8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VawbMaS8BmeYiVUwPZs66oRpwJnEfoxV8wPV48KaIvnubAxbW2/Ko4aiZHnpNiUcKqG9odsu7fERVdWbNEJ+7cHRGHGHGHJjDVqywu+4kWDWyCgX/g19yha/XdslrDzC8BKTdR1CWptrJzk0PwngIi0RrRQRhIeDSI4yNeJKpjc=
Received: by 10.82.151.14 with SMTP id y14mr6910671bud.1186504431931;
        Tue, 07 Aug 2007 09:33:51 -0700 (PDT)
Received: by 10.82.148.14 with HTTP; Tue, 7 Aug 2007 09:33:51 -0700 (PDT)
Message-ID: <40378e40708070933v6d555948p7a94601ed105dd2d@mail.gmail.com>
Date:	Tue, 7 Aug 2007 18:33:51 +0200
From:	"Mohamed Bamakhrama" <bamakhrama@gmail.com>
Reply-To: bamakhrama@gmail.com
To:	"Geert Uytterhoeven" <geert@linux-m68k.org>,
	"Freddy Spierenburg" <freddy@dusktilldawn.nl>
Subject: Re: ELF to S-Record convertor
Cc:	linux-mips@linux-mips.org
In-Reply-To: <Pine.LNX.4.64.0708071743380.29955@anakin>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <40378e40708070832g1aa613fcg7e486d0d778bb84f@mail.gmail.com>
	 <Pine.LNX.4.64.0708071743380.29955@anakin>
Return-Path: <bamakhrama@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16118
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bamakhrama@gmail.com
Precedence: bulk
X-list: linux-mips

Thanks all.
It is working now.


On 8/7/07, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, 7 Aug 2007, Mohamed Bamakhrama wrote:
> > Does anyone know of any open source tool for converting ELF images to
> > S-Record images?
>
> objcopy from binutils?
>
> Gr{oetje,eeting}s,
>
>                                                 Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                                             -- Linus Torvalds
>


-- 
Mohamed A. Bamakhrama
Am Schaeferanger 15, room 035
85764 Oberschleissheim, Germany
Email: bamakhra@cs.tum.edu
Web: http://home.cs.tum.edu/~bamakhra/
Mobile: +49-160-9349-2711
