Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Nov 2004 09:22:51 +0000 (GMT)
Received: from host195-84.pool217141.interbusiness.it ([IPv6:::ffff:217.141.84.195]:19211
	"EHLO ingredium.it") by linux-mips.org with ESMTP
	id <S8224845AbUKJJWo>; Wed, 10 Nov 2004 09:22:44 +0000
Received: (qmail 66376 invoked by uid 89); 10 Nov 2004 09:22:42 -0000
Message-ID: <20041110092242.66375.qmail@ingredium.it>
From: "r.zilli" <r.zilli@ingredium.it>
To: linux-mips@linux-mips.org
Subject: HPT 371N kernel 2.4.26
Date: Wed, 10 Nov 2004 10:22:42 +0100
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <r.zilli@ingredium.it>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6294
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r.zilli@ingredium.it
Precedence: bulk
X-list: linux-mips


Hi guys, 

there is a problem on HPT371N HD controller, it's working only if i compile 
the kernel 2.4.26 with CONFIG_IDEPCI_SHARE_IRQ flag.
It is not completely working, in the sense that during the phase of writing 
the machine is frozen.
Meanwhile on the evaluation board Au1500 with HPT370A it's working very 
well. 

Anyone have patch this? 

Roberto 
