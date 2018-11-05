Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2018 04:20:12 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23990403AbeKEDSlwUR-N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Nov 2018 04:18:41 +0100
Date:   Mon, 5 Nov 2018 03:18:41 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 0/3] MIPS: DEC: DECstation defconfig refresh and new
 templates
Message-ID: <alpine.LFD.2.21.1811050219130.20378@eddie.linux-mips.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67082
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

Hi,

 It's been a while since the DECstation defconfig has been last actually 
updated rather than merely regenerated.  My `git log' examination points
at commit 3f821640341b ("[MIPS] DECstation defconfig update") from 2006.

 We have since gained a bunch of new drivers and also some drivers were 
unnecessarily disabled.  Therefore I have decided to refresh the defconfig 
(1/3), and to make people's life easier also to provide an R4k version 
(2/3) and a 64-bit version (3/3), covering all the three base DECstation 
configurations.  Apart from being ready to use with actual systems these 
additional defconfigs should make it easier for automated tools to verify 
correctness of the non-R3k configurations.

 These were all verified to build and boot multiuser.  Please apply.

  Maciej
