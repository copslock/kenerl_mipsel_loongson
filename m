Received:  by oss.sgi.com id <S553724AbQK2Nel>;
	Wed, 29 Nov 2000 05:34:41 -0800
Received: from mail.netunlimited.net ([208.128.132.4]:22534 "EHLO
        mail.netunlimited.net") by oss.sgi.com with ESMTP
	id <S553685AbQK2NeY>; Wed, 29 Nov 2000 05:34:24 -0800
Received: from localhost (jesse@localhost)
	by mail.netunlimited.net (8.9.3/8.9.3) with ESMTP id IAA04527
	for <linux-mips@oss.sgi.com>; Wed, 29 Nov 2000 08:35:37 -0500
Date:   Wed, 29 Nov 2000 08:35:37 -0500 (EST)
From:   Jesse Dyson <jesse@winston-salem.com>
X-Sender: jesse@mail.netunlimited.net
To:     linux-mips@oss.sgi.com
Subject: Kernel Boot Hard Locks Indigo 2
Message-ID: <Pine.LNX.4.10.10011290832330.2804-100000@mail.netunlimited.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,
I have an Indigo 2 which I am trying to load the debian linux port (or any
port that will work actually).  I have been able to successfully configure
BOOTP,TFTP, and NFS so that the machine will boot with BOOTP (per
http://oss.sgi.com/mips/i2-howto.html).  However, after the kernel has
loaded (I assume into RAM from the image--sorry newbie), the machine hard
locks.  Any help would be greatly appreciated.  Thank you for your time.

Thanks,
Jesse Dyson
