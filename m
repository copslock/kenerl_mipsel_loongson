Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Apr 2004 10:43:55 +0100 (BST)
Received: from smtp220.tiscali.dk ([IPv6:::ffff:62.79.79.114]:58121 "EHLO
	smtp220.tiscali.dk") by linux-mips.org with ESMTP
	id <S8225250AbUDTJny>; Tue, 20 Apr 2004 10:43:54 +0100
Received: from cpmail.dk.tiscali.com (mail.tiscali.dk [212.54.64.159])
	by smtp220.tiscali.dk (8.12.11/8.12.11) with ESMTP id i3K9hq75009390
	for <linux-mips@linux-mips.org>; Tue, 20 Apr 2004 11:43:52 +0200 (CEST)
	(envelope-from jh@hansen-telecom.dk)
Received: from jorg (62.79.30.226) by cpmail.dk.tiscali.com (6.7.018)
        id 404B99FB0087ECF2 for linux-mips@linux-mips.org; Tue, 20 Apr 2004 11:43:52 +0200
From: =?iso-8859-1?Q?J=F8rg_Ulrich_Hansen?= <jh@hansen-telecom.dk>
To: "Linux-Mips" <linux-mips@linux-mips.org>
Subject: Framebuffer for au1100
Date: Tue, 20 Apr 2004 11:43:25 +0200
Message-ID: <EIEHIDHKGJLNEPLOGOPOKEIACGAA.jh@hansen-telecom.dk>
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
X-archive-position: 4812
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jh@hansen-telecom.dk
Precedence: bulk
X-list: linux-mips

Hi

I was trying to make use of framebuffer for a db1100 board. It looks like
au1100fb.c is not updated to kernel 2.6. It makes use of some structs and
procedures in fbcon that has been removed in 2.6.
Any ideas what is needed to get au1100fb.c to work in 2.6?
Has someone 2.6 to work with frambuffers on au1100?
I think that au1100fb is written for pb1100 that has an epson lcd controller
fitted.
Does that mean that nothing has been done for the internal lcd controller?


regards Jorg
