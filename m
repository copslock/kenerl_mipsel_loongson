Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jan 2007 16:27:15 +0000 (GMT)
Received: from ag-out-0708.google.com ([72.14.246.243]:29530 "EHLO
	ag-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20038620AbXA2Q1L (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 29 Jan 2007 16:27:11 +0000
Received: by ag-out-0708.google.com with SMTP id 22so1217390agd
        for <linux-mips@linux-mips.org>; Mon, 29 Jan 2007 08:27:04 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P2jaqsfAciBI8b5VOQ4P1dapodSIgpzpkctckbYTBzmkSFWFed09r1gQkk+Lk/0somkjhxQ3KYpx10cjMmydQ7ggGneLx328wZJHQJceCA3pAF79KKfQ2Z/6SkCGkxX0ztF89zkR2X9D2EJjUT65Ple70523Jh2yHTmOkydUUPQ=
Received: by 10.90.78.1 with SMTP id a1mr6924022agb.1170088024628;
        Mon, 29 Jan 2007 08:27:04 -0800 (PST)
Received: by 10.90.34.12 with HTTP; Mon, 29 Jan 2007 08:27:04 -0800 (PST)
Message-ID: <cda58cb80701290827i1892e74dlb60651847982f77f@mail.gmail.com>
Date:	Mon, 29 Jan 2007 17:27:04 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: RFC: Sentosa boot fix
Cc:	macro@linux-mips.org, dan@debian.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org
In-Reply-To: <20070130.011442.21365159.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070128180807.GA18890@nevyn.them.org>
	 <cda58cb80701290159m5eed331em5945eac4a602363a@mail.gmail.com>
	 <Pine.LNX.4.64N.0701291527130.26916@blysk.ds.pg.gda.pl>
	 <20070130.011442.21365159.anemo@mba.ocn.ne.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13845
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 1/29/07, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
>
> I thought -msym32 can not be used for 64-bit kernels which do not have
> CKSEG load address, but apparently IP27 is using -msym32 with XKPHYS
> load address.  Hmm...
>

It may be interesting to have a look to the assembly code in this case
to see what the compiler does exactly.

-- 
               Franck
