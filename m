Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Aug 2014 16:05:03 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:62292 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007029AbaH0OE6xN2kB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Aug 2014 16:04:58 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C84F4ED0CDCEA;
        Wed, 27 Aug 2014 15:04:49 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 27 Aug
 2014 15:04:52 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 27 Aug 2014 15:04:52 +0100
Received: from [192.168.154.67] (192.168.154.67) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 27 Aug
 2014 15:04:51 +0100
Message-ID: <53FDE583.9060908@imgtec.com>
Date:   Wed, 27 Aug 2014 15:04:51 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     <stable@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>
Subject: [request for stable inclusion] MIPS fixes for 3.16
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.67]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42281
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

Hi Greg,

Could you please apply the following patches to the 3.16.X stable kernels?

- MIPS: EVA: Add new EVA header
(f85b71ceabb9d8d8a9e34b045b5c43ffde3623b3)
- MIPS: Malta: EVA: Rename 'eva_entry' to 'platform_eva_init'
(ca4d24f7954f3746742ba350c2276ff777f21173)
- MIPS: CPS: Initialize EVA before bringing up VPEs from secondary cores
(6521d9a436a62e83ce57d6be6e5484e1098c1380)
- MIPS: scall64-o32: Fix indirect syscall detection
(5245689900804604fdc349c8d9b8985b0e401ae2)
- MIPS: syscall: Fix AUDIT value for O32 processes on MIPS64
(40381529f84c4cda3bd2d20cab6a707508856b21)
- MIPS: Malta: Improve system memory detection for '{e, }memsize' >= 2G
(64615682658373516863b5b5971ff1d922d0ae7b)

Thank you!

-- 
markos
