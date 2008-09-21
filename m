Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Sep 2008 12:09:21 +0100 (BST)
Received: from mail-gx0-f10.google.com ([209.85.217.10]:1012 "EHLO
	mail-gx0-f10.google.com") by ftp.linux-mips.org with ESMTP
	id S62084084AbYIUKzd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 21 Sep 2008 11:55:33 +0100
Received: by gxk3 with SMTP id 3so2023460gxk.0
        for <linux-mips@linux-mips.org>; Sun, 21 Sep 2008 03:55:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Jj1XYucARUJS3q7uPknpC9Qhabf46LKAyRnk1rT8IfE=;
        b=C1UjDHge9+HBJ2CbgJn8brEKBiTamW4otN7R0RXZWpxTH+pnYfdy7qkLVxUzBZ6cDG
         iP/93l90dvCyy5SM3o6IZLwq25LI3SBHOLC7CZ9hyU2GyCj7iyvIbWeK7ZxX5mUkYpOi
         VYKkvV83Kwt+PN6kGfGZm4gbSmMTiRcK+OS/4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=AultqCmX+6xcUO0M9h+cORitdDzmbbjmTJt55sGD8WWw91MdA89iKEQBCNd+6dHInS
         a2rs1eo1Yn/6/bhKjdo4qBW7kXzcStnoLdiLeT9WZjwfEKN8NXe9f6RkF9AYFgSKE7mA
         VVZbnXRg7prG3GkuVjQEJ6hdHtcms55v/iVaY=
Received: by 10.90.79.12 with SMTP id c12mr183854agb.51.1221994526307;
        Sun, 21 Sep 2008 03:55:26 -0700 (PDT)
Received: by 10.90.63.18 with HTTP; Sun, 21 Sep 2008 03:55:26 -0700 (PDT)
Message-ID: <a664af430809210355p62f6b848q87ed07f63a242c78@mail.gmail.com>
Date:	Sun, 21 Sep 2008 14:55:26 +0400
From:	"Dinar Temirbulatov" <dtemirbulatov@gmail.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: mmap is broken for MIPS64 n32 and o32 abis
Cc:	linux-mips@linux-mips.org
In-Reply-To: <Pine.LNX.4.55.0809191803390.29711@cliff.in.clinika.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a664af430809182331i41c9e344w83ecb2830ac24@mail.gmail.com>
	 <Pine.LNX.4.55.0809191329080.29711@cliff.in.clinika.pl>
	 <a664af430809190953k486e2012hf3a09caa50c9574a@mail.gmail.com>
	 <Pine.LNX.4.55.0809191803390.29711@cliff.in.clinika.pl>
Return-Path: <dtemirbulatov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20583
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dtemirbulatov@gmail.com
Precedence: bulk
X-list: linux-mips

hi, Maciej
I don't think it has anything to do type definition of signed or
unsigned. I think following things happened here we called mmap() from
n32 and as it is defined is the glibc for this abi the sixth parameter
should be 32-bit wide integer and we transefed this 32-bit
value(0xb6000000) in the a5(r9) register according to the mips abi,
but we loaded this value with "lui     a5,0xb600" instruction and that
resulted with 0xffffffffb6000000 in the 64-bit version of a5
register(for 32-bit it is legitimate 0xb6000000). after that on the
kernel side we have this function old_mmap() and sixth argument there
is 64-bit wide integer (off_t type) and it does not that we called
this function from 32-bit environment  and that is why there is
0xffffffffb6000000 value in the end, so 0xffffffff is trash. I think
that we need to have a separate mmap system call handler for 32-bit
abis, also we need to add mmap2 handler for n32 as we have it for o32.

thanks, Dinar.


On Fri, Sep 19, 2008 at 9:25 PM, Maciej W. Rozycki <macro@linux-mips.org> wrote:
> On Fri, 19 Sep 2008, Dinar Temirbulatov wrote:
>
>>          mmptr = (unsigned short *)mmap((void *)0, 0x1000,
>>                              PROT_READ | PROT_WRITE, MAP_SHARED,
>>                              mmh, 0xb6000000);
>
>  Ah, so it is the file offset you are concerned about.  Fair enough then.
> Obviously the non-LFS 32-bit variation has to sign-extend the offset as
> this is how the off_t type has been defined in this case, though it is
> interesting to note that the kernel treats this argument as unsigned while
> the C library API defines it as signed and there is no range checking in
> between.  Hmm...
>
>  Maciej
>
