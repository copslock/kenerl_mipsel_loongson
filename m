Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2002 23:06:53 +0200 (CEST)
Received: from port48.ds1-vbr.adsl.cybercity.dk ([212.242.58.113]:5184 "EHLO
	ubik.localnet") by linux-mips.org with ESMTP id <S1122963AbSIRVGx>;
	Wed, 18 Sep 2002 23:06:53 +0200
Received: from murphy.dk (brm@brian.localnet [10.0.0.2])
	by ubik.localnet (8.12.3/8.12.3/Debian -4) with ESMTP id g8IL6k6m019583
	for <linux-mips@linux-mips.org>; Wed, 18 Sep 2002 23:06:46 +0200
Message-ID: <3D88EAE6.50909@murphy.dk>
Date: Wed, 18 Sep 2002 23:06:46 +0200
From: Brian Murphy <brian@murphy.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-MIPS <linux-mips@linux-mips.org>
Subject: 2.5 pci
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <brian@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 242
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian@murphy.dk
Precedence: bulk
X-list: linux-mips

Can anybody tell me how pcibios_init is supposed to get called in the
2.5 kernel?
I had to add it back to pci_init (pci.c) to make it detect my pci devices.

/Brian
