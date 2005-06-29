Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jun 2005 11:36:56 +0100 (BST)
Received: from mail.spb.artcoms.ru ([IPv6:::ffff:82.114.120.253]:24739 "EHLO
	mrelay.spb.artcoms.ru") by linux-mips.org with ESMTP
	id <S8225989AbVF2Kgj>; Wed, 29 Jun 2005 11:36:39 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mrelay.spb.artcoms.ru (Postfix) with ESMTP
	id DAEA9132F3; Wed, 29 Jun 2005 14:36:12 +0400 (MSD)
Received: from mrelay.spb.artcoms.ru ([127.0.0.1])
 by localhost (megera.artcoms.ru [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 13482-06; Wed, 29 Jun 2005 14:36:12 +0400 (MSD)
Received: from ALEC (unknown [192.168.249.108])
	by mrelay.spb.artcoms.ru (Postfix) with SMTP
	id BAD7B132EF; Wed, 29 Jun 2005 14:36:12 +0400 (MSD)
Message-ID: <026701c57c96$5ddbed40$6cf9a8c0@ALEC>
Reply-To: "Alexander Voropay" <alec@artcoms.ru>
From:	"Alexander Voropay" <alec@artcoms.ru>
To:	"Krishna B S" <bskris@gmail.com>, <linux-mips@linux-mips.org>
References: <1943a413050629014858a124f7@mail.gmail.com>
Subject: Re: Popular MIPS4Kc boards?
Date:	Wed, 29 Jun 2005 14:32:24 +0400
Organization: Art Communications
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Virus-Scanned: by amavisd-new at spb.artcoms.ru
Return-Path: <alec@artcoms.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8242
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alec@artcoms.ru
Precedence: bulk
X-list: linux-mips

"Krishna B S" <bskris@gmail.com> wrote:
 
> I would like to know from you what is the most popular board used by
> the community with this kind of processor. I know, its tough to get a
> clear answer.

 You could use one of the consumer devices as a development board ;)

I.e. : http://www.linux-mips.org/wiki/Adm5120 or
http://www.linux-mips.org/wiki/Broadcom_SOCs

 This devices costs about $50..100 and includes case, power supply,
Ethernet, RS-232, Flash, DRAM (16 to 32Mb), USB an one or two
MiniPCI slots.

 You could use a USB stick or IDE HDD with USB-to-IDE controller 
to mount a root partition.

 There are a lot of MiniPCI peripherial cards: WiFi, sound, IDE,
Serial ATA and seems even SVGA.

--
-=AV=-
 
