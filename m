Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jan 2004 19:09:46 +0000 (GMT)
Received: from adsl-66-123-66-42.dsl.pltn13.pacbell.net ([IPv6:::ffff:66.123.66.42]:10123
	"EHLO stella-blue.herbertphamily.com") by linux-mips.org with ESMTP
	id <S8225073AbUANTJp>; Wed, 14 Jan 2004 19:09:45 +0000
Received: from [192.168.1.8] (shakedown.herbertphamily.com [192.168.1.8])
	(authenticated bits=0)
	by stella-blue.herbertphamily.com (8.12.8/8.12.8) with ESMTP id i0EJ9Y0M001105
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 14 Jan 2004 11:09:34 -0800
Subject: Re: How stable is 2.6 on a SB1250 processor?
From: Kevin Paul Herbert <kph@cisco.com>
To: Jun Sun <jsun@mvista.com>
Cc: Dimitri Torfs <dimitri@sonycom.com>,
	Pete Popov <ppopov@mvista.com>,
	Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <20040113143137.N11733@mvista.com>
References: <1074027809.20636.91.camel@shakedown>
	 <1074028164.21857.120.camel@zeus.mvista.com>
	 <20040113214454.GA2737@sonycom.com>  <20040113143137.N11733@mvista.com>
Content-Type: text/plain
Organization: cisco Systems, Inc.
Message-Id: <1074107359.31877.14.camel@shakedown>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Jan 2004 11:09:21 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <kph@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3946
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kph@cisco.com
Precedence: bulk
X-list: linux-mips

Thanks for the tips. I incorporated Dmitri's patches to uaccess.h and
the syscall handlers and got usermode to come up correctly.

I'm aware of the SB1250 PCI problems and will be addressing that after I
get a few more on-board peripherals working. I've got my own fairly
complex PCI subsystem to port from 2.4 (hotplug, many bridges,
hypertransport configuration) and the main thing that I need from the
core SB1250 support is the ability to generate configuration cycles.
Because of the way the hardware works, I have to program all the bridges
myself (the ROM firmware does not do this for me).

I'll be sure to send patches to the list for anything I fix in the core
SB1250 PCI support.

Thanks again for the tips,

Kevin


-- 
Kevin Paul Herbert <kph@cisco.com>
cisco Systems, Inc.
