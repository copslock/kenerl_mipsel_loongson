Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Oct 2004 11:01:08 +0100 (BST)
Received: from smtp.vmb-service.ru ([IPv6:::ffff:80.73.198.33]:64945 "EHLO
	smtp.vmb-service.ru") by linux-mips.org with ESMTP
	id <S8225203AbUJYKBE>; Mon, 25 Oct 2004 11:01:04 +0100
Received: from PIX-NAT.vmb-service.ru ([80.73.192.74]:54136 "EHLO alec")
	by Altair with ESMTP id <S1159892AbUJYKAr> convert rfc822-to-8bit;
	Mon, 25 Oct 2004 14:00:47 +0400
Reply-To: <a.voropay@vmb-service.ru>
From: "Alec Voropay" <a.voropay@vmb-service.ru>
To: "'Stefan Deling'" <stefan.deling@web.de>,
	<linux-mips@linux-mips.org>
Subject: RE: Kernel conversion problem ELF -> ECOFF
Date: Mon, 25 Oct 2004 14:03:37 +0400
Organization: VMB-Service
Message-ID: <01aa01c4ba79$e87557f0$1701a8c0@vmbservice.ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4942.400
In-Reply-To: <417C2BB1.9030105@pain-net.home>
Importance: Normal
Return-Path: <a.voropay@vmb-service.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6200
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.voropay@vmb-service.ru
Precedence: bulk
X-list: linux-mips


> elf2ecoof told me:
> "programm header type 3 1694766464 can´t be converted!"
> Has anyone got a solution for this problem??

 Try to use "objcopy" unility ftom the your toolchain.

$ objcopy -O ecoff-littlemips   kernel.elf    kernel.ecoff

(or see man objcopy about -O....  formats )


--
-=AV=-
