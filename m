Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2015 11:58:22 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38420 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011616AbbD1J5qRugK6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2015 11:57:46 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 2F8ECFF571108;
        Tue, 28 Apr 2015 10:57:38 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 28 Apr 2015 10:57:40 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 28 Apr 2015 10:57:39 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>, <linux-mips@linux-mips.org>
Subject: [PATCH 0/2] MIPS: CDMM big endian fixes for v4.1
Date:   Tue, 28 Apr 2015 10:57:28 +0100
Message-ID: <1430215050-4995-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.0.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47119
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

The MIPS Common Device Memory Map (CDMM) is internal to the core and has
native endianness. There is therefore no need to byte swap the MMIO
accesses on big endian targets. This patchset converts the CDMM bus
driver and Fast Debug Channel (FDC) TTY driver to use __raw_readl() and
__raw_writel() when accessing the CDMM so they work on big endian
targets too.

I guess it makes sense for this to go via the MIPS tree since thats
where the original patches were applied. Please apply for v4.1.

James Hogan (2):
  MIPS: Fix CDMM to use native endian MMIO reads
  ttyFDC: Fix to use native endian MMIO reads

 drivers/bus/mips_cdmm.c      |  4 ++--
 drivers/tty/mips_ejtag_fdc.c | 17 +++++++++--------
 2 files changed, 11 insertions(+), 10 deletions(-)

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: linux-mips@linux-mips.org
-- 
2.0.5
