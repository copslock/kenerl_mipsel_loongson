Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2003 08:20:48 +0000 (GMT)
Received: from gwa2.fe.bosch.de ([IPv6:::ffff:194.39.218.2]:18307 "EHLO
	gwa2.fe.bosch.de") by linux-mips.org with ESMTP id <S8225205AbTKZIUg>;
	Wed, 26 Nov 2003 08:20:36 +0000
Received: by gwa2.fe.bosch.de (Postfix, from userid 5)
	id 4F718C5210; Wed, 26 Nov 2003 09:20:04 +0100 (MET)
Received: from fez8020.de.bosch.com(unknown 10.4.4.19) by gwa2.fe.bosch.de via smap (V2.1)
	id xma017362; Wed, 26 Nov 03 09:19:42 +0100
Received: from 10.3.5.83 by fez8020.de.bosch.com (InterScan E-Mail VirusWall NT); Wed, 26 Nov 2003 09:19:32 +0100
Received: from hi-mail02.de.bosch.com ([10.34.16.71]) by si-imc02.de.bosch.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 26 Nov 2003 09:19:33 +0100
Received: from de.bosch.com ([10.34.211.138]) by hi-mail02.de.bosch.com with Microsoft SMTPSVC(5.0.2195.5329);
	 Wed, 26 Nov 2003 09:19:28 +0100
Message-ID: <3FC461C5.6060303@de.bosch.com>
Date: Wed, 26 Nov 2003 09:18:13 +0100
From: Dirk Behme <dirk.behme@de.bosch.com>
Organization: Blaupunkt GmbH
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Missing #ifdef in asm/pci.h?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Nov 2003 08:19:28.0723 (UTC) FILETIME=[02D33A30:01C3B3F6]
Return-Path: <Dirk.Behme@de.bosch.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3676
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dirk.behme@de.bosch.com
Precedence: bulk
X-list: linux-mips

Hello,

with linux_2_6_0_test9 include/asm-mips/pci.h I get these warnings:

include/asm/pci.h: In function `pci_dac_page_to_dma':
include/asm/pci.h:84: warning: implicit declaration of function 
`dev_to_baddr'
include/asm/pci.h: In function `pci_dac_dma_to_page':
include/asm/pci.h:90: warning: implicit declaration of function 
`baddr_to_dev'

dev_to_baddr and baddr_to_dev are defined in arch/mips/mm/dma-ip27.c and 
therefore can't be included in pci.h.

Is it possible that in pci.h there is missing an appropriate #ifdef 
around the pci_dac_* functions?

If I disable all pci_dac_* functions with #if 0, everything compiles 
without problems.

Dirk
