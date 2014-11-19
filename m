Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Nov 2014 02:32:09 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:33064 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013883AbaKSBcHkoOB4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Nov 2014 02:32:07 +0100
Received: from localhost (c-24-22-230-10.hsd1.wa.comcast.net [24.22.230.10])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8C386800;
        Wed, 19 Nov 2014 01:32:00 +0000 (UTC)
Date:   Tue, 18 Nov 2014 17:32:00 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexandre Oliva <lxoliva@fsfla.org>
Cc:     stable@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Yoichi Yuasa <yuasa@linux-mips.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: incomplete mips patch made 3.10.55, remains broken in 3.10.58
Message-ID: <20141119013200.GF22731@kroah.com>
References: <orppdsbixu.fsf@free.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <orppdsbixu.fsf@free.home>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44279
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

On Thu, Oct 16, 2014 at 03:57:33AM -0300, Alexandre Oliva wrote:
> Greg,
> 
> Commit ff522058bd717506b2fa066fa564657f2b86477e was merged into 3.10.55
> stable as commit 4f91cb537d2f7fa700a2b6d86a2cc77d20ee2616.
> 
> Without the complement, commit 5596b0b245fb9d2cefb5023b11061050351c1398,
> included below, cache invalidation functions modified by the former
> patch may return between preempt_disable() and preempt_enable(), causing
> such machines as yeeloongs to go down in flames early in the boot.
> 
> The complement patch had already made v3.12-rc4, and it's quite
> obviously needed and correct.  I've also tested that it fixes the
> regression on the yeeloong.
> 
> So, would you please merge it into the 3.10 stable series, at your
> earlier convenience, so as to fix this regression?

Applied, now, thanks.

greg k-h
