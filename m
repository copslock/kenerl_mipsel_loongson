Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Nov 2013 22:02:44 +0100 (CET)
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:56545 "EHLO
        filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822311Ab3KLVCmU0e8V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Nov 2013 22:02:42 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri2.pp.htv.fi (Postfix) with ESMTP id C825219C0AA;
        Tue, 12 Nov 2013 23:02:40 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
        with ESMTP id Hs2xvwSd2zLm; Tue, 12 Nov 2013 23:02:36 +0200 (EET)
Received: from musicnaut.iki.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp6.welho.com (Postfix) with SMTP id B2C595BC006;
        Tue, 12 Nov 2013 23:02:35 +0200 (EET)
Received: by musicnaut.iki.fi (sSMTP sendmail emulation); Tue, 12 Nov 2013 23:02:34 +0200
Date:   Tue, 12 Nov 2013 23:02:34 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
Cc:     LMOL <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Release of Linux MTI-3.10-LTS kernel.
Message-ID: <20131112210234.GB30010@blackmetal.musicnaut.iki.fi>
References: <528246BA.10607@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <528246BA.10607@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38514
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

On Tue, Nov 12, 2013 at 09:18:18AM -0600, Steven J. Hill wrote:
> Imagination Technologies is pleased to announce the release of its
> 3.10 LTS (Long-Term Support) MIPS kernel. The changelog below is
> based off the stable Linux 3.10.14 release done by Greg
> Kroah-Hartman in commit
> 8c15abc94c737f9120d3d4a550abbcbb9be121f6 back on October 1st. The
> code repository is hosted at the Linux/MIPS project GIT:
> 
> http://git.linux-mips.org/?p=linux-mti.git;a=summary
> 
> We look forward to any comments or feedback.

Why multiple MIPS stable trees? There's already also
http://git.linux-mips.org/?p=ralf/linux.git;a=shortlog;h=refs/heads/linux-3.10-stable?

Also 3.10.14 sounds quite old. Are you sure you are not missing any
important fixes?

A.
