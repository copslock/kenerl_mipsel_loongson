Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Sep 2004 11:07:15 +0100 (BST)
Received: from cachan-9-82-229-218-57.fbx.proxad.net ([IPv6:::ffff:82.229.218.57]:25510
	"EHLO nikita.france.sdesigns.com") by linux-mips.org with ESMTP
	id <S8224845AbUIAKHL>; Wed, 1 Sep 2004 11:07:11 +0100
Received: from nikita.france.sdesigns.com (localhost.localdomain [127.0.0.1])
	by nikita.france.sdesigns.com (8.12.11/8.12.11) with ESMTP id i81A75wR026769
	for <linux-mips@linux-mips.org>; Wed, 1 Sep 2004 12:07:05 +0200
Received: (from michon@localhost)
	by nikita.france.sdesigns.com (8.12.11/8.12.11/Submit) id i81A740O026768
	for linux-mips@linux-mips.org; Wed, 1 Sep 2004 12:07:04 +0200
X-Authentication-Warning: nikita.france.sdesigns.com: michon set sender to em@realmagic.fr using -f
Subject: TLB dimensioning
From: Emmanuel Michon <em@realmagic.fr>
To: linux-mips@linux-mips.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: REALmagic France SAS
Message-Id: <1094033224.20643.1402.camel@nikita.france.sdesigns.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 01 Sep 2004 12:07:04 +0200
Return-Path: <em@realmagic.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5758
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: em@realmagic.fr
Precedence: bulk
X-list: linux-mips

Hi,

regarding the hardware implementation of a 4KE (r4k style mmu
if I remember) I'm wondering about the performance difference
when the TLB has 16 pairs of entries (covering 128KBytes of
data) or 32 pairs (covering 256KBytes).

Does someone have a useful advise regarding the `nice spot'
for TLB size?

Sincerely yours,

E.M.
