Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Jun 2006 12:57:49 +0200 (CEST)
Received: from nf-out-0910.google.com ([64.233.182.189]:37914 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S8133484AbWFAK5l (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 1 Jun 2006 12:57:41 +0200
Received: by nf-out-0910.google.com with SMTP id l36so470174nfa
        for <linux-mips@linux-mips.org>; Thu, 01 Jun 2006 03:57:41 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qtmchspno369kX0KM5JZTIxkDFXbZ3BlkeDPZJwigF9bQPCNIJ71U8nixeY4wWDqD3Icf1PEFEdZdaMZT6PeyJrVXceMD9WR5o+pBPMEtvH2FtiTzZKm+pA6y2R9sAZM9WHawpOgEvz+9TrDevXqX/5I+qO19b7ykTvsCv0HDEk=
Received: by 10.48.243.8 with SMTP id q8mr600850nfh;
        Thu, 01 Jun 2006 03:56:31 -0700 (PDT)
Received: by 10.66.241.4 with HTTP; Thu, 1 Jun 2006 03:56:31 -0700 (PDT)
Message-ID: <50c9a2250606010356s63f6d6e7j255c77660d6f472a@mail.gmail.com>
Date:	Thu, 1 Jun 2006 18:56:31 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	"Thiemo Seufer" <ths@networkno.de>
Subject: Re: BFD: Warning: Writing section `.text' to huge (ie negative) file offset 0xa1ffff10
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <20060601092413.GL1717@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <50c9a2250605312319v7480f2el36d9c0a052c85d5f@mail.gmail.com>
	 <20060601092413.GL1717@networkno.de>
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11632
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

On 6/1/06, Thiemo Seufer <ths@networkno.de> wrote:
> zhuzhenhua wrote:
> > i have write a code to link at 0xa2000000(uncached address)
> > but when link i get the error as
> > "BFD: Warning: Writing section `.text' to huge (ie negative) file
> > offset 0xa1ffff10.
> > BFD: Warning: Writing section `.data' to huge (ie negative) file
> > offset 0xa200b050.
> > BFD: Warning: Writing section `.reginfo' to huge (ie negative) file
> > offset 0xa200c980.
> > mipsel-linux-objcopy: /root/project/brec_flash/release/brec_flash.bin:
> > File truncated
> > make: *** [brec_flash] Error 1"
> >
> > my link.xn as follow:
> >
> > OUTPUT_ARCH(mips)
> > ENTRY(brec_flash_entry)
> > SECTIONS
> > {
> > .text 0xa2000000 :
>
> Use
>
>  . = 0xa2000000;
>  .text :
>
> instead. "info ld" explains the subtle difference.
>
>
> Thiemo
>

do you mean use
 . = 0xa2000000;
 .text :
to replace
 .text 0xa2000000 :
?
i modify as that, and it still get the same message

thanks

zhuzhenhua
