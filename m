Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2006 12:30:26 +0000 (GMT)
Received: from [213.189.19.80] ([213.189.19.80]:34058 "EHLO mail.kpsws.com")
	by ftp.linux-mips.org with ESMTP id S8133834AbWASMaG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 19 Jan 2006 12:30:06 +0000
Received: (qmail 50233 invoked by uid 89); 19 Jan 2006 12:33:47 -0000
Received: from unknown (HELO mail.kpsws.com) (127.0.0.1)
  by localhost with SMTP; 19 Jan 2006 12:33:47 -0000
Received: from 194.171.252.101
        (SquirrelMail authenticated user pulsar@kpsws.com)
        by mail.kpsws.com with HTTP;
        Thu, 19 Jan 2006 13:33:47 +0100 (CET)
Message-ID: <49175.194.171.252.101.1137674027.squirrel@mail.kpsws.com>
In-Reply-To: <200601191230.59347.p_christ@hol.gr>
References: <f07e6e0601160423h5ce1c0d7lcb7e38f8509c4116@mail.gmail.com> 
     <200601190035.19022.p_christ@hol.gr> 
     <Pine.LNX.4.62.0601191100001.21230@pademelon.sonytel.be> 
     <200601191230.59347.p_christ@hol.gr>
Date:	Thu, 19 Jan 2006 13:33:47 +0100 (CET)
Subject: "useless" pgprot_noncached define in include/asm-mips/pgtable.h
From:	"Niels Sterrenburg" <pulsar@kpsws.com>
To:	"Linux/MIPS Development" <linux-mips@linux-mips.org>
Cc:	niels.sterrenburg@philips.com
Reply-To: pulsar@kpsws.com
User-Agent: SquirrelMail/1.4.0
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Return-Path: <pulsar@kpsws.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9981
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pulsar@kpsws.com
Precedence: bulk
X-list: linux-mips

Hi,

I'm trying to understand the vm implementation on MIPS
and I see the following #define in include/asm-mips/pgtable.h:

#define pgprot_noncached pgprot_noncached

Was there any ideas behind this code or can it be removed ?

regards,

Niels Sterrenburg
