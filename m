Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4B7uvA29973
	for linux-mips-outgoing; Fri, 11 May 2001 00:56:57 -0700
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4B7utF29970
	for <linux-mips@oss.sgi.com>; Fri, 11 May 2001 00:56:55 -0700
Received: from ginger.sonytel.be (ginger.sonytel.be [10.34.16.6])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id JAA03865
	for <linux-mips@oss.sgi.com>; Fri, 11 May 2001 09:56:41 +0200 (MET DST)
Received: (from tea@localhost)
	by ginger.sonytel.be (8.9.0/8.8.6) id JAA08516
	for linux-mips@oss.sgi.com; Fri, 11 May 2001 09:56:28 +0200 (MET DST)
Date: Fri, 11 May 2001 09:56:28 +0200
From: Tom Appermont <tea@sonycom.com>
To: linux-mips@oss.sgi.com
Subject: Re: Binary compatibility break understood ?
Message-ID: <20010511095628.D8495@sonycom.com>
References: <20010505144708.A12575@paradigm.rfc822.org> <20010507163210.B2381@bacchus.dhis.org> <20010508202518.A13476@paradigm.rfc822.org> <20010508214313.A12528@bacchus.dhis.org> <20010509095955.A8392@sonycom.com> <20010509104635.D12267@paradigm.rfc822.org> <3AF934AE.38AB0089@cotw.com> <20010510110847.A2799@cyberhqz.com> <20010510162221.A1736@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <20010510162221.A1736@bacchus.dhis.org>; from ralf@oss.sgi.com on Thu, May 10, 2001 at 04:22:21PM -0300
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> > To get the new targets working correctly:
> > 	* new binutils
> > 	* new gcc built with new binutils (does the 2.95.4 branch have the
> >         changes, or only 3.0?)
> > 	* new libc built with new gcc
> > 	* rebuild gcc with the new libc
> > 
> > Am I missing anything?
> 
> The latter three steps are not necessary.

To avoid any further confusion, which then are the versions 
( & patches ) of binutils / gcc / libc needed to get a
linux mips toolchain we can use until the end of time? 

Tom
