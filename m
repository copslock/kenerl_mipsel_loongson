Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 May 2003 01:31:29 +0100 (BST)
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([IPv6:::ffff:213.105.254.86]:3788
	"EHLO lxorguk.ukuu.org.uk") by linux-mips.org with ESMTP
	id <S8225213AbTE0AbV>; Tue, 27 May 2003 01:31:21 +0100
Received: from dhcp22.swansea.linux.org.uk (dhcp22.swansea.linux.org.uk [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.12.8/8.12.5) with ESMTP id h4QNXJRQ017282;
	Tue, 27 May 2003 00:33:20 +0100
Received: (from alan@localhost)
	by dhcp22.swansea.linux.org.uk (8.12.8/8.12.8/Submit) id h4QNXCkT017280;
	Tue, 27 May 2003 00:33:12 +0100
X-Authentication-Warning: dhcp22.swansea.linux.org.uk: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: PCI Conf Space in application mode
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: JinuM <jinum@esntechnologies.co.in>
Cc: linux-mips@linux-mips.org
In-Reply-To: <AF572D578398634881E52418B2892567122B4C@mail.esn.activedirectory>
References: <AF572D578398634881E52418B2892567122B4C@mail.esn.activedirectory>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053991990.17128.12.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 May 2003 00:33:12 +0100
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2449
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

> On my x86 system i do that using iopl() call n then accessing PCI Conf space
> through ADDRESS port(0xCF8) and DATA port(0xCFC). Here i have no problems
> accessing the IO ports.

This is wrong. If the kernel does a PCI config access between your two
accesses you will break the system. See pcilib as used by lspci
