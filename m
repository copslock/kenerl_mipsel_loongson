Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Mar 2007 16:30:06 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.189]:61236 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20037608AbXCEQ3p (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Mar 2007 16:29:45 +0000
Received: by nf-out-0910.google.com with SMTP id l24so2058536nfc
        for <linux-mips@linux-mips.org>; Mon, 05 Mar 2007 08:28:42 -0800 (PST)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TheGobGUAstWxt8Za6z/ZxTVW7j2cU2llnj+GbF6k56nzcpx0mh1EC+ez/EroHk2vNlzjy6djKohIim9plywEbV9+Bd73om3ETMpz3f6qCOkOYLd6w9IW48AVMVyCsg/OXITKe0ulKBESUr4r319EfXn5u+HvDkZ9gaXATsVeEs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nM1BC76lNgbK60mv1YN+UhG9Y9JZMIJyNV/oy1tFi/7Ie3a1KgY6EJgiiTxcYKz4s/QoC4qDPxIJiLNxDUlilU8jg5DnI9pyot4/nUb/HkOM61Gbs1Gz+ICZU9hOnvSyogOqRpv/p2zhHnuMdKYp7cdH2MUogXuesyGLsIUSSho=
Received: by 10.78.201.2 with SMTP id y2mr654827huf.1173112122732;
        Mon, 05 Mar 2007 08:28:42 -0800 (PST)
Received: by 10.78.44.13 with HTTP; Mon, 5 Mar 2007 08:28:42 -0800 (PST)
Message-ID: <c4357ccd0703050828g7ee6eb30w516bb0d60928bbc6@mail.gmail.com>
Date:	Mon, 5 Mar 2007 18:28:42 +0200
From:	"Alexander Sirotkin" <demiourgos@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: 0 function size
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20070305162028.GA786@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <c4357ccd0703050619r6b5a7452j6b582687bf1794d3@mail.gmail.com>
	 <20070305162028.GA786@linux-mips.org>
Return-Path: <demiourgos@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14359
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: demiourgos@gmail.com
Precedence: bulk
X-list: linux-mips

On 3/5/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Mon, Mar 05, 2007 at 04:19:18PM +0200, Alexander Sirotkin wrote:
>
> > I'm trying to see the function sizes for some object file compiled for
> > MIPS. On x86 one can use objdump  or readelf to see the sizes, however
> > for same weird reason on MIPS these routines show 0 for all functions.
> >
> > Any idea what I'm missing ?
>
> Works fine here:
>
> 801f3f10 l     F .text  00000074 rekey_seq_generator
> 80327f2c l     O .data  00000028 rekey_work
> 80345dd0 l     F .init.text     00000020 seqgen_init
> 801f3fd0 l     F .text  000000f4 uuid_strategy
> 801f40c4 l     F .text  0000012c proc_do_uuid
> 801f42e0 l     F .text  0000012c extract_entropy_user
> 801f440c l     F .text  0000000c urandom_read
> 801f4418 l     F .text  000000fc random_write
> 801f4514 l     F .text  000001f4 random_ioctl
> 801f484c l     F .text  00000090 random_poll
> 801f4ac8 l     F .text  00000190 random_read
> 80327f64 l     O .data  00000004 sysctl_poolsize
>
> So seems to be a defect with your particular toolchain or objdump or readelf.
Yeah, it is indeed a problem with the particular toolchain I was using. Thanks.
>
>   Ralf
>
