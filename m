Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jan 2003 02:09:41 +0000 (GMT)
Received: from smtp02.infoave.net ([IPv6:::ffff:165.166.0.27]:63989 "EHLO
	smtp02.infoave.net") by linux-mips.org with ESMTP
	id <S8225240AbTAQCJl>; Fri, 17 Jan 2003 02:09:41 +0000
Received: from opus ([204.116.3.125])
 by SMTP00.InfoAve.Net (PMDF V6.1-1IA5 #38777)
 with ESMTP id <01KRBEZT1QGQ90XD8E@SMTP00.InfoAve.Net> for
 linux-mips@linux-mips.org; Thu, 16 Jan 2003 21:09:34 -0500 (EST)
Date: Thu, 16 Jan 2003 21:11:14 -0500
From: Justin Pauley <jpauley@xwizards.com>
Subject: Problems booting
To: linux-mips@linux-mips.org
Message-id: <1042769475.2735.161.camel@Opus>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10)
Content-type: text/plain
Content-transfer-encoding: 7bit
Return-Path: <jpauley@xwizards.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1173
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jpauley@xwizards.com
Precedence: bulk
X-list: linux-mips

Well, MOPD works now! And I installed debian linux. However, now when i
try to boot with:
boot 3/rz0/vmlinux console=ttyS0 
I get the following:
delo V0.7 Copyright....
extfs_open returned Unknown ext2 error(2133571404)
Couldnt fetch config.file /etc/delo.cconf

Any ideas?
Thanks,
Justin
