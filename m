Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Dec 2004 17:47:13 +0000 (GMT)
Received: from darwaza.gdatech.com ([IPv6:::ffff:66.237.41.98]:53575 "EHLO
	kings.gdatech.com") by linux-mips.org with ESMTP
	id <S8225305AbULHRrI>; Wed, 8 Dec 2004 17:47:08 +0000
Received: from kings.gdatech.com (localhost.localdomain [127.0.0.1])
	by kings.gdatech.com (Postfix) with ESMTP id C39DA61C0D4
	for <linux-mips@linux-mips.org>; Wed,  8 Dec 2004 09:42:04 -0800 (PST)
X-Propel-Return-Path: <gmuruga@gdatech.com>
Received: from kings.gdatech.com ([192.168.200.118])
	by localhost.localdomain ([127.0.0.1]) (port 7027) (Propel SE relay 0.1.0.1557 $Rev$)
	id r4cH094204-0291-1
	for linux-mips@linux-mips.org; Wed, 08 Dec 2004 09:42:04 -0800
Received: from sierra.gdatech.com (asg_mda [192.168.200.112])
	by kings.gdatech.com (Postfix) with ESMTP id 911B161C0D3
	for <linux-mips@linux-mips.org>; Wed,  8 Dec 2004 09:42:04 -0800 (PST)
Received: (from nobody@localhost)
	by gdatech.com (8.11.6/8.11.6) id iB8Hgpp31261;
	Wed, 8 Dec 2004 09:42:51 -0800
X-RAV-AntiVirus: This e-mail has been scanned for viruses on host: gdatech.com
Date: Wed, 8 Dec 2004 09:42:51 -0800
Message-Id: <200412081742.iB8Hgpp31261@gdatech.com>
X-Authentication-Warning: sierra.gdatech.com: nobody set sender to gmuruga@gdatech.com using -f
From: "Muruga Ganapathy" <gmuruga@gdatech.com>
To: linux-mips@linux-mips.org
Subject: Forcing IDE to work in PIO mode
X-Mailer: NeoMail 1.25
X-IPAddress: 63.111.213.196
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-Path: <gmuruga@gdatech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6601
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gmuruga@gdatech.com
Precedence: bulk
X-list: linux-mips

Hello, 

How do I force the IDE to work in the PIO mode by including the 
option like "hdb=noprobe" in the setup.c?


My kernel version is 2.6.6

Thanks
G.Muruganandam
