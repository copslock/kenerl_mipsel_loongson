Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2015 11:13:37 +0100 (CET)
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:52177 "EHLO
        cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011464AbbBDKNfesQBZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Feb 2015 11:13:35 +0100
Received: from cpsps-ews30.kpnxchange.com ([10.94.84.196]) by cpsmtpb-ews01.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Wed, 4 Feb 2015 11:13:30 +0100
Received: from CPSMTPM-TLF103.kpnxchange.com ([195.121.3.6]) by cpsps-ews30.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Wed, 4 Feb 2015 11:13:30 +0100
Received: from [192.168.10.108] ([77.173.140.92]) by CPSMTPM-TLF103.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Wed, 4 Feb 2015 11:13:29 +0100
Message-ID: <1423044809.23894.65.camel@x220>
Subject: watchdog: SOC_MT7621?
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Wim Van Sebroeck <wim@iguana.be>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Valentin Rothberg <valentinrothberg@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 04 Feb 2015 11:13:29 +0100
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-4.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Feb 2015 10:13:30.0061 (UTC) FILETIME=[39468FD0:01D04063]
X-RcptDomain: linux-mips.org
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45643
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pebolle@tiscali.nl
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

John Crispin's commit 576c618cf659 ("watchdog: add MT7621 watchdog
support") was included in today's linux-next (ie, next 20150204). I
noticed because a script I use to check linux-next spotted a problem
with it.

That commit adds an (optional) dependency on the Kconfig symbol
SOC_MT7621. But there's no symbol SOC_MT7621 in linux-next yet.

(Note that there currently are two checks for CONFIG_SOC_MT7621 in
arch/mips/ralink/early_printk.c. I mentioned these checks in
https://lkml.org/lkml/2014/10/27/218 and in
https://lkml.org/lkml/2015/1/12/302 . John never replied to these
messages. Since I haven't received replies on other, more serious issues
in over three months I assume John has disappeared.)

Is SOC_MT7621 still being worked on?


Paul Bolle
