Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Sep 2006 13:55:34 +0100 (BST)
Received: from wx-out-0506.google.com ([66.249.82.225]:36303 "EHLO
	wx-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038701AbWILMzd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 12 Sep 2006 13:55:33 +0100
Received: by wx-out-0506.google.com with SMTP id h30so2254453wxd
        for <linux-mips@linux-mips.org>; Tue, 12 Sep 2006 05:55:31 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=iKK1J5a8hUuU+GFtwXwS8Gpcmw/oEsPzZRN4yWWwvRwRQeLaznYy8y37W9c8uBAxxdjQLnB7KoI5jnAkiuOJcc0GCV1aCPwhw4cXQmTA2r0ZRtAJ9ElIjpZDUcMTlRrMMkmxtm+n1eJqKVYj4gbtRCCpjgQkoz43HLUBaj4GjBY=
Received: by 10.90.100.2 with SMTP id x2mr2032162agb;
        Tue, 12 Sep 2006 05:55:31 -0700 (PDT)
Received: by 10.90.86.20 with HTTP; Tue, 12 Sep 2006 05:55:31 -0700 (PDT)
Message-ID: <474ab6f00609120555p33522851p151f7062e4379d17@mail.gmail.com>
Date:	Tue, 12 Sep 2006 08:55:31 -0400
From:	"Brett Foster" <fosterb@uoguelph.ca>
To:	"Youngduk Goo" <ydgoo9@gmail.com>
Subject: Re: NOR Flash memory write speed.
Cc:	linux-mips@linux-mips.org
In-Reply-To: <38dc7fce0609120440o11c6a11ejf7f0a3cb1371bb40@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <38dc7fce0609120440o11c6a11ejf7f0a3cb1371bb40@mail.gmail.com>
X-Google-Sender-Auth: be1aed679b4d8efb
Return-Path: <666f7374657262@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12565
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fosterb@uoguelph.ca
Precedence: bulk
X-list: linux-mips

On 9/12/06, Youngduk Goo <ydgoo9@gmail.com> wrote:
> Hello, all
>
> I am developing the system using the NOR flash (32MB) and the core is
> about 300MHz mips.
> I wonder how long takes the whole erase and write time to flash memory.
> I tried it on the bootloader. Firstof all, bootloader(YAMON) load the image
> and erase the flash except bootloader region, write the image..
> It took about 14-16minutes.I think it is too long.

Can't really say, but it seems ok to me. Each chip will have unique
timing characteristics which are covered in the data sheet for the
flash part with min, typical and max values. You can compute the upper
and lower bounds of the operation using that information.

>
> I would like to know, for you, normally how long it tasks ?
>
> Thanks,
>
>
