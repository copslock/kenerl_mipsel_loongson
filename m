Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jun 2003 00:50:43 +0100 (BST)
Received: from mail.ocs.com.au ([IPv6:::ffff:203.34.97.2]:31749 "HELO
	mail.ocs.com.au") by linux-mips.org with SMTP id <S8225229AbTFBXul>;
	Tue, 3 Jun 2003 00:50:41 +0100
Received: (qmail 445 invoked from network); 2 Jun 2003 23:50:32 -0000
Received: from ocs3.intra.ocs.com.au (192.168.255.3)
  by mail.ocs.com.au with SMTP; 2 Jun 2003 23:50:32 -0000
Received: by ocs3.intra.ocs.com.au (Postfix, from userid 16331)
	id 2833CD8F46; Tue,  3 Jun 2003 09:50:31 +1000 (EST)
Received: from ocs3.intra.ocs.com.au (localhost [127.0.0.1])
	by ocs3.intra.ocs.com.au (Postfix) with ESMTP
	id 257F391336; Tue,  3 Jun 2003 09:50:31 +1000 (EST)
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: ilya@theIlya.com
Cc: linux-mips@linux-mips.org
Subject: Re: Yet another fix 
In-reply-to: Your message of "Mon, 02 Jun 2003 07:30:23 MST."
             <20030602143022.GK3035@gateway.total-knowledge.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 03 Jun 2003 09:50:26 +1000
Message-ID: <11027.1054597826@ocs3.intra.ocs.com.au>
Return-Path: <kaos@sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2503
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaos@sgi.com
Precedence: bulk
X-list: linux-mips

On Mon, 2 Jun 2003 07:30:23 -0700, 
ilya@theIlya.com wrote:
>For starters, I'm talking about 2.5.51 here.

Sorry,  thought you were talking about 2.4 kernels.

>Secondly, what does register_ioctl32_conversion have to do with
>emulating 32bit modutils?

See above, I thought this was 2.4.

>Code in quesion is this:
>int register_ioctl32_conversion(unsigned int cmd, int (*handler)(unsigned i=
>nt, unsigned int, unsigned long, ...))
>{
>	int i;
>	if (!additional_ioctls) {
>		additional_ioctls =3D module_map(PAGE_SIZE);
>		if (!additional_ioctls)
>			return -ENOMEM;
>		memset(additional_ioctls, 0, PAGE_SIZE);
>	}

I cannot find register_ioctl32_conversion in 2.5.51.

>As far as I can tell, There is nothing that prevents us from
>replacing module_map with vmalloc, or even get_free_pages,
>but I am not sure. There must be some reason, why it is there :)
>Ralf, it's question for you.

Without seeing the code that uses register_ioctl32_conversion (it is
not in Linus's kernel), I would be guessing.  But I suspect that you
are right, it should use vmalloc.
