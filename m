Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Feb 2015 09:45:06 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:62434 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012242AbbBPIpFoZXy6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Feb 2015 09:45:05 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D8304C538C01C;
        Mon, 16 Feb 2015 08:44:58 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 16 Feb 2015 08:45:00 +0000
Received: from localhost (192.168.154.96) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 16 Feb
 2015 08:44:38 +0000
Date:   Mon, 16 Feb 2015 08:44:38 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     Paul Bolle <pebolle@tiscali.nl>
CC:     Valentin Rothberg <valentinrothberg@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: MIPS: FP32XX_HYBRID_FPRS
Message-ID: <20150216084438.GA27931@mchandras-linux.le.imgtec.org>
References: <1423933022.9418.8.camel@x220>
 <1423935239.9418.25.camel@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <1423935239.9418.25.camel@x220>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45826
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

On Sat, Feb 14, 2015 at 06:33:59PM +0100, Paul Bolle wrote:
> On Sat, 2015-02-14 at 17:57 +0100, Paul Bolle wrote:
> > Your d8fb6537f1d4 ("MIPS: kernel: elf: Improve the overall ABI and FPU
> > mode checks") is included in yesterday's linux-next (ie, next-20150213).
> > I noticed because a script I use to check linux-next spotted a minor
> > problem with it.
> > 
> > That commit removed the only user of Kconfig symbol FP32XX_HYBRID_FPRS.
> > Setting FP32XX_HYBRID_FPRS is now pointless in linux-next. Is the
> > trivial commit to its entry form arch/mips/Kconfig.debug queued
>            [....] to remove its entry from [...] 
> 
> > somewhere?
> 
> 
> Paul Bolle
> 

Hi Paul,

Thanks I will fix the original patch to drop this symbol

-- 
markos
