Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Oct 2004 01:42:44 +0100 (BST)
Received: from darwaza.gdatech.com ([IPv6:::ffff:66.237.41.98]:38265 "EHLO
	kings.gdatech.com") by linux-mips.org with ESMTP
	id <S8225242AbUJ2Amj>; Fri, 29 Oct 2004 01:42:39 +0100
Received: from kings.gdatech.com (localhost.localdomain [127.0.0.1])
	by kings.gdatech.com (Postfix) with ESMTP id 2FD1861C0CF
	for <linux-mips@linux-mips.org>; Thu, 28 Oct 2004 17:40:46 -0700 (PDT)
X-Propel-Return-Path: <gmuruga@gdatech.com>
Received: from kings.gdatech.com ([192.168.200.118])
	by localhost.localdomain ([127.0.0.1]) (port 7027) (Propel SE relay 0.1.0.1486 $Rev$)
	id r4aw174046D-0619-1
	for linux-mips@linux-mips.org; Thu, 28 Oct 2004 17:40:46 -0700
Received: from sierra.gdatech.com (asg_mda [192.168.200.112])
	by kings.gdatech.com (Postfix) with ESMTP id 0707061C0D1
	for <linux-mips@linux-mips.org>; Thu, 28 Oct 2004 17:40:46 -0700 (PDT)
Received: (from nobody@localhost)
	by gdatech.com (8.11.6/8.11.6) id i9T0ehW15774;
	Thu, 28 Oct 2004 17:40:43 -0700
X-RAV-AntiVirus: This e-mail has been scanned for viruses on host: gdatech.com
Date: Thu, 28 Oct 2004 17:40:43 -0700
Message-Id: <200410290040.i9T0ehW15774@gdatech.com>
X-Authentication-Warning: sierra.gdatech.com: nobody set sender to gmuruga@gdatech.com using -f
From: "Muruga Ganapathy" <gmuruga@gdatech.com>
To: linux-mips@linux-mips.org
Subject: PCMCIA-IDE driver working on the mips
X-Mailer: NeoMail 1.25
X-IPAddress: 63.111.213.196
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-Path: <gmuruga@gdatech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6228
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gmuruga@gdatech.com
Precedence: bulk
X-list: linux-mips

Hello, 

I am very new to this mailing list. 

I am in the process of including/proting  the PCMCIA-IDE driver to 
mips paltform that is similar to sibyte SB1250.  I have linux( mips )
kernel version 2.6.10. This has the support for the PCMCIA-IDE support.


Our requirement is to use the PCMCIA interface for the compact flash with 
a file system .

I would like to understand, 

1. what are configuration options need to be enabled.
2. What are the steps to configure the PCMCIA to access the IDE device
like Compact flash.

Also I would appreciate, if someone points me to a documentation on the
PCMCIA-IDE driver. 

Thanks in advance.

Regards
G.Muruganandam
