Received:  by oss.sgi.com id <S553850AbQKHM6j>;
	Wed, 8 Nov 2000 04:58:39 -0800
Received: from u-203.karlsruhe.ipdial.viaginterkom.de ([62.180.21.203]:40968
        "EHLO u-203.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553824AbQKHM6Q>; Wed, 8 Nov 2000 04:58:16 -0800
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869085AbQKHEB6>;
        Wed, 8 Nov 2000 05:01:58 +0100
Date:   Wed, 8 Nov 2000 05:01:58 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Ian Chilton <ian@ichilton.co.uk>
Cc:     linux-mips@oss.sgi.com, lfs-discuss@linuxfromscratch.org
Subject: Re: User/Group Problem
Message-ID: <20001108050158.B12999@bacchus.dhis.org>
References: <20001107110610.A8074@woody.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001107110610.A8074@woody.ichilton.co.uk>; from mailinglist@ichilton.co.uk on Tue, Nov 07, 2000 at 11:06:10AM +0000
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Nov 07, 2000 at 11:06:10AM +0000, Ian Chilton wrote:

> I am building a Linux system on an SGI I2 (MIPS) with glibc 2.2
> 
> I am having the following problem....any ideas?
> 
> bash-2.04# chown root test.c 
> chown: root: invalid user
> 
> bash-2.04# chgrp root test.c 
> chgrp: invalid group name `root'

Two possible reasons:

 - your /etc/nsswitch.conf is broken
 - your chown / chgrp binaries are statically linked.  In that case nss
   won't work on MIPS until it's fixed ...

  Ralf
