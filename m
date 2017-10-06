Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Oct 2017 11:18:11 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:53684 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993869AbdJFJSFc5GCo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Oct 2017 11:18:05 +0200
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2EE4A4A3;
        Fri,  6 Oct 2017 09:17:58 +0000 (UTC)
Date:   Fri, 6 Oct 2017 11:18:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: Re: [PATCH 4.9 010/104] MIPS: fix mem=X@Y commandline processing
Message-ID: <20171006091806.GA17988@kroah.com>
References: <20171006083840.743659740@linuxfoundation.org>
 <20171006083842.248091756@linuxfoundation.org>
 <CA+7wUszpNtwje0kPs07nDD2aSeYafSuW1dpX8+Z5HKOBSNC0eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+7wUszpNtwje0kPs07nDD2aSeYafSuW1dpX8+Z5HKOBSNC0eA@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60309
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

On Fri, Oct 06, 2017 at 11:10:11AM +0200, Mathieu Malaterre wrote:
> Hi Greg,
> 
> Please do not apply to stable.
> 
> See: https://patchwork.linux-mips.org/patch/17235/

Ah, so will you send this and that one for 4.9 when it hits Linus's
tree?

I'll go drop this one now, thanks.

greg k-h
