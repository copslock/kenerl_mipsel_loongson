Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0FEAQK20089
	for linux-mips-outgoing; Tue, 15 Jan 2002 06:10:26 -0800
Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0FEANP20086
	for <linux-mips@oss.sgi.com>; Tue, 15 Jan 2002 06:10:23 -0800
Received: from spider.cphdev.eicon.com (firewall.i-data.com [195.24.22.194]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id FAA07382
	for <linux-mips@oss.sgi.com>; Tue, 15 Jan 2002 05:05:58 -0800 (PST)
	mail_from (brian.murphy@eicon.com)
Received: from (null) ([127.0.0.1] helo=eicon.com)
	by spider.cphdev.eicon.com with esmtp (Exim 3.22 #1 (Debian))
	id 16QT9F-0004gi-00
	for <linux-mips@oss.sgi.com>; Tue, 15 Jan 2002 13:57:05 +0100
Message-ID: <3C442721.76843A70@eicon.com>
Date: Tue, 15 Jan 2002 13:57:05 +0100
From: Brian Murphy <brian.murphy@eicon.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-mips@oss.sgi.com
Subject: Re: libtool warning on redhat 7.1 native mipsel compile
References: <20020112222721.B26661@lucon.org> <Pine.GSO.3.96.1020114123630.10091C-100000@delta.ds2.pg.gda.pl> <20020114095028.C30946@lucon.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"H . J . Lu" wrote:

> I should have made myself clearer. I do have X rpms. In fact, my RedHat
> 7.1 mips port has XFree86 4.1 rpms. I just don't use them on my machine.
> I simply can't afford to put X on it. My mips box is used to track gcc
> 3.1, which breaks on Linux/mips almost every week, if not everyday. It
> takes 2 days for me bootstrap/check gcc 3.1 on that box. I need
> something simple to reproduce it.
> 
> H.J.

Is it possible for us to help? We have some machines here (Lasat
Masquerade Pro)
which have NEC VR5000 CPU's running at 266 MHz fitted with harddisk and
running
a 2.4.17 kernel. We currently have the debian mips distribution
installed on 
them. Perhaps the scripts you use to build/test gcc could be run on one
of 
these machines?

/Brian
