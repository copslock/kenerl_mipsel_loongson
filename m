Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Feb 2015 17:57:11 +0100 (CET)
Received: from cpsmtpb-ews10.kpnxchange.com ([213.75.39.15]:59730 "EHLO
        cpsmtpb-ews10.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012573AbbBNQ5JX-zkG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 14 Feb 2015 17:57:09 +0100
Received: from cpsps-ews16.kpnxchange.com ([10.94.84.197]) by cpsmtpb-ews10.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Sat, 14 Feb 2015 17:57:04 +0100
Received: from CPSMTPM-TLF102.kpnxchange.com ([195.121.3.5]) by cpsps-ews16.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Sat, 14 Feb 2015 17:57:03 +0100
Received: from [192.168.10.104] ([77.173.140.92]) by CPSMTPM-TLF102.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Sat, 14 Feb 2015 17:57:02 +0100
Message-ID: <1423933022.9418.8.camel@x220>
Subject: MIPS: FP32XX_HYBRID_FPRS
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     Valentin Rothberg <valentinrothberg@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 14 Feb 2015 17:57:02 +0100
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-4.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Feb 2015 16:57:03.0139 (UTC) FILETIME=[41868F30:01D04877]
X-RcptDomain: linux-mips.org
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45815
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

Your d8fb6537f1d4 ("MIPS: kernel: elf: Improve the overall ABI and FPU
mode checks") is included in yesterday's linux-next (ie, next-20150213).
I noticed because a script I use to check linux-next spotted a minor
problem with it.

That commit removed the only user of Kconfig symbol FP32XX_HYBRID_FPRS.
Setting FP32XX_HYBRID_FPRS is now pointless in linux-next. Is the
trivial commit to its entry form arch/mips/Kconfig.debug queued
somewhere?


Paul Bolle
