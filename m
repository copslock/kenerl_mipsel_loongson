Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2006 17:06:01 +0000 (GMT)
Received: from uproxy.gmail.com ([66.249.92.206]:5248 "EHLO uproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133509AbWAPRFo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Jan 2006 17:05:44 +0000
Received: by uproxy.gmail.com with SMTP id u40so710688ugc
        for <linux-mips@linux-mips.org>; Mon, 16 Jan 2006 09:09:14 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z7otpLGytPGl7nad/q1/Sqf/1Ryj/EcJv72QuRon9900XlqUeLFKNXGCpKFFAcBk4bj+KJBcrmomSZytY0Jew3vx3Bly20t9PWN3Uy+Z+eq2wB1DH3p1FoJ2OkxJTxn32zwl4KKXoYWTRn6hL5O8jGLSPqEPx5fjaqdpt81/iaY=
Received: by 10.49.11.2 with SMTP id o2mr244268nfi;
        Mon, 16 Jan 2006 09:09:14 -0800 (PST)
Received: by 10.48.225.20 with HTTP; Mon, 16 Jan 2006 09:09:14 -0800 (PST)
Message-ID: <c58a7a270601160909x540ef0ddn3f3772ed8a3b5fbe@mail.gmail.com>
Date:	Mon, 16 Jan 2006 17:09:14 +0000
From:	Alex Gonzalez <langabe@gmail.com>
To:	Brett Foster <fosterb@uoguelph.ca>
Subject: Re: Setting gp on pic code
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <43CB8D89.6070308@uoguelph.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <c58a7a270601160204h41e5dca7pa9c26578b6b29f6f@mail.gmail.com>
	 <43CB8D89.6070308@uoguelph.ca>
Return-Path: <langabe@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9906
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: langabe@gmail.com
Precedence: bulk
X-list: linux-mips

Thanks, that works.

Just for completeness, it needed to be addiu instead of ori as follows:

    lui     $28,%HI(_gp)
    addiu   $28,%LO(_gp)

because %LO is a signed 16 bit number.

Alex

On 1/16/06, Brett Foster <fosterb@uoguelph.ca> wrote:
> Alex Gonzalez wrote:
>
> >Hi,
> >
> >I am trying to set the gp register on pic code as follows:
> >
> >"la gp,_gp"
> >
> >Disassembling the resulting code,
> >
> >"lw gp,0(gp)"
> >
> >
> Yes, this is normal... Use the following to set up the GP:
>         //init GP
>         lui     gp,%HI(_gp)
>         ori     gp,%LO(_gp)
>
