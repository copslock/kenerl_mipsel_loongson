Received:  by oss.sgi.com id <S553763AbRCONRf>;
	Thu, 15 Mar 2001 05:17:35 -0800
Received: from mail.sonytel.be ([193.74.243.200]:65521 "EHLO mail.sonytel.be")
	by oss.sgi.com with ESMTP id <S553753AbRCONRR>;
	Thu, 15 Mar 2001 05:17:17 -0800
Received: from ginger.sonytel.be (ginger.sonytel.be [10.34.16.6])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id OAA13731
	for <linux-mips@oss.sgi.com>; Thu, 15 Mar 2001 14:16:59 +0100 (MET)
Received: (from tea@localhost)
	by ginger.sonytel.be (8.9.0/8.8.6) id OAA05479
	for linux-mips@oss.sgi.com; Thu, 15 Mar 2001 14:16:59 +0100 (MET)
Date:   Thu, 15 Mar 2001 14:16:58 +0100
From:   Tom Appermont <tea@sonycom.com>
To:     linux-mips@oss.sgi.com
Subject: size of ioctl 
Message-ID: <20010315141658.A914@ginger.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Howdy,

Can anybody tell me why the size of ioctl messages is limited 
to 256 bytes on mips:

include/asm-mips/ioctl.h:

...

/*
 * We to additionally limit parameters to a maximum 255 bytes.
 */
#define _IOC_SLMASK     0xff

...


I would like to see this changed because the PCMCIA software 
(cardmgr <-> driver services) needs to pass ioctl messages 
around that are a lot bigger than 256 bytes. 

Greetz,

Tom
