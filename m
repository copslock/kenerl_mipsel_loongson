Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Aug 2008 17:27:01 +0100 (BST)
Received: from astoria.ccjclearline.com ([64.235.106.9]:54740 "EHLO
	astoria.ccjclearline.com") by ftp.linux-mips.org with ESMTP
	id S28588739AbYHJQ0z (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 10 Aug 2008 17:26:55 +0100
Received: from cpe00142a336e11-cm001ac318e826.cpe.net.cable.rogers.com ([72.140.150.221] helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1KSDkp-000715-KN
	for linux-mips@linux-mips.org; Sun, 10 Aug 2008 12:26:51 -0400
Date:	Sun, 10 Aug 2008 12:25:06 -0400 (EDT)
From:	"Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:	linux-mips@linux-mips.org
Subject: update:  MIPS-related unused config vars in kernel tree
Message-ID: <alpine.LFD.1.10.0808101223050.22113@localhost.localdomain>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - astoria.ccjclearline.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <rpjday@crashcourse.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20167
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rpjday@crashcourse.ca
Precedence: bulk
X-list: linux-mips


  the output from the latest scan:

===== BLK_DEV_IDE_AU1XXX_SEQTS_PER_RQ
Documentation/mips/AU1xxx_IDE.README:61:  CONFIG_BLK_DEV_IDE_AU1XXX_SEQTS_PER_RQ - maximum transfer size
Documentation/mips/AU1xxx_IDE.README:90:CONFIG_BLK_DEV_IDE_AU1XXX_SEQTS_PER_RQ=128
Documentation/mips/AU1xxx_IDE.README:108:CONFIG_BLK_DEV_IDE_AU1XXX_SEQTS_PER_RQ=128
drivers/ide/Kconfig:803:config BLK_DEV_IDE_AU1XXX_SEQTS_PER_RQ

rday
--

========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry:
    Have classroom, will lecture.

http://crashcourse.ca                          Waterloo, Ontario, CANADA
========================================================================
