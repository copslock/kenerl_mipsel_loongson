Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Apr 2018 14:57:48 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:57774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990502AbeDZM5fbCytn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Apr 2018 14:57:35 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1899A217B9;
        Thu, 26 Apr 2018 12:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1899A217B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
Date:   Thu, 26 Apr 2018 14:57:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Amit Pundir <amit.pundir@linaro.org>
Cc:     jason@lakedaemon.net, linux-mips@linux-mips.org,
        marc.zyngier@arm.com,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        stable-commits@vger.kernel.org
Subject: Re: Patch "irqchip/mips-gic: Fix local interrupts" has been added to
 the 4.9-stable tree
Message-ID: <20180426125720.GB8975@kroah.com>
References: <1524672085206172@kroah.com>
 <CAMi1Hd2JT10MmretDX0zFAKsXetJ41aUwMr8vJa=JdVPz+VGaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMi1Hd2JT10MmretDX0zFAKsXetJ41aUwMr8vJa=JdVPz+VGaw@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Return-Path: <SRS0=oi4b=HP=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63795
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

On Thu, Apr 26, 2018 at 03:35:20PM +0530, Amit Pundir wrote:
> Hi Greg,
> 
> Please drop this patch. It was NACKed on stable before
> https://www.spinics.net/lists/stable/msg170768.html. Thanks.

Sorry about that, now dropped.

greg k-h
