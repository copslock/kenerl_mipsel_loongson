Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Jul 2003 04:27:27 +0100 (BST)
Received: from [IPv6:::ffff:66.121.16.190] ([IPv6:::ffff:66.121.16.190]:9028
	"EHLO trid-mail1.tridentmicro.com") by linux-mips.org with ESMTP
	id <S8225072AbTGYD1Z> convert rfc822-to-8bit; Fri, 25 Jul 2003 04:27:25 +0100
content-class: urn:content-classes:message
Subject: mmap'ed memory cacheable or uncheable
Date: Thu, 24 Jul 2003 20:26:59 -0700
Message-ID: <61F6477DE6BED311B69F009027C3F58403AA3969@EXCHANGE>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 8BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: mmap'ed memory cacheable or uncheable
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Thread-Index: AcNSXKiReSC929WDTXmK/JHbWFx90w==
From: "Teresa Tao" <Teresat@tridentmicro.com>
To: <linux-mips@linux-mips.org>
Return-Path: <Teresat@tridentmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2908
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Teresat@tridentmicro.com
Precedence: bulk
X-list: linux-mips

Hi there,

I got a question regarding the mmap'ed memory. Is the mmap'ed memory cacheable or uncheable? My driver just use the remap_page_range to map a reserved physical memory.

Thanks in advance!

Teresa
