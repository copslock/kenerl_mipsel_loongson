Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7E8wxU03336
	for linux-mips-outgoing; Tue, 14 Aug 2001 01:58:59 -0700
Received: from dea.waldorf-gmbh.de (u-198-10.karlsruhe.ipdial.viaginterkom.de [62.180.10.198])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7E8wpj03331
	for <linux-mips@oss.sgi.com>; Tue, 14 Aug 2001 01:58:52 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f7E7xVF06195;
	Tue, 14 Aug 2001 09:59:31 +0200
Date: Tue, 14 Aug 2001 09:59:31 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Keith M Wesolowski <wesolows@foobazco.org>
Cc: "Salisbury, Roger" <Roger.Salisbury@team.telstra.com>,
   "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Re: FW: indigo2 kernel build failures
Message-ID: <20010814095931.C5928@bacchus.dhis.org>
References: <C1CCF0351229D311BBEB0008C75B9A8A02CAFACC@ntmsg0080.corpmail.telstra.com.au> <20010812220210.D24560@foobazco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010812220210.D24560@foobazco.org>; from wesolows@foobazco.org on Sun, Aug 12, 2001 at 10:02:10PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Aug 12, 2001 at 10:02:10PM -0700, Keith M Wesolowski wrote:

> Nope.  Even if it did the kernel wouldn't care.  Build gcc on a peecee
> sometime and you'll see "i386-unknown-linux-gnu" and it will work as
> well as gcc ever does.  Have some fun with it - maybe
> "mips-fuckmeinthegoatass-linux-gnu" (STR) for your amusement or
> "mips-notintel-linux-gnu" to make a statement.  It won't affect
> anything.  Leave off the -gnu, though, and configure will kindly add
> it back on, reminding you that it is, in fact, GNU/Linux, dammit.

Since the manufacturer part of the name quadruple is a entirely useless
just like the -gnu suffix on Linux I usually strip it off.  That's why
the kernel by default uses mips-linux, mipsel-linux, mips64-linux or
mips64el-linux by default and I'd like others to do the same to avoid
the unnecessary pleasure of editing makefiles that know about crosscompiler
configuration names.

  Ralf
