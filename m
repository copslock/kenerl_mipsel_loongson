Received:  by oss.sgi.com id <S553672AbRCMUgb>;
	Tue, 13 Mar 2001 12:36:31 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:39665 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553661AbRCMUgO>;
	Tue, 13 Mar 2001 12:36:14 -0800
Received: from mvista.com (IDENT:ppopov@zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f2DKVN318608
	for <linux-mips@oss.sgi.com>; Tue, 13 Mar 2001 12:31:24 -0800
Message-ID: <3AAE846E.916F16BE@mvista.com>
Date:   Tue, 13 Mar 2001 12:34:54 -0800
From:   Pete Popov <ppopov@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-14 i586)
X-Accept-Language: en, bg
MIME-Version: 1.0
To:     "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: rdev
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Can you "rdev vmlinux /dev/hda1" a mips kernel and have it work (have
the kernel recognize that its root fs is /dev/hda1 without passing any
command line arguments)?  I tried it and it doesn't seem to work, unless
you have to specify offset or other options that I don't know about.

Pete
