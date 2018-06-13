Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jun 2018 17:35:31 +0200 (CEST)
Received: from fudo.makrotopia.org ([IPv6:2a07:2ec0:3002::71]:59482 "EHLO
        fudo.makrotopia.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993339AbeFMPfYkBh7I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jun 2018 17:35:24 +0200
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
         (Exim 4.90_1)
        (envelope-from <daniel@makrotopia.org>)
        id 1fT7no-0003yx-Jd; Wed, 13 Jun 2018 17:35:18 +0200
Date:   Wed, 13 Jun 2018 17:35:13 +0200
From:   Daniel Golle <daniel@makrotopia.org>
To:     Yuri Frolov <crashing.kernel@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [vmlinuz.bin] Does u-boot support loading vmlinuz[.bin]?
Message-ID: <20180613153510.GB31768@makrotopia.org>
References: <90a06531-2663-3982-962d-ff8025ee4388@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90a06531-2663-3982-962d-ff8025ee4388@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Return-Path: <daniel@makrotopia.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64254
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@makrotopia.org
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

Hi Yuri,

On Wed, Jun 13, 2018 at 02:19:06PM +0300, Yuri Frolov wrote:
> Hi,
> 
> do I understand correctly, that the native format for mips arch. u-boot uses is uImage?
> Yocto's default for mips is vmlinuz.bin for some reason, here is the question.
> 

You got to enable U-Boot's CONFIG_CMD_BOOTZ and use the bootz command
in order to boot that. Or change that default to generate FIT or legacy
uImage instead.
