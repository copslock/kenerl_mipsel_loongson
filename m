Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 15:20:31 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54028 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010267AbcBJOU3eSecf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Feb 2016 15:20:29 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id BD20B4062748B;
        Wed, 10 Feb 2016 14:20:20 +0000 (GMT)
Received: from [10.100.200.149] (10.100.200.149) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Wed, 10 Feb 2016
 14:20:23 +0000
Date:   Wed, 10 Feb 2016 14:20:22 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Florian Fainelli <f.fainelli@gmail.com>,
        <linux-mips@linux-mips.org>, <blogic@openwrt.org>,
        <cernekee@gmail.com>, <jon.fraser@broadcom.com>,
        <pgynther@google.com>, <paul.burton@imgtec.com>,
        <ddaney.cavm@gmail.com>
Subject: Re: [PATCH 1/6] MIPS: BMIPS: Disable pref 30 for buggy CPUs
In-Reply-To: <20160210092216.GC10352@linux-mips.org>
Message-ID: <alpine.DEB.2.00.1602101415220.15885@tp.orcam.me.uk>
References: <1455051354-6225-1-git-send-email-f.fainelli@gmail.com> <1455051354-6225-2-git-send-email-f.fainelli@gmail.com> <20160210092033.GB10352@linux-mips.org> <20160210092216.GC10352@linux-mips.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.149]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51973
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Wed, 10 Feb 2016, Ralf Baechle wrote:

> > And why do both MFC0 and MTC0 instructions above have the same opcode?
> 
> Forget this one, I should occasionally open my eyes in the morning ;)

 Yeah, I think we've beaten it with Florian all to death last night 
already.

  Maciej
