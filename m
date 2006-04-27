Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Apr 2006 11:32:23 +0100 (BST)
Received: from pproxy.gmail.com ([64.233.166.179]:62849 "EHLO pproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133500AbWD0KcO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Apr 2006 11:32:14 +0100
Received: by pproxy.gmail.com with SMTP id d80so2088954pyd
        for <linux-mips@linux-mips.org>; Thu, 27 Apr 2006 03:32:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jwaiPWlkyMtwJaxMXJ1IEx3iEli4IgXQnPV3S+4xxawiWviTivTn9zmaChsEF+V5xz1yKZkwKFBYOJ7M0sUYqR2T7L748ykbvqh2eOg63d4kOfizGW32Mzx05wsUV8NRlr/GidKnJdkOBE/JVT+6kee/rO9r09cMZ7imG9VpXKM=
Received: by 10.35.119.11 with SMTP id w11mr3351414pym;
        Thu, 27 Apr 2006 03:32:13 -0700 (PDT)
Received: by 10.35.60.20 with HTTP; Thu, 27 Apr 2006 03:32:13 -0700 (PDT)
Message-ID: <3857255c0604270332p333c182ft3022b5d851178582@mail.gmail.com>
Date:	Thu, 27 Apr 2006 16:02:13 +0530
From:	"Shyamal Sadanshio" <shyamal.sadanshio@gmail.com>
To:	"Kishore K" <hellokishore@gmail.com>
Subject: Re: Crosstools for MALTA MIPS in little endian
Cc:	"Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	"Nigel Stephens" <nigel@mips.com>
In-Reply-To: <f07e6e0604262259x3cc0893ch8a64b6cc41c34e9b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <3857255c0604210808y1208045by3449b003b4b2ffea@mail.gmail.com>
	 <4448F638.9060502@mips.com>
	 <3857255c0604260145i65356e12w89c6667756cddd3c@mail.gmail.com>
	 <20060426221254.GA21670@linux-mips.org>
	 <20060426221823.GC21670@linux-mips.org>
	 <f07e6e0604262259x3cc0893ch8a64b6cc41c34e9b@mail.gmail.com>
Return-Path: <shyamal.sadanshio@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11223
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shyamal.sadanshio@gmail.com
Precedence: bulk
X-list: linux-mips

Hello Kishore,

Following the history of "problem with MALTA thread", you had
mentioned that you will try with 2.16 binutils. Have you tried with
2.16 version?
Regarding 2.6.12 kernel version, it is put under stable MALTA git
repository so most likely it could have been validated for MALTA
platform.

Regarding pci.c file of 2.6.10 version, Can you please pass me that
file so I will just try directly in my 2.6.12 kernel and see if it
works?

Thanks and Regards,
Shyamal

On 4/27/06, Kishore K <hellokishore@gmail.com> wrote:
> On 4/27/06, Ralf Baechle <ralf@linux-mips.org> wrote:
> >
> > On Wed, Apr 26, 2006 at 11:12:54PM +0100, Ralf Baechle wrote:
> >
> > > In case you're using the default configuration file, it's set to
> > > MIPS32R1 but the 4Kc is an R1 processor.  Are you sure you really have
> a
> > > 4Kc and not a 4Kec?  The latter is an R2 processor.
> >
> > Argh.  I meant:
> >
> > In case you're using the default configuration file, it's set to
> > MIPS32R2 but the 4Kc is an R1 processor.  Are you sure you really have a
> > 4Kc and not a 4Kec?  The latter is an R2 processor.
> >
> >
> >   Ralf
>
>
> I configured the kernel as required for 4Kc, but could not bring up the
> board. The configuration file is enclosed along with this mail (configured
> for big endian). As I mentioned in the other thread, the board comes up,
> when I replace arch/mips/mips-boards/generic/pci.c file in 2.6.16 kernel
> with the file from 2.6.10 with the appropriate changes required, to
> pci.cfile. But, I am not sure, whether my approach is correct and what
> is going
> wrong with 2.6.16 kernel. Currently, I am looking into it. If any of you
> have idea, please let me know.
>
> thanks,
> --kishore
>
>
