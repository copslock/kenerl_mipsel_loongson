Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Apr 2004 08:45:19 +0100 (BST)
Received: from smtp130.tiscali.dk ([IPv6:::ffff:62.79.79.112]:47881 "EHLO
	smtp130.tiscali.dk") by linux-mips.org with ESMTP
	id <S8225245AbUDTHpS>; Tue, 20 Apr 2004 08:45:18 +0100
Received: from cpmail.dk.tiscali.com (mail.tiscali.dk [212.54.64.159])
	by smtp130.tiscali.dk (8.12.11/8.12.11) with ESMTP id i3K7jFTD073776
	for <linux-mips@linux-mips.org>; Tue, 20 Apr 2004 09:45:15 +0200 (CEST)
	(envelope-from jh@hansen-telecom.dk)
Received: from jorg (62.79.30.226) by cpmail.dk.tiscali.com (6.7.018)
        id 407273BB004759F8 for linux-mips@linux-mips.org; Tue, 20 Apr 2004 09:45:14 +0200
From: =?iso-8859-1?Q?J=F8rg_Ulrich_Hansen?= <jh@hansen-telecom.dk>
To: "Linux-Mips" <linux-mips@linux-mips.org>
Subject: Re: building mips cross compiler -- an error when compiling glibc
Date: Tue, 20 Apr 2004 09:44:47 +0200
Message-ID: <EIEHIDHKGJLNEPLOGOPOOEHPCGAA.jh@hansen-telecom.dk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Return-Path: <jh@hansen-telecom.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4811
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jh@hansen-telecom.dk
Precedence: bulk
X-list: linux-mips


a good choice would be www.kegel.com/crosstool, that worked for me.

If you are doing embedded and want to use uclibc on your target then uclibc
toolchain http://www.uclibc.org/toolchains.html is a good choice.

Both take care of any patches needed.

That has also worked for me.

Jorg
