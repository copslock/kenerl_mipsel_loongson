Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2014 11:44:57 +0100 (CET)
Received: from cpsmtpb-ews06.kpnxchange.com ([213.75.39.9]:60326 "EHLO
        cpsmtpb-ews06.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011272AbaJ0KozMV3hc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Oct 2014 11:44:55 +0100
Received: from cpsps-ews07.kpnxchange.com ([10.94.84.174]) by cpsmtpb-ews06.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Mon, 27 Oct 2014 11:44:48 +0100
Received: from CPSMTPM-TLF101.kpnxchange.com ([195.121.3.4]) by cpsps-ews07.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Mon, 27 Oct 2014 11:44:48 +0100
Received: from [192.168.10.108] ([77.173.140.92]) by CPSMTPM-TLF101.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Mon, 27 Oct 2014 11:44:48 +0100
Message-ID: <1414406687.28499.17.camel@x220>
Subject: MIPS: ralink: CONFIG_SOC_MT7621?
From:   Paul Bolle <pebolle@tiscali.nl>
To:     John Crispin <blogic@openwrt.org>
Cc:     Valentin Rothberg <valentinrothberg@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 27 Oct 2014 11:44:47 +0100
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-4.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Oct 2014 10:44:48.0270 (UTC) FILETIME=[077782E0:01CFF1D3]
X-RcptDomain: linux-mips.org
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43577
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

John,

Your commit 715f2e581856 ("MIPS: ralink: cleanup early_printk") landed
in today's linux-next (ie, next-20141027). It adds two checks for
CONFIG_SOC_MT7621. The patch to add Kconfig symbol SOC_MT7621 is still
pending (see http://patchwork.linux-mips.org/patch/8033/ ).

Obviously, until that patch lands these two checks will always evaluate
to false.


Paul Bolle
