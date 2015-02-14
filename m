Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Feb 2015 18:21:20 +0100 (CET)
Received: from cpsmtpb-ews06.kpnxchange.com ([213.75.39.9]:61814 "EHLO
        cpsmtpb-ews06.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012573AbbBNRVPYqDX6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 14 Feb 2015 18:21:15 +0100
Received: from cpsps-ews15.kpnxchange.com ([10.94.84.182]) by cpsmtpb-ews06.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Sat, 14 Feb 2015 18:21:10 +0100
Received: from CPSMTPM-TLF104.kpnxchange.com ([195.121.3.7]) by cpsps-ews15.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Sat, 14 Feb 2015 18:21:09 +0100
Received: from [192.168.10.104] ([77.173.140.92]) by CPSMTPM-TLF104.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Sat, 14 Feb 2015 18:21:09 +0100
Message-ID: <1423934469.9418.18.camel@x220>
Subject: MIPS: CONFIG_MIPS_R6?
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc:     Valentin Rothberg <valentinrothberg@gmail.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 14 Feb 2015 18:21:09 +0100
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-4.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Feb 2015 17:21:09.0308 (UTC) FILETIME=[9F826FC0:01D0487A]
X-RcptDomain: linux-mips.org
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45816
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

Your commits 430857eae56c ("MIPS: mm: Add MIPS R6 instruction
encodings") and 90163242784b ("MIPS: kernel: unaligned: Add support for
the MIPS R6") are included in yesterday's linux-next (ie,
next-20150213). I noticed because a script I use to check linux-next
spotted a problem with it.

These commits added three references to CONFIG_MIPS_R6, were probably
CONFIG_CPU_MIPSR6 was intended. One reference is in a comment, which
should be trivial to get fixed. The other two references are in
(negative) preprocessor checks. It's not certain, at least not to me,
how these should be fixed.


Paul Bolle
