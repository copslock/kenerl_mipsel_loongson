Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2016 10:07:07 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57721 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27024739AbcDDIHB0G4K3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Apr 2016 10:07:01 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id B8DDAAFA5E24D;
        Mon,  4 Apr 2016 09:06:53 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Mon, 4 Apr 2016 09:06:55 +0100
Received: from localhost (10.100.200.28) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Mon, 4 Apr
 2016 09:06:54 +0100
Date:   Mon, 4 Apr 2016 09:06:54 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Qais Yousef <qsyousef@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Fix broken malta qemu
Message-ID: <20160404080654.GA14758@NP-P-BURTON>
References: <1458248889-24663-1-git-send-email-qsyousef@gmail.com>
 <20160401124852.GA5145@NP-P-BURTON>
 <56FFB8B7.8050607@gmail.com>
 <20160404064140.GA1368@NP-P-BURTON>
 <20160404080222.GA15222@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20160404080222.GA15222@linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [10.100.200.28]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52861
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On Mon, Apr 04, 2016 at 10:02:23AM +0200, Ralf Baechle wrote:
> FYI, Qais' initial fix is in the pull request I sent to Linus yesterday so
> any fixes please relative to that patch.

Hi Ralf,

To late - I already submitted:

    https://patchwork.linux-mips.org/patch/13003/

I can rebase, but it'll be a revert of Qais' workaround followed by
mine & squashed.

Thanks,
    Paul
