Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jul 2004 11:17:27 +0100 (BST)
Received: from smtp.vmb-service.ru ([IPv6:::ffff:80.73.198.33]:42664 "EHLO
	smtp.vmb-service.ru") by linux-mips.org with ESMTP
	id <S8226040AbUGFKRW>; Tue, 6 Jul 2004 11:17:22 +0100
Received: from office.vmb-service.ru ([80.73.192.47]:4107 "EHLO ALEC")
	by Altair with ESMTP id <S1164051AbUGFKRJ>;
	Tue, 6 Jul 2004 14:17:09 +0400
Reply-To: <a.voropay@vmb-service.ru>
From: "Alexander Voropay" <a.voropay@vmb-service.ru>
To: "'Thomas Kunze'" <thomas.kunze@xmail.net>
Cc: <linux-mips@linux-mips.org>
Subject: RE: Linux on SNI RM300E ?
Date: Tue, 6 Jul 2004 14:18:01 +0400
Organization: VMB-Service
Message-ID: <03a001c46342$84ce7210$0200000a@ALEC>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <1089105260.40ea6d6cf2f9c@www.x-mail.net>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Importance: Normal
Return-Path: <a.voropay@vmb-service.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5404
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.voropay@vmb-service.ru
Precedence: bulk
X-list: linux-mips



>i've downloaded the arcdiag-0.2 and served it via tftp. but the RM300E
don't like that file.
>it only says "Bad magic number". what does this mean
(little/bigendian)? 

>the same error-message appears when the to load mipsel boot-images.

 Do you have an originas OS (SINIX ?) supplied with this server ?
Try a `file` GNU utility:
$ file <ANY_BINARIES_FROM_THE_ORIGINAL_OS>
or
$ file <KERNEL_IMAGE_FROM_THE_ORIGINAL_OS>

 Some modern loaders requires ELF binaries (not COFF) so you should
know a full binary file format to load (ELF/COFF/little/bigendian).


--
-=AV=-
