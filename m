Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7A1b8B00592
	for linux-mips-outgoing; Thu, 9 Aug 2001 18:37:08 -0700
Received: from tennyson.netexpress.net (IDENT:root@tennyson.netexpress.net [64.22.192.12])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7A1b6V00575
	for <linux-mips@oss.sgi.com>; Thu, 9 Aug 2001 18:37:06 -0700
Received: from localhost (vorlon@localhost)
	by tennyson.netexpress.net (8.9.3/8.9.3) with ESMTP id UAA06201;
	Thu, 9 Aug 2001 20:36:31 -0500
X-Authentication-Warning: tennyson.netexpress.net: vorlon owned process doing -bs
Date: Thu, 9 Aug 2001 20:36:31 -0500 (CDT)
From: Steve Langasek <vorlon@netexpress.net>
To: "Salisbury, Roger" <Roger.Salisbury@team.telstra.com>
cc: "'<linux-mips@oss.sgi.com>'" <linux-mips@oss.sgi.com>
Subject: Re: indigo2 kernel build failures
In-Reply-To: <C1CCF0351229D311BBEB0008C75B9A8A02CAFACA@ntmsg0080.corpmail.telstra.com.au>
Message-ID: <Pine.LNX.4.30.0108092030440.6191-100000@tennyson.netexpress.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 10 Aug 2001, Salisbury, Roger wrote:

> Keith / Ralf  / All

> I just wondering if  the UNKNOW  aspect "mips-unknown-linux-gnu" of
> building packages has some detrimental affect
> on the success of building a kernel.
> IE
> The machine status isn't detected properly.

Er, 'mips-unknown-linux-gnu' /is/ the proper machine type.

$ uname -a
Linux quetzcoatl 2.4.1 #1 Sat Feb 10 23:24:40 CST 2001 alpha unknown
$ /usr/share/misc/config.guess
alphapca56-unknown-linux-gnu
$

Results are similar on all other Linux platforms except for x86 machines,
IIRC, where 'unknown' is replaced with 'pc'.

Steve Langasek
postmodern programmer
