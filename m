Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jun 2014 18:03:18 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:34132 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6859957AbaFRQDQ06QAl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Jun 2014 18:03:16 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s5IG3D6V002258;
        Wed, 18 Jun 2014 18:03:13 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s5IG3A6Y002222;
        Wed, 18 Jun 2014 18:03:10 +0200
Date:   Wed, 18 Jun 2014 18:03:10 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     ganesanr@broadcom.com
Cc:     kristina.martsenko@gmail.com, gregkh@linuxfoundation.org,
        jchandra@broadcom.com, linux-mips@linux-mips.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 0/3] XLR/XLS network driver update and fixes
Message-ID: <20140618160309.GG26335@linux-mips.org>
References: <cover.1403096668.git.ganesanr@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1403096668.git.ganesanr@broadcom.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40636
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Wed, Jun 18, 2014 at 06:43:55PM +0530, ganesanr@broadcom.com wrote:

> From: Ganesan Ramalingam <ganesanr@broadcom.com>
> 
> Patches has following changes:
> 
>  * Fixed compilation failure caused by change in COP2 API
>  * SGMII PHY address calculation was wrong, fixed
>  * Updated the driver to have single parent device for a XLR/XLS
>    network block with multiple network devices under it
>  * Fixed comment format

Patches 1 and 2 apply cleanly but I'm getting a reject for patch 3.

  Ralf
