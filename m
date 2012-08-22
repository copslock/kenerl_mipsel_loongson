Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Aug 2012 22:37:14 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:48808 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903611Ab2HVUhF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 Aug 2012 22:37:05 +0200
Message-ID: <5035429B.6040202@phrozen.org>
Date:   Wed, 22 Aug 2012 22:35:39 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
CC:     David Daney <david.daney@cavium.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v2] spi: Add SPI master controller for OCTEON SOCs.
References: <1345663507-15423-1-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1345663507-15423-1-git-send-email-ddaney.cavm@gmail.com>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 34346
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 24951

On 22/08/12 21:25, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Add the driver, link it into the kbuild system and provide device tree
> binding documentation.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> 
> This should replace the version merged up by blogic.
> 
> It builds against linux-next where in addition to the fixes requested
> by the SPI maintainers, I fixed some errors caused by now improper
>  #includes.

Thanks, queued for 3.7 (replacing the previous version)

	John
