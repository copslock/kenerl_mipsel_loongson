Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8JGgPw32023
	for linux-mips-outgoing; Wed, 19 Sep 2001 09:42:25 -0700
Received: from dea.linux-mips.net (f-248-188.frankfurt.ipdial.viaginterkom.de [62.180.188.248])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8JGgMe32020
	for <linux-mips@oss.sgi.com>; Wed, 19 Sep 2001 09:42:23 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f8JGfNA06014;
	Wed, 19 Sep 2001 18:41:23 +0200
Date: Wed, 19 Sep 2001 18:41:23 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Phil Thompson <Phil.Thompson@pace.co.uk>
Cc: "'Zhang Fuxin'" <fxzhang@ict.ac.cn>, linux-mips@oss.sgi.com
Subject: Re: Re: 8259 spurious interrupt (IRQ1,IRQ7,IRQ12..)
Message-ID: <20010919184123.A5849@dea.linux-mips.net>
References: <54045BFDAD47D5118A850002A5095CC30AC596@exchange1.cam.pace.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <54045BFDAD47D5118A850002A5095CC30AC596@exchange1.cam.pace.co.uk>; from Phil.Thompson@pace.co.uk on Wed, Sep 19, 2001 at 11:27:14AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Sep 19, 2001 at 11:27:14AM +0100, Phil Thompson wrote:

> Make sure you read the section in the P6032 manual "Tips on programming
> south bridge interrupt controller(s)" - page 31. I don't see how the 8259
> code that's part of the MIPS tree can ever be used without changes.

Can you elaborate?  It's actually being used without problems.

  Ralf
