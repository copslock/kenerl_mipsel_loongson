Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0E9D8W27651
	for linux-mips-outgoing; Mon, 14 Jan 2002 01:13:08 -0800
Received: from crack-ext.ab.videon.ca (crack-ext.ab.videon.ca [206.75.216.33])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0E9D5g27647
	for <linux-mips@oss.sgi.com>; Mon, 14 Jan 2002 01:13:05 -0800
Received: (qmail 9050 invoked from network); 14 Jan 2002 08:13:02 -0000
Received: from unknown (HELO wakko.deltatee.com) ([24.82.81.190]) (envelope-sender <jgg@debian.org>)
          by crack-ext.ab.videon.ca (qmail-ldap-1.03) with SMTP
          for <mdharm@momenco.com>; 14 Jan 2002 08:13:02 -0000
Received: from localhost
	([127.0.0.1] helo=wakko.deltatee.com ident=jgg)
	by wakko.deltatee.com with smtp (Exim 3.16 #1 (Debian))
	id 16Q2En-0005fE-00; Mon, 14 Jan 2002 01:13:01 -0700
Date: Mon, 14 Jan 2002 01:13:01 -0700 (MST)
From: Jason Gunthorpe <jgg@debian.org>
X-Sender: jgg@wakko.deltatee.com
To: Matthew Dharm <mdharm@momenco.com>
cc: linux-mips@oss.sgi.com
Subject: Re: MIPS64 status?
In-Reply-To: <20020113211323.A7115@momenco.com>
Message-ID: <Pine.LNX.3.96.1020114005113.14010F-100000@wakko.deltatee.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


On Sun, 13 Jan 2002, Matthew Dharm wrote:

> As I understand it, 64-bit support is really two different things:  64-bit
> data path (i.e. unsigned long long) and 64-bit addressing (for more than 4G
> of RAM).

I suppose you could say that. I think I saw someone post to this list
that they were working on a patch to enable 64 bit registers with a 32 bit
kernel.

> My understanding is that "MIPS64" generally refers to a kernel which
> supports a 64-bit data path, but we're still limited to 32-bit addressing.
> Is that correct?

The mips64 tree in CVS is one that is a 64 bit addressing capable kernel.
AFAIK the linx convention is that <foo>64 refers to addressing (which
probably impiles register width too :>)

I'm not sure what the current state of the ELF64 MIPS toolchain is.

Jason
