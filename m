Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f94IgWp19940
	for linux-mips-outgoing; Thu, 4 Oct 2001 11:42:32 -0700
Received: from kuolema.infodrom.north.de (postfix@kuolema.infodrom.north.de [217.89.86.35])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f94IgTD19931
	for <linux-mips@oss.sgi.com>; Thu, 4 Oct 2001 11:42:29 -0700
Received: from finlandia.infodrom.north.de (finlandia.Infodrom.North.DE [217.89.86.34])
	by kuolema.infodrom.north.de (Postfix) with ESMTP
	id CC3674D74F; Thu,  4 Oct 2001 20:42:23 +0200 (CEST)
Received: by finlandia.infodrom.north.de (Postfix, from userid 501)
	id EE944FE47; Thu,  4 Oct 2001 20:42:22 +0200 (CEST)
Date: Thu, 4 Oct 2001 20:42:22 +0200
From: Martin Schulze <joey@finlandia.infodrom.north.de>
To: Alice Hennessy <ahennessy@mvista.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: BOOTP problem
Message-ID: <20011004204222.Z18353@finlandia.infodrom.north.de>
Reply-To: Martin Schulze <joey@infodrom.north.de>
References: <3BBCA8A8.23CA468F@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3BBCA8A8.23CA468F@mvista.com>
User-Agent: Mutt/1.3.20i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Alice Hennessy wrote:
> Hello,
> 
> Just grabbed the latest code and BOOTP doesn't work with the latest
> net/ipv4/ipconfig.c
> (it does work with the ipconfig.c from a 6/11 snapshot).   Anyone else
> having problems?

Did you add 'ip=auto' to the kernel commandline?  If not, try that.

Regards,

	Joey

-- 
Whenever you meet yourself you're in a time loop or in front of a mirror.
