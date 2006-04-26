Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Apr 2006 09:32:26 +0100 (BST)
Received: from pproxy.gmail.com ([64.233.166.182]:61035 "EHLO pproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S4475208AbWDZIcQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Apr 2006 09:32:16 +0100
Received: by pproxy.gmail.com with SMTP id d80so1732366pyd
        for <linux-mips@linux-mips.org>; Wed, 26 Apr 2006 01:45:29 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Fsuqc0KjzdH8YAXJgqE60OTx9VhGT81/MImT4kIir7OQKz78T9CTuar5Avk73OQzSecJiE2Sra4SrDWA8eJQ3VEAZYUyKkY5cFPsXC90HV/TY0uOwxeJMTki3b6hiA9xDECisHRRLiO+F6Jk83I0HyfXR2vtAflXz3JOti4EU4A=
Received: by 10.35.77.18 with SMTP id e18mr418056pyl;
        Wed, 26 Apr 2006 01:45:29 -0700 (PDT)
Received: by 10.35.60.20 with HTTP; Wed, 26 Apr 2006 01:45:29 -0700 (PDT)
Message-ID: <3857255c0604260145i65356e12w89c6667756cddd3c@mail.gmail.com>
Date:	Wed, 26 Apr 2006 14:15:29 +0530
From:	"Shyamal Sadanshio" <shyamal.sadanshio@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: Crosstools for MALTA MIPS in little endian
Cc:	"Nigel Stephens" <nigel@mips.com>
In-Reply-To: <4448F638.9060502@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <3857255c0604210808y1208045by3449b003b4b2ffea@mail.gmail.com>
	 <4448F638.9060502@mips.com>
Return-Path: <shyamal.sadanshio@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11204
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shyamal.sadanshio@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

I am facing boot problem with the Malta specific 2.6.12-rc6 kernel.
The kernel is not booting up on our Malta 4kc development board.
I do not see any error messages on the minicom window.

Has anyone tried this kernel since it I got this kernel after cloning
the linux-malta.git repository?
I had build this kernel with SDE cross-toolchain in little endian mode
(gcc-3.4.4).

Thanks and Regards,
Shyamal

On 4/21/06, Nigel Stephens <nigel@mips.com> wrote:
>
>
> Shyamal Sadanshio wrote:
> > Hi,
> >
> > I am come across the MALTA specific stable kernel (2.6.12-rc6)
> > available on linux-malta.git repository.
> > I have cloned this repository and would like to build it with the
> > compatible toolchain in little endian mode.
> >
> > Can anyone please let me know the toolchain specification
> > (gcc/glibc/binutils version specifcations) that have been used or can
> > be used for compiling the 2.6.12 kernel?
> >
> >
> >
>
> See http://www.linux-mips.org/wiki/Toolchains#MIPS_SDE
>
> Regards
>
> Nigel
>
