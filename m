Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2RI6j804661
	for linux-mips-outgoing; Tue, 27 Mar 2001 10:06:45 -0800
Received: from pobox.sibyte.com (pobox.sibyte.com [208.12.96.20])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2RI6jM04658
	for <linux-mips@oss.sgi.com>; Tue, 27 Mar 2001 10:06:45 -0800
Received: from postal.sibyte.com (moat.sibyte.com [208.12.96.21])
	by pobox.sibyte.com (Postfix) with SMTP
	id 60402205FE; Tue, 27 Mar 2001 10:06:39 -0800 (PST)
Received: from SMTP agent by mail gateway 
 Tue, 27 Mar 2001 09:59:29 -0800
Received: from plugh.sibyte.com (plugh.sibyte.com [10.21.64.158])
	by postal.sibyte.com (Postfix) with ESMTP
	id AFA6F1595F; Tue, 27 Mar 2001 10:06:39 -0800 (PST)
Received: by plugh.sibyte.com (Postfix, from userid 61017)
	id 087A5686D; Tue, 27 Mar 2001 10:09:00 -0800 (PST)
From: Justin Carlson <carlson@sibyte.com>
Reply-To: carlson@sibyte.com
Organization: Sibyte
To: Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
Subject: Re: loop stuff
Date: Tue, 27 Mar 2001 10:06:46 -0800
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain
References: <20010327200219.B32706@paradigm.rfc822.org>
In-Reply-To: <20010327200219.B32706@paradigm.rfc822.org>
MIME-Version: 1.0
Message-Id: <0103271008591B.00779@plugh.sibyte.com>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 27 Mar 2001, Florian Lohoff wrote:
> Hi,
> does anyone know if the 2.4.2 kernel does support loop devices - I mean
> in the sense of - "It works" - I do have problems with processes like
> mke2fs getting hung while accessing the loop without any error message.
> 
> I am not running 2.4.x on any other platform so i cant verify ...
> 

This probably isn't a MIPS specific problem.  It's supposed to be fixed by some
of Jens Axboe's latest stuff, as well as in the 2.4.2ac series on kernel.org;
I'd guess it will be fixed when 2.4.3 is released and imported to
cvs@oss.sgi.com.

-Justin
