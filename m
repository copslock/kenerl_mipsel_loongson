Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jul 2018 11:40:39 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:41092 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992479AbeGPJkdHIT0t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Jul 2018 11:40:33 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A1F61AF8;
        Mon, 16 Jul 2018 09:40:25 +0000 (UTC)
Date:   Mon, 16 Jul 2018 11:40:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 4.9 03/32] MIPS: Use async IPIs for
 arch_trigger_cpumask_backtrace()
Message-ID: <20180716094023.GA20647@kroah.com>
References: <20180716073504.433996952@linuxfoundation.org>
 <20180716073504.871411055@linuxfoundation.org>
 <tencent_63FC64B11AAB89F2466748AE@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_63FC64B11AAB89F2466748AE@qq.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64860
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

On Mon, Jul 16, 2018 at 05:29:05PM +0800, 陈华才 wrote:
> Hi, Greg,
> 
> kernel-4.9 doesn't have call_single_data_t, we should use struct call_single_data instead.

Can you send me a patch to merge with this one with that change so that
I know I get it right?

thanks,

greg k-h
