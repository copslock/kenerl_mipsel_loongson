Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2015 00:22:36 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54723 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011579AbbA2XWfQ1wFK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jan 2015 00:22:35 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 04270784DC7F7;
        Thu, 29 Jan 2015 23:22:26 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 29 Jan 2015 23:22:29 +0000
Received: from localhost (192.168.159.159) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 29 Jan
 2015 23:22:24 +0000
Date:   Thu, 29 Jan 2015 23:22:22 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
CC:     Matthew Fortune <Matthew.Fortune@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "Maciej W. Rozycki (macro@linux-mips.org)" <macro@linux-mips.org>
Subject: Re: [PATCH RFC v2 68/70] MIPS: kernel: elf: Improve the overall ABI
 and FPU mode checks
Message-ID: <20150129232222.GJ6116@NP-P-BURTON>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
 <1421405389-15512-69-git-send-email-markos.chandras@imgtec.com>
 <6D39441BF12EF246A7ABCE6654B0235320FAAEED@LEMAIL01.le.imgtec.org>
 <54BCF5D7.1020907@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <54BCF5D7.1020907@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.159.159]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45553
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

On Mon, Jan 19, 2015 at 12:17:27PM +0000, Markos Chandras wrote:
> > Is it worth updating the CONFIG_MIPS_O32_FP64_SUPPORT option to no longer
> > be experimental and also default on? This option could then guard the new
> > logic from this patch as a safety measure. Once the code has been proven
> > I'd suggest removing the option and making the code unconditional.
> 
> Paul?
> 
> Initially thought of having 32-bit R6 select this symbol but then I
> dropped it. But maybe it make sense now?

Personally I'd rather leave it default to off until it gets through a
release cycle without any complaints. Perhaps having r6 select it, or
"default y if CONFIG_CPU_MIPSR6" would make sense though, given that you
won't be able to use the FPU for r6 userland without it.

Paul
