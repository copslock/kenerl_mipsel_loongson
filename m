Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jul 2008 12:43:35 +0100 (BST)
Received: from astoria.ccjclearline.com ([64.235.106.9]:27059 "EHLO
	astoria.ccjclearline.com") by ftp.linux-mips.org with ESMTP
	id S20024233AbYG1Ln3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 28 Jul 2008 12:43:29 +0100
Received: from cpe0018f85aee2d-cm00140454b5f8.cpe.net.cable.rogers.com ([72.140.151.132] helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1KNR8P-0003jZ-Cb
	for linux-mips@linux-mips.org; Mon, 28 Jul 2008 07:43:26 -0400
Date:	Mon, 28 Jul 2008 07:41:50 -0400 (EDT)
From:	"Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:	linux-mips@linux-mips.org
Subject: a couple Makefile-related non-existent CONFIG vars
Message-ID: <alpine.LFD.1.10.0807280739290.14259@localhost.localdomain>
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
X-archive-position: 19987
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rpjday@crashcourse.ca
Precedence: bulk
X-list: linux-mips


  two mips-related CONFIG vars that occur exclusively in Makefiles:

===== MSPETH =====
./arch/mips/pmc-sierra/msp71xx/Makefile:obj-$(CONFIG_MSPETH) += msp_eth.o
===== USB_MSP71XX =====
./arch/mips/pmc-sierra/msp71xx/Makefile:obj-$(CONFIG_USB_MSP71XX) += msp_usb.o

  and that's it for MIPS.

rday
--

========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry:
    Have classroom, will lecture.

http://crashcourse.ca                          Waterloo, Ontario, CANADA
========================================================================
