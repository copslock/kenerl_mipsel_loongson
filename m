Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f860PgD03123
	for linux-mips-outgoing; Wed, 5 Sep 2001 17:25:42 -0700
Received: from dea.linux-mips.net (u-59-20.karlsruhe.ipdial.viaginterkom.de [62.180.20.59])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f860Pbd03120
	for <linux-mips@oss.sgi.com>; Wed, 5 Sep 2001 17:25:37 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f860OnQ18613;
	Thu, 6 Sep 2001 02:24:49 +0200
Date: Thu, 6 Sep 2001 02:24:49 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Phil Thompson <Phil.Thompson@pace.co.uk>
Cc: "'Atsushi Nemoto'" <nemoto@toshiba-tops.co.jp>, linux-mips@oss.sgi.com
Subject: Re: Signal 11 on Process Termination - Update
Message-ID: <20010906022449.A18605@dea.linux-mips.net>
References: <54045BFDAD47D5118A850002A5095CC30AC577@exchange1.cam.pace.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <54045BFDAD47D5118A850002A5095CC30AC577@exchange1.cam.pace.co.uk>; from Phil.Thompson@pace.co.uk on Wed, Sep 05, 2001 at 11:07:58AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Sep 05, 2001 at 11:07:58AM +0100, Phil Thompson wrote:

> This fixed the problem - many thanks.
> 
> Ralf - is this patch going to be applied (the current CVS seems unusable
> without it)?

I've applied a different patch to CVS.

I've got other different problems with the current CVS; the 32-bit kernel
is very unreliable for me on 32-bit machines.

  Ralf
