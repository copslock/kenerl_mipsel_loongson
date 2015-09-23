Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Sep 2015 23:42:46 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:62935 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008780AbbIWVmpEhSFI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Sep 2015 23:42:45 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 68D90FDA1EA22;
        Wed, 23 Sep 2015 22:42:35 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 23 Sep 2015 22:42:39 +0100
Received: from localhost (192.168.159.186) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 23 Sep
 2015 22:42:38 +0100
Date:   Wed, 23 Sep 2015 14:42:36 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        <linux-next@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        <linux-mips@linux-mips.org>
Subject: Re: linux-next: Tree for Sep 23
Message-ID: <20150923214236.GA28778@NP-P-BURTON>
References: <20150923142343.35797c0f@canb.auug.org.au>
 <20150923074207.GA27002@sudip-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20150923074207.GA27002@sudip-pc>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.159.186]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49348
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

On Wed, Sep 23, 2015 at 01:12:08PM +0530, Sudip Mukherjee wrote:
> On Wed, Sep 23, 2015 at 02:23:43PM +1000, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20150922:
> mips allmodconfig failed with the error:
> No rule to make target 'arch/mips/mm/sc-debugfs.o', needed by 'arch/mips/mm/built-in.o'
> 
> caused by:
> 13ea0032658d ("MIPS: Allow L2 prefetch to be configured via debugfs")
> 
> regards
> sudip

Hi Ralf,

That patch as I submitted it definitely adds arch/mips/mm/sc-debugfs.c
but somehow that file has been lost from the commit in your
mips-for-linux-next tree. Could you re-apply it?

Thanks,
    Paul
