Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Dec 2014 00:55:36 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:42849 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008064AbaLCXzZ7AYD1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Dec 2014 00:55:25 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 7BC55878D8299;
        Wed,  3 Dec 2014 23:55:15 +0000 (GMT)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 3 Dec
 2014 23:55:20 +0000
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by klmail02.kl.imgtec.org
 (10.40.60.222) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 3 Dec
 2014 23:55:20 +0000
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Dec
 2014 23:55:19 +0000
Received: from [192.168.65.146] (192.168.65.146) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 3 Dec 2014
 15:55:17 -0800
Message-ID: <547FA2E5.1040105@imgtec.com>
Date:   Wed, 3 Dec 2014 15:55:17 -0800
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>
CC:     <Zubair.Kakakhel@imgtec.com>, <geert+renesas@glider.be>,
        <peterz@infradead.org>, <paul.gortmaker@windriver.com>,
        <macro@linux-mips.org>, <chenhc@lemote.com>, <cl@linux.com>,
        <mingo@kernel.org>, <richard@nod.at>, <zajec5@gmail.com>,
        <james.hogan@imgtec.com>, <keescook@chromium.org>, <tj@kernel.org>,
        <alex@alex-smith.me.uk>, <pbonzini@redhat.com>,
        <blogic@openwrt.org>, <paul.burton@imgtec.com>,
        <qais.yousef@imgtec.com>, <linux-kernel@vger.kernel.org>,
        <markos.chandras@imgtec.com>, <dengcheng.zhu@imgtec.com>,
        <manuel.lauss@gmail.com>, <lars.persson@axis.com>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 2/3] MIPS: Add full ISA emulator.
References: <1417650258-2811-1-git-send-email-ddaney.cavm@gmail.com> <1417650258-2811-3-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1417650258-2811-3-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.65.146]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44565
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

On 12/03/2014 03:44 PM, David Daney wrote:

(...)

Big work but it doesn't support customized instructions, multiple ASEs, 
MIPS R6 etc.

Well, it is still not a replacement of XOL emulation.
Even close.
