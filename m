Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f94IuVY20261
	for linux-mips-outgoing; Thu, 4 Oct 2001 11:56:31 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f94IuSD20254
	for <linux-mips@oss.sgi.com>; Thu, 4 Oct 2001 11:56:28 -0700
Received: from mvista.com (IDENT:ahennessy@penelope.mvista.com [10.0.0.122])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f94IwrB14224;
	Thu, 4 Oct 2001 11:58:53 -0700
Message-ID: <3BBCB2D1.C160949B@mvista.com>
Date: Thu, 04 Oct 2001 12:04:49 -0700
From: Alice Hennessy <ahennessy@mvista.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Schulze <joey@infodrom.north.de>
CC: linux-mips@oss.sgi.com
Subject: Re: BOOTP problem
References: <3BBCA8A8.23CA468F@mvista.com> <20011004204222.Z18353@finlandia.infodrom.north.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Martin Schulze wrote:

> Alice Hennessy wrote:
> > Hello,
> >
> > Just grabbed the latest code and BOOTP doesn't work with the latest
> > net/ipv4/ipconfig.c
> > (it does work with the ipconfig.c from a 6/11 snapshot).   Anyone else
> > having problems?
>
> Did you add 'ip=auto' to the kernel commandline?  If not, try that.
>
> Regards,
>
>         Joey
>
> --
> Whenever you meet yourself you're in a time loop or in front of a mirror.

Thanks - that did it.

Alice
