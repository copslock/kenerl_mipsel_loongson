Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Dec 2017 15:28:55 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:50948 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990921AbdLGO2o0L8op (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Dec 2017 15:28:44 +0100
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8F789C77;
        Thu,  7 Dec 2017 14:28:36 +0000 (UTC)
Date:   Thu, 7 Dec 2017 15:28:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        "Steven J. Hill" <steven.hill@cavium.com>
Subject: Re: [PATCH v4 6/8] staging: octeon: Remove USE_ASYNC_IOBDMA macro.
Message-ID: <20171207142844.GA22444@kroah.com>
References: <20171129005540.28829-1-david.daney@cavium.com>
 <20171129005540.28829-7-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171129005540.28829-7-david.daney@cavium.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61341
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

On Tue, Nov 28, 2017 at 04:55:38PM -0800, David Daney wrote:
> Previous patch sets USE_ASYNC_IOBDMA to 1 unconditionally.  Remove
> USE_ASYNC_IOBDMA from all if statements.  Remove dead code caused by
> the change.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
