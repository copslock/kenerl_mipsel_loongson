Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jul 2004 16:58:48 +0100 (BST)
Received: from smtp.vmb-service.ru ([IPv6:::ffff:80.73.198.33]:49131 "EHLO
	smtp.vmb-service.ru") by linux-mips.org with ESMTP
	id <S8225219AbUGTP6o>; Tue, 20 Jul 2004 16:58:44 +0100
Received: from office.vmb-service.ru ([80.73.192.47]:30725 "EHLO ALEC")
	by Altair with ESMTP id <S1152055AbUGTP6f>;
	Tue, 20 Jul 2004 19:58:35 +0400
Reply-To: <a.voropay@vmb-service.ru>
From: "Alexander Voropay" <a.voropay@vmb-service.ru>
To: "'Ralf Baechle'" <ralf@linux-mips.org>
Cc: <linux-mips@linux-mips.org>
Subject: RE: Howto run Linux on ACER PICA 61
Date: Tue, 20 Jul 2004 19:59:52 +0400
Organization: VMB-Service
Message-ID: <0ab701c46e72$97b49d60$0200000a@ALEC>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <0aa601c46e63$f3ddbef0$0200000a@ALEC>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Importance: Normal
Return-Path: <a.voropay@vmb-service.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5523
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.voropay@vmb-service.ru
Precedence: bulk
X-list: linux-mips

Hi!

>  Unfortunately, the build script does not provide a selection for the
SCSI driver for
>the ACER PICA 

 It seems, this is a typo in Kconfigs... The JAZZ machine name is a
"MACH_JAZZ",
not a  "MIPS_JAZZ"


[root@monitor linux]# find . -name "Kconfig" | xargs grep MIPS_JAZZ
./drivers/net/Kconfig:config MIPS_JAZZ_SONIC
./drivers/net/Kconfig:  depends on NET_ETHERNET && MIPS_JAZZ
./drivers/scsi/Kconfig: depends on MIPS_JAZZ && SCSI
./linux/drivers/net/Kconfig:config MIPS_JAZZ_SONIC
./linux/drivers/net/Kconfig:    depends on NET_ETHERNET && MIPS_JAZZ
./linux/drivers/scsi/Kconfig:   depends on MIPS_JAZZ && SCSI


--
-=AV=-
