Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Jan 2005 03:36:07 +0000 (GMT)
Received: from web52809.mail.yahoo.com ([IPv6:::ffff:206.190.39.173]:19627
	"HELO web52809.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8224806AbVAWDgA>; Sun, 23 Jan 2005 03:36:00 +0000
Received: (qmail 6921 invoked by uid 60001); 23 Jan 2005 03:35:53 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=3FsJq2N+g00PtyUdA5BIJv3MS5i68kUD+r9F1bQTKxIKASnB/LQDbSHgVhGXsMlhhzKwHWd733dL/kHBxHNuFvv4xD97wo6V3rkNA3jKXmyEvQyAihqkC4iLFPljrJ+iX2mCSzvLUh88tkbTIH8ZccKAkyWSQyqbUq4iuFirbkM=  ;
Message-ID: <20050123033553.6917.qmail@web52809.mail.yahoo.com>
Received: from [67.161.34.62] by web52809.mail.yahoo.com via HTTP; Sat, 22 Jan 2005 19:35:53 PST
Date:	Sat, 22 Jan 2005 19:35:53 -0800 (PST)
From:	Manish Lachwani <m_lachwani@yahoo.com>
Subject: Re: [PATCH] Support for backplane on TX4927 based board
To:	"Steven J. Hill" <sjhill@realitydiluted.com>,
	Manish Lachwani <mlachwani@mvista.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
In-Reply-To: <41F2C244.1090701@realitydiluted.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <m_lachwani@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7006
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m_lachwani@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi Steve,

Thanks for applying the PCI patch. 

This patch is complete as well. This file
"arch/mips/tx4927/common/tx4927_setup.c" already
exists in CVS and this specific change below removes a
couple of lines from the file (uneeded lines). What
part of the patch is missing? 

Thanks
Manish Lachwani

--- "Steven J. Hill" <sjhill@realitydiluted.com>
wrote:

> Manish Lachwani wrote:
> > 
> > Attached patch implements support for backplane on
> TX4927 based board. Please review and/or apply
> >
> > Index:
> linux-2.6.10/arch/mips/tx4927/common/tx4927_setup.c
> >
>
===================================================================
> > ---
>
linux-2.6.10.orig/arch/mips/tx4927/common/tx4927_setup.c
> > +++
> linux-2.6.10/arch/mips/tx4927/common/tx4927_setup.c
> > @@ -129,8 +129,6 @@
> >  	return;
> >  }
> >  
> > -indent: Standard input:25: Error:Unexpected end
> of file
> > -
> >  void
> >  dump_cp0(char *key)
> >  {
> 
> Looks like the last part of your patch is missing.
> Pleae resend and I will
> go ahead and apply your other big endian patch for
> TX4927 PCI. Thanks.
> 
> -Steve
> 
> 


=====
http://www.koffee-break.com
