Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Nov 2007 20:19:24 +0000 (GMT)
Received: from mms2.broadcom.com ([216.31.210.18]:55310 "EHLO
	mms2.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S20024082AbXKFUTP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 6 Nov 2007 20:19:15 +0000
Received: from [10.10.64.154] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.1)); Tue, 06 Nov 2007 12:18:53 -0800
X-Server-Uuid: A6C4E0AE-A7F0-449F-BAE7-7FA0D737AC76
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 429C72AF; Tue, 6 Nov 2007 12:18:53 -0800 (PST)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 2E9272AE; Tue, 6 Nov
 2007 12:18:53 -0800 (PST)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id FXI20184; Tue, 6 Nov 2007 12:18:52 -0800 (PST)
Received: from NT-SJCA-0751.brcm.ad.broadcom.com (nt-sjca-0751
 [10.16.192.221]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 85AE120501; Tue, 6 Nov 2007 12:18:52 -0800 (PST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: Deleting read-only environment variable on Sibyte board.
Date:	Tue, 6 Nov 2007 12:18:51 -0800
Message-ID: <03235919BBDE634289BB6A0758A20B36025B77EE@NT-SJCA-0751.brcm.ad.broadcom.com>
In-Reply-To: <20071105130259.GA31023@linux-mips.org>
Thread-Topic: Deleting read-only environment variable on Sibyte board.
Thread-Index: AcgfrFGNFk6haKUcRL21Nr3XOxD9nABBZHMA
From:	"Manoj Ekbote" <manoj.ekbote@broadcom.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org
X-WSS-ID: 6B2E13A72FS16865274-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <manoj.ekbote@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17425
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manoj.ekbote@broadcom.com
Precedence: bulk
X-list: linux-mips

Hi Ralf,
 
Can you try 'Unsetenv [NAME]'?


>-----Original Message-----
>From: linux-mips-bounce@linux-mips.org 
>[mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Ralf Baechle
>Sent: Monday, November 05, 2007 5:03 AM
>To: linux-mips@linux-mips.org
>Subject: Deleting read-only environment variable on Sibyte board.
>
>I've got a read-only environment variable on my 
>Sibyte/Broadcom Bigsur system.  Annoyingly it's the network 
>address.  Any help on how to delete such an undeletable 
>environment variable would be welcome.
>
>Thanks,
>
>  Ralf
>
>
>
