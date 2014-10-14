Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Oct 2014 06:31:32 +0200 (CEST)
Received: from relmlor4.renesas.com ([210.160.252.174]:41144 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010103AbaJNEb3rsZCa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Oct 2014 06:31:29 +0200
Received: from unknown (HELO relmlir4.idc.renesas.com) ([10.200.68.154])
  by relmlie3.idc.renesas.com with ESMTP; 14 Oct 2014 13:31:25 +0900
Received: from relmlac3.idc.renesas.com (relmlac3.idc.renesas.com [10.200.69.23])
        by relmlir4.idc.renesas.com (Postfix) with ESMTP id 26BD23F9C6;
        Tue, 14 Oct 2014 13:31:25 +0900 (JST)
Received: by relmlac3.idc.renesas.com (Postfix, from userid 0)
        id 17A89180A1; Tue, 14 Oct 2014 13:31:25 +0900 (JST)
Received: from relmlac3.idc.renesas.com (localhost [127.0.0.1])
        by relmlac3.idc.renesas.com (Postfix) with ESMTP id 0FFD5180A0;
        Tue, 14 Oct 2014 13:31:25 +0900 (JST)
Received: from relmlii1.idc.renesas.com [10.200.68.65] 
         by relmlac3.idc.renesas.com with ESMTP id PAM28738;
         Tue, 14 Oct 2014 13:31:25 +0900
X-IronPort-AV: E=Sophos;i="5.04,714,1406559600"; 
   d="scan'208";a="171187046"
Received: from mail-sg1lp0092.outbound.protection.outlook.com (HELO APAC01-SG1-obe.outbound.protection.outlook.com) ([207.46.51.92])
  by relmlii1.idc.renesas.com with ESMTP/TLS/AES256-SHA; 14 Oct 2014 13:31:18 +0900
Received: from pcepx30.hoku.renesas.com.renesas.com (211.11.155.140) by
 SINPR06MB090.apcprd06.prod.outlook.com (10.242.54.12) with Microsoft SMTP
 Server (TLS) id 15.0.1049.19; Tue, 14 Oct 2014 04:31:10 +0000
Date:   Tue, 14 Oct 2014 13:29:29 +0900
Message-ID: <87oatfi89i.wl%hirokazu.takata.wj@renesas.com>
From:   Hirokazu TAKATA <hirokazu.takata.wj@renesas.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     <linux-kernel@vger.kernel.org>,
        <adi-buildroot-devel@lists.sourceforge.net>,
        <devel@driverdev.osuosl.org>, <devicetree@vger.kernel.org>,
        <lguest@lists.ozlabs.org>, <linux-acpi@vger.kernel.org>,
        <linux-alpha@vger.kernel.org>, <linux-am33-list@redhat.com>,
        <linux-cris-kernel@axis.com>, <linux-efi@vger.kernel.org>,
        <linux-hexagon@vger.kernel.org>, <linux-m32r-ja@ml.linux-m32r.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-s390@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-xtensa@linux-xtensa.org>,
        <openipmi-developer@lists.sourceforge.net>,
        <user-mode-linux-devel@lists.sourceforge.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-c6x-dev@linux-c6x.org>, <linux-ia64@vger.kernel.org>,
        <linux-m68k@lists.linux-m68k.org>, <linux-metag@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <linux-parisc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-sh@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@arm.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Steven Miao <realmz6@gmail.com>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <a-jacquiot@ti.com>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        David Howells <dhowells@redhat.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Hirokazu Takata <takata@linux-m32r.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Hogan <james.hogan@imgtec.com>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
        Jonas Bonn <jonas@southpole.se>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Chen Liqin <liqin.linux@gmail.com>,
        Lennox Wu <lennox.wu@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        David Vrabel <david.vrabel@citrix.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 08/44] kernel: Move pm_power_off to common code
In-Reply-To: <1412659726-29957-9-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
        <1412659726-29957-9-git-send-email-linux@roeck-us.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/24.3 Mule/6.0 (HANACHIRUSATO)
Renesas-ECN: H07-0010RT
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [211.11.155.140]
X-ClientProxiedBy: SIXPR06CA0048.apcprd06.prod.outlook.com (25.160.171.166) To
 SINPR06MB090.apcprd06.prod.outlook.com (10.242.54.12)
X-Microsoft-Antispam: UriScan:;
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:;SRVR:SINPR06MB090;
X-Exchange-Antispam-Report-Test: UriScan:;
X-Forefront-PRVS: 03648EFF89
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(199003)(51704005)(189002)(47776003)(92726001)(558084003)(20776003)(122386002)(105586002)(106356001)(76176999)(95666004)(19580395003)(54356999)(85852003)(77096002)(64706001)(86362001)(36756003)(40100003)(107046002)(66066001)(92566001)(19580405001)(50986999)(85306004)(42186005)(21056001)(87976001)(31966008)(50466002)(4396001)(97736003)(33646002)(23726002)(111086002)(101416001)(110136001)(76482002)(120916001)(46406003)(102836001)(46102003)(80022003)(83506001);DIR:OUT;SFP:1102;SCL:1;SRVR:SINPR06MB090;H:pcepx30.hoku.renesas.com.renesas.com;FPR:;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:;
X-OriginatorOrg: renesas.com
Return-Path: <hirokazu.takata.wj@renesas.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43257
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hirokazu.takata.wj@renesas.com
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

From: Guenter Roeck <linux@roeck-us.net>
>  arch/m32r/kernel/process.c         |  8 ++++----

Acked-by: Hirokazu Takata <takata@linux-m32r.org>

Thank you.

-- takata
