Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Nov 2004 10:37:55 +0000 (GMT)
Received: from mail.romat.com ([IPv6:::ffff:212.143.245.3]:6416 "EHLO
	mail.romat.com") by linux-mips.org with ESMTP id <S8225197AbUKLKhv>;
	Fri, 12 Nov 2004 10:37:51 +0000
Received: from localhost (localhost.lan [127.0.0.1])
	by mail.romat.com (Postfix) with ESMTP id 5579EEB2AB
	for <linux-mips@linux-mips.org>; Fri, 12 Nov 2004 12:37:45 +0200 (IST)
Received: from mail.romat.com ([127.0.0.1])
 by localhost (mail.romat.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 17773-07 for <linux-mips@linux-mips.org>;
 Fri, 12 Nov 2004 12:37:42 +0200 (IST)
Received: from gilad (unknown [192.168.1.167])
	by mail.romat.com (Postfix) with SMTP id 1A1B9EB2A9
	for <linux-mips@linux-mips.org>; Fri, 12 Nov 2004 12:37:42 +0200 (IST)
Message-ID: <095c01c4c8a3$bd9e0210$a701a8c0@lan>
From: "Gilad Rom" <gilad@romat.com>
To: <linux-mips@linux-mips.org>
Subject: GPIO on the Au1500
Date: Fri, 12 Nov 2004 12:38:25 +0200
Organization: Romat Telecom
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="windows-1255";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Virus-Scanned: by amavisd-new at romat.com
Return-Path: <gilad@romat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6313
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gilad@romat.com
Precedence: bulk
X-list: linux-mips

Hello,

I am trying to use the au1000_gpio driver, but I'm a little
clueless as to how it is meant to be used. Can I use the GPIO
ioctl's from a userland program, or must I write a kernel module?

Thank you,
Gilad Rom
Romat Telecom
