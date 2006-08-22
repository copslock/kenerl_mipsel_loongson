Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Aug 2006 16:27:35 +0100 (BST)
Received: from mx.globalone.ru ([194.84.254.251]:50359 "EHLO mx.globalone.ru")
	by ftp.linux-mips.org with ESMTP id S20038730AbWHVP1d (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 22 Aug 2006 16:27:33 +0100
Received: from mx.globalone.ru (localhost [127.0.0.1])
	by mx.globalone.ru (8.13.1/8.13.1) with ESMTP id k7MFRGiw005023;
	Tue, 22 Aug 2006 19:27:21 +0400
Received: from smtp.globalone.ru (smtp.globalone.ru [172.16.38.5])
	by mx.globalone.ru (8.13.1/8.13.1) with ESMTP id k7MFR1nc004976;
	Tue, 22 Aug 2006 19:27:01 +0400
Received: from voropaya ([172.16.38.7]) by smtp.globalone.ru
          (Netscape Messaging Server 4.15) with SMTP id J4EO9100.MQP; Tue,
          22 Aug 2006 19:27:01 +0400 
Message-ID: <0b2801c6c5ff$1ff8a8c0$e90d11ac@spb.in.rosprint.ru>
Reply-To: "Alexander Voropay" <a.voropay@equant.ru>
From:	"Alexander Voropay" <a.voropay@equant.ru>
To:	"Yoichi Yuasa" <yoichi_yuasa@tripeaks.co.jp>,
	"Ralf Baechle" <ralf@linux-mips.org>
Cc:	"linux-mips" <linux-mips@linux-mips.org>
References: <20060822223406.56435d84.yoichi_yuasa@tripeaks.co.jp>
Subject: Re: [PATCH 2/12] Cobalt use GT64120 PCI routines
Date:	Tue, 22 Aug 2006 19:22:01 +0400
Organization: &Equant
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="ISO-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
X-Scanned-By: MIMEDefang 2.56 on 172.16.38.2
Return-Path: <a.voropay@equant.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12410
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.voropay@equant.ru
Precedence: bulk
X-list: linux-mips

"Yoichi Yuasa" <yoichi_yuasa@tripeaks.co.jp> wrote:
> 
> This patch has moved GT64111 PCI routine to GT64120 PCI routine about Cobalt.
> They are same codes.

 Hm... GT64111 and GT64120 are two different chips, i.e. GT64120 has two
PCI buses e.t.c. May be, it wil be better to move this code to something
more genetic, like GT64* ?


--
-=AV=-
