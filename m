Received:  by oss.sgi.com id <S553962AbRBUOsY>;
	Wed, 21 Feb 2001 06:48:24 -0800
Received: from mail.sonytel.be ([193.74.243.200]:17536 "EHLO mail.sonytel.be")
	by oss.sgi.com with ESMTP id <S553959AbRBUOsE>;
	Wed, 21 Feb 2001 06:48:04 -0800
Received: from ginger.sonytel.be (ginger.sonytel.be [10.34.16.6])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id PAA25983
	for <linux-mips@oss.sgi.com>; Wed, 21 Feb 2001 15:48:00 +0100 (MET)
Received: (from tea@localhost)
	by ginger.sonytel.be (8.9.0/8.8.6) id PAA18306
	for linux-mips@oss.sgi.com; Wed, 21 Feb 2001 15:48:00 +0100 (MET)
Date:   Wed, 21 Feb 2001 15:48:00 +0100
From:   Tom Appermont <tea@sonycom.com>
To:     linux-mips@oss.sgi.com
Subject: gcc 2.95.3
Message-ID: <20010221154800.C12301@ginger.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Howdy,

This is just to report a problem I was having with gcc 2.95.3,
on an R5000 LE target (ddb5074). I got the compiler and binutils 
from ftp.ds2.pg.gda.pl (thank you Maciej ;).

For some reason (which I don't know), the code compiled with
gcc 2.95.3-14 fails to deal correctly with tlb exceptions on my
target. One obvious result is that page faults do not occur. 
Compiling with egcs 1.1.2 made this problem disappear. I spent 
many days trying to pin down what went wrong where, needless to 
say that it has been a painful introduction to Linux/MIPS... 


Cheerio,

Tom


-- 
................................................................
Tom Appermont                       SDCE
mailto: tom.appermont@sonycom.com   Sint Stevens Woluwestraat 55
tel: +32 2 7248620                  1130 Brussel
fax: +32 2 7262686                  Belgium
