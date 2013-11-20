Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Nov 2013 04:23:54 +0100 (CET)
Received: from co9ehsobe001.messaging.microsoft.com ([207.46.163.24]:17100
        "EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816852Ab3KTDXvpLcrD convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Nov 2013 04:23:51 +0100
Received: from mail19-co9-R.bigfish.com (10.236.132.242) by
 CO9EHSOBE001.bigfish.com (10.236.130.64) with Microsoft SMTP Server id
 14.1.225.22; Wed, 20 Nov 2013 03:23:42 +0000
Received: from mail19-co9 (localhost [127.0.0.1])       by mail19-co9-R.bigfish.com
 (Postfix) with ESMTP id 67647A0142;    Wed, 20 Nov 2013 03:23:42 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:70.37.183.190;KIP:(null);UIP:(null);IPV:NLI;H:mail.freescale.net;RD:none;EFVD:NLI
X-SpamScore: 1
X-BigFish: VS1(z579ehzda00hdc73hzz1f42h2148h208ch1ee6h1de0h1fdah2073h2146h1202h1e76h1d1ah1d2ah1fc6hzzz2dh109h2a8h839h8e2h8e3h944hd25hf0ah1220h1288h12a5h12a9h12bdh137ah13b6h1441h1504h1537h153bh15d0h162dh1631h1758h18e1h1946h19b5h1ad9h1b0ah1b2fh2222h224fh1fb3h1d0ch1d2eh1d3fh1dc1h1dfeh1dffh1e1dh1fe8h1ff5h2184h21a6h2216h22d0hbe9i35h1155h)
Received: from mail19-co9 (localhost.localdomain [127.0.0.1]) by mail19-co9
 (MessageSwitch) id 1384917820698841_20549; Wed, 20 Nov 2013 03:23:40 +0000
 (UTC)
Received: from CO9EHSMHS010.bigfish.com (unknown [10.236.132.230])      by
 mail19-co9.bigfish.com (Postfix) with ESMTP id A10D83600ED;    Wed, 20 Nov 2013
 03:23:40 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by CO9EHSMHS010.bigfish.com
 (10.236.130.20) with Microsoft SMTP Server (TLS) id 14.16.227.3; Wed, 20 Nov
 2013 03:23:40 +0000
Received: from 039-SN2MPN1-011.039d.mgd.msft.net ([169.254.1.106]) by
 039-SN1MMR1-003.039d.mgd.msft.net ([10.84.1.16]) with mapi id 14.03.0158.002;
 Wed, 20 Nov 2013 03:23:39 +0000
From:   Richard Zhu <Hong-Xing.Zhu@freescale.com>
To:     Richard Zhu <Hong-Xing.Zhu@freescale.com>
CC:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "linux390@de.ibm.com" <linux390@de.ibm.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Russell King <linux@arm.linux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Recall: [PATCH 24/34] PCI: use weak functions for MSI arch-specific
 functions
Thread-Topic: [PATCH 24/34] PCI: use weak functions for MSI arch-specific
 functions
Thread-Index: Ac7ln+ffcirW6/xBRUWSBTnSgNARNw==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 35
X-FaxNumberOfPages: 0
Date:   Wed, 20 Nov 2013 03:23:39 +0000
Message-ID: <0E83723C55F66F43A6041464FE31119D446111@039-SN2MPN1-011.039d.mgd.msft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.192.242.157]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: freescale.com
X-FOPE-CONNECTOR: Id%0$Dn%*$RO%0$TLS%0$FQDN%$TlsDn%
Return-Path: <Hong-Xing.Zhu@freescale.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38558
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Hong-Xing.Zhu@freescale.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Zhu Richard-R65037 would like to recall the message, "[PATCH 24/34] PCI: use weak functions for MSI arch-specific functions".
