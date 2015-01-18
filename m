Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jan 2015 22:48:09 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:1679 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010992AbbARVsIWh0Pn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Jan 2015 22:48:08 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D57AFCADB9759;
        Sun, 18 Jan 2015 21:47:58 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Sun, 18 Jan 2015 21:48:02 +0000
Received: from localhost (192.168.159.114) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Sun, 18 Jan
 2015 21:47:59 +0000
Date:   Sun, 18 Jan 2015 13:47:57 -0800
From:   Paul Burton <paul.burton@imgtec.com>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
CC:     <linux-mips@linux-mips.org>,
        Matthew Fortune <matthew.fortune@imgtec.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-api@vger.kernel.org>
Subject: Re: [PATCH] MIPS,prctl: add PR_[GS]ET_FP_MODE prctl options for MIPS
Message-ID: <20150118214757.GU28594@NP-P-BURTON>
References: <1420719457-690-1-git-send-email-paul.burton@imgtec.com>
 <54B519B6.5040604@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <54B519B6.5040604@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.159.114]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45248
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

On Tue, Jan 13, 2015 at 01:12:22PM +0000, Markos Chandras wrote:
> Hi,
> 
> I think the "MIPS,prctl" in the title should be "MIPS: prctl"

I used the comma to denote a list - that is, this change affects both
MIPS & the generic prctl code. To me your "MIPS: prctl" suggestion would
indicate that the changes are confined to arch/mips.

> I have also CC'd the LKML and the linux-api mailing lists since this
> touches the kernel ABI with the new PR_[GS]ET_FP_MODE definitions.

Thanks,
    Paul
