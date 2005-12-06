Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Dec 2005 23:25:58 +0000 (GMT)
Received: from mms1.broadcom.com ([216.31.210.17]:26897 "EHLO
	mms1.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S8133802AbVLFXZh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Dec 2005 23:25:37 +0000
Received: from 10.10.64.121 by mms1.broadcom.com with SMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Tue, 06 Dec 2005 15:25:03 -0800
X-Server-Uuid: F962EFE0-448C-40EE-8100-87DF498ED0EA
Received: from mail-irva-8.broadcom.com ([10.10.64.221]) by
 mail-irva-1.broadcom.com (Post.Office MTA v3.5.3 release 223 ID#
 0-72233U7200L2200S0V35) with ESMTP id com; Tue, 6 Dec 2005 15:25:03
 -0800
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.5.6-GR) with ESMTP
 id CHO74822; Tue, 6 Dec 2005 15:24:54 -0800 (PST)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 0BB1A20501; Tue, 6 Dec 2005 15:24:54 -0800 (PST)
Received: from [127.0.0.1] ([10.240.253.113]) by
 NT-SJCA-0750.brcm.ad.broadcom.com with Microsoft
 SMTPSVC(6.0.3790.1830); Tue, 6 Dec 2005 15:24:53 -0800
Message-ID: <43961DC1.80405@broadcom.com>
Date:	Tue, 06 Dec 2005 15:24:49 -0800
From:	"Mark Mason" <mason@broadcom.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	"Jim Gifford" <maillist@jg555.com>
cc:	"Scott Ashcroft" <scott.ashcroft@talk21.com>,
	linux-mips@linux-mips.org
Subject: Re: pci_iomap issues?
References: <20051206002312.60357.qmail@web86303.mail.ukl.yahoo.com>
 <4394EDC8.9080301@jg555.com>
In-Reply-To: <4394EDC8.9080301@jg555.com>
X-Enigmail-Version: 0.93.0.0
OpenPGP: id=E9620E57; url=
X-OriginalArrivalTime: 06 Dec 2005 23:24:53.0782 (UTC)
 FILETIME=[432E2360:01C5FABC]
X-WSS-ID: 6F88C24548G9308121-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <mark.e.mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9623
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mason@broadcom.com
Precedence: bulk
X-list: linux-mips

Hello,

Jim Gifford wrote:

> How many machines are affected by multiple pci busses. I can only
> thing of the Origin systems. Couldn't we get a base iomap.c in and add
> one's specific to the multiple bus machines?

Any system based on BCM1480s could have multiple pci busses (one PCI-X
directly, and additional busses through HT/PCI-X bridges).  For the
BCM91480B board, we had to turn on PCI_DOMAINS to get this to work
correctly.

/Mark
