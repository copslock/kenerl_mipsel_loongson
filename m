Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jul 2004 15:14:04 +0100 (BST)
Received: from smtp.vmb-service.ru ([IPv6:::ffff:80.73.198.33]:25039 "EHLO
	smtp.vmb-service.ru") by linux-mips.org with ESMTP
	id <S8225219AbUGTON7>; Tue, 20 Jul 2004 15:13:59 +0100
Received: from office.vmb-service.ru ([80.73.192.47]:21771 "EHLO ALEC")
	by Altair with ESMTP id <S1158818AbUGTONr>;
	Tue, 20 Jul 2004 18:13:47 +0400
Reply-To: <a.voropay@vmb-service.ru>
From: "Alexander Voropay" <a.voropay@vmb-service.ru>
To: "'Ralf Baechle'" <ralf@linux-mips.org>
Cc: <linux-mips@linux-mips.org>
Subject: RE: Howto run Linux on ACER PICA 61
Date: Tue, 20 Jul 2004 18:15:04 +0400
Organization: VMB-Service
Message-ID: <0aa601c46e63$f3ddbef0$0200000a@ALEC>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <20040622193839.GA7082@linux-mips.org>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Importance: Normal
Return-Path: <a.voropay@vmb-service.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5520
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.voropay@vmb-service.ru
Precedence: bulk
X-list: linux-mips

Hi!

>Linux has code for this system but it's suffering from severe bitrot.
>I still have the documents here so I could help you a bit if you were
willing to
>resurrect the kernel - which should be relativly easy, also due to the
>system's similarity to another, somewhat better supported system,
>the Olivetti M700-10.

  I'm trying to cross-compile a kernel from the linux-mips CVS.

  Unfortunately, the build script does not provide a selection for the
SCSI driver for the ACER PICA  (/linux/drivers/scsi/NCR53C9x.h ??)
and SONIC DP83932 Ethernet controller.


--
-=AV=-
