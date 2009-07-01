Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Jul 2009 19:25:59 +0200 (CEST)
Received: from astoria.ccjclearline.com ([64.235.106.9]:51063 "EHLO
	astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491784AbZGARZy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 1 Jul 2009 19:25:54 +0200
Received: from cpe00142a336e11-cm001ac318e826.cpe.net.cable.rogers.com ([174.113.191.234] helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1MM3sN-0002Y9-3s
	for linux-mips@linux-mips.org; Wed, 01 Jul 2009 13:45:43 -0400
Date:	Wed, 1 Jul 2009 13:18:04 -0400 (EDT)
From:	"Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To:	linux-mips@linux-mips.org
Subject: Makefile references to undefined CONFIG variables
Message-ID: <alpine.LFD.2.00.0907011316290.14829@localhost>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
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
X-archive-position: 23579
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rpjday@crashcourse.ca
Precedence: bulk
X-list: linux-mips


  just FYI, results from my latest tree scan -- references from
Makefiles to CONFIG vars that don't seem to exist:

===== HAVE_GPIO_LIB =====
./arch/mips/pmc-sierra/msp71xx/Makefile:obj-$(CONFIG_HAVE_GPIO_LIB) +=
gpio.o gpio_extended.o
===== MSPETH =====
./arch/mips/pmc-sierra/msp71xx/Makefile:obj-$(CONFIG_MSPETH) +=
msp_eth.o
===== USB_MSP71XX =====
./arch/mips/pmc-sierra/msp71xx/Makefile:obj-$(CONFIG_USB_MSP71XX) +=
msp_usb.o


rday
--

========================================================================
Robert P. J. Day                               Waterloo, Ontario, CANADA

        Linux Consulting, Training and Annoying Kernel Pedantry.

Web page:                                          http://crashcourse.ca
Linked In:                             http://www.linkedin.com/in/rpjday
Twitter:                                       http://twitter.com/rpjday
========================================================================
