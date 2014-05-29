Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2014 13:12:17 +0200 (CEST)
Received: from cpsmtpb-ews03.kpnxchange.com ([213.75.39.6]:61087 "EHLO
        cpsmtpb-ews03.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817913AbaE2LMPAJCdR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 May 2014 13:12:15 +0200
Received: from cpsps-ews09.kpnxchange.com ([10.94.84.176]) by cpsmtpb-ews03.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Thu, 29 May 2014 13:12:09 +0200
Received: from CPSMTPM-TLF104.kpnxchange.com ([195.121.3.7]) by cpsps-ews09.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Thu, 29 May 2014 13:12:09 +0200
Received: from [192.168.10.106] ([195.240.213.44]) by CPSMTPM-TLF104.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Thu, 29 May 2014 13:12:08 +0200
Message-ID: <1401361928.6186.48.camel@x220>
Subject: next-20140529: CONFIG_MIPS_MT_SMTC
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Date:   Thu, 29 May 2014 13:12:08 +0200
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-2.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 May 2014 11:12:08.0525 (UTC) FILETIME=[D4C24FD0:01CF7B2E]
X-RcptDomain: linux-mips.org
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40353
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

Hi Ralf,

Kconfig symbol MIPS_MT_SMTC was removed in next-20140526, in commit
633648c5ad3 ("MIPS: MT: Remove SMTC support").

A few references to its macro popped up again in next-20140529. These
references can be traced back to commits ae4ce45419f9 ("MIPS: traps: Add
CPU PM callback for trap configuration") and 74e91335190c ("MIPS: PM:
Implement PM helper macros"). And those commits were merged in commit
7b2e5b89e488 ("Merge branch 'wip-mips-pm' of
https://github.com/paulburton/linux into mips-for-linux-next"). Now I'm
guessing that those references to CONFIG_MIPS_MT_SMTC didn't generate
merge conflicts and therefor went unnoticed.

The trivial solution here is to remove all code hidden behind those
references. Would that solution be correct?


Paul Bolle
