Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2018 08:44:30 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:43216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994571AbeJJGo1ogZrN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Oct 2018 08:44:27 +0200
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8627321479;
        Wed, 10 Oct 2018 06:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539153861;
        bh=VJLc+HNWqGgdYjq77zP1FIYFlCYYg40RkyZ9frR6Q6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DL8jT2BH8zSbJFXI94OlQ3cLy1XB2nE2QZsgFdNWXiw7Z9Ty48tOKgoYZQjOAzu2w
         H9sQp4rU57z6NH/V7yB9zbKnI/GCnq1JDeAIlXnzFBojWe0qASBBXeM4cFOSs9V0VR
         L6C7wVyeThrRt4QPCYAp6/6rXScf0ztehUGurpEM=
Date:   Wed, 10 Oct 2018 08:44:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [GIT PULL] MIPS fixes for 4.19
Message-ID: <20181010064418.GA13182@kroah.com>
References: <20181009203016.twicrnkxfoo4p2yl@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009203016.twicrnkxfoo4p2yl@pburton-laptop>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <SRS0=AHPx=MW=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66739
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

On Tue, Oct 09, 2018 at 08:30:18PM +0000, Paul Burton wrote:
> Hi Greg,
> 
> Here are a few MIPS fixes for 4.19, dealing with regressions from the
> past few release cycles. Please pull.
> 
> Thanks,
>     Paul
> 
> The following changes since commit 6bf4ca7fbc85d80446ac01c0d1d77db4d91a6d84:
> 
>   Linux 4.19-rc5 (2018-09-23 19:15:18 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_fixes_4.19_2

Now merged, thanks.

greg k-h
