Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Feb 2015 18:26:52 +0100 (CET)
Received: from cpsmtpb-ews04.kpnxchange.com ([213.75.39.7]:56408 "EHLO
        cpsmtpb-ews04.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012573AbbBNR0v1M1f8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 14 Feb 2015 18:26:51 +0100
Received: from cpsps-ews29.kpnxchange.com ([10.94.84.195]) by cpsmtpb-ews04.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Sat, 14 Feb 2015 18:26:45 +0100
Received: from CPSMTPM-TLF104.kpnxchange.com ([195.121.3.7]) by cpsps-ews29.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Sat, 14 Feb 2015 18:26:45 +0100
Received: from [192.168.10.104] ([77.173.140.92]) by CPSMTPM-TLF104.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Sat, 14 Feb 2015 18:26:44 +0100
Message-ID: <1423934805.9418.23.camel@x220>
Subject: MIPS: CONFIG_CPU_MIPS_R6?
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc:     Valentin Rothberg <valentinrothberg@gmail.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 14 Feb 2015 18:26:45 +0100
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-4.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Feb 2015 17:26:45.0248 (UTC) FILETIME=[67BED000:01D0487B]
X-RcptDomain: linux-mips.org
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45817
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

Your commit 33d73a3d4159 ("MIPS: lib: memset: Add MIPS R6 support") is
included in yesterday's linux next (ie, next-20150213). I noticed
because a script I use to check linux-next spotted a trivial problem
with it.

It added a reference to CONFIG_CPU_MIPS_R6 in comment. Should I submit
the trivial patch to change that into a reference to CONFIG_CPU_MIPSR6
or do you prefer to do that yourself?


Paul Bolle
