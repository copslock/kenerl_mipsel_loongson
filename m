Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jun 2017 18:30:26 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:47138 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993976AbdF1QaStaCmS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Jun 2017 18:30:18 +0200
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 605E7728;
        Wed, 28 Jun 2017 16:30:12 +0000 (UTC)
Date:   Wed, 28 Jun 2017 18:30:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc:     linux-mips@linux-mips.org,
        Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>
Subject: Re: [PATCH v2 0/7] MIPS: Miscellaneous fixes related to Android Mips
 emulator
Message-ID: <20170628163011.GA17042@kroah.com>
References: <1498665399-29007-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1498665399-29007-1-git-send-email-aleksandar.markovic@rt-rk.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58885
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

On Wed, Jun 28, 2017 at 05:56:24PM +0200, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
> 
> v1->v2:
> 
>     - the patch on PREF usage in memcpy dropped as not needed
>     - updated recipient lists using get_maintainer.pl
>     - rebased to the latest kernel code
> 
> This series contains an assortment of changes necessary for proper
> operation of Android emulator for Mips. However, we think that wider
> kernel community may benefit from them too.

This is nice, thanks for these.

How well does these patches "work" with the recent goldfish
images/kernels that are out there?  I know the goldfish platform has
been revamped a lot recently, and I would not like to see these changes
cause things to break there :)

Also, any chance to get some google reviewers for these changes?  I
don't think you added any to the cc: list, how come?

thanks,

greg k-h
