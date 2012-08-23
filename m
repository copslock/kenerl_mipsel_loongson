Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Aug 2012 08:37:21 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:59543 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903445Ab2HWGhL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Aug 2012 08:37:11 +0200
Message-ID: <5035CF40.9040108@phrozen.org>
Date:   Thu, 23 Aug 2012 08:35:44 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     ddaney.cavm@gmail.com
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        david.daney@cavium.com
Subject: Re: [PATCH 0/8] netdev/MIPS: Improvements to octeon_mgmt Ethernet
 driver.
References: <1345574712-21444-1-git-send-email-ddaney.cavm@gmail.com> <20120822.191654.1727215659090597701.davem@davemloft.net>
In-Reply-To: <20120822.191654.1727215659090597701.davem@davemloft.net>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 34349
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

On 23/08/12 04:16, David Miller wrote:
> From: David Daney <ddaney.cavm@gmail.com>
> Date: Tue, 21 Aug 2012 11:45:04 -0700
> 
>> From: David Daney <david.daney@cavium.com>
>>
>> Recent additions to the OCTEON SoC family have included enhancements
>> to the MIX (octeon_mgmt) Ethernet hardware.  These include:
>>
>> o 1Gig support (up from 100M).
>>
>> o Hardware timestamping for PTP.
>>
>> Here we add support for these two features as well as some ethtool
>> improvements and cleanup of the MAC address handling.
>>
>> Patch 1/8 is a prerequisite for the rest, and lives in the MIPS
>> architecture part of the tree.  Since octeon_mgmt devices are only
>> found in OCTEON SoCs we could merge the whole set via Ralf's tree, or
>> get Ralf to affix his Acked-by and have it go via the netdev tree.
> 
> You can send this all via the MIPS tree, and feel free to add my:
> 
> Acked-by: David S. Miller <davem@davemloft.net>


Thanks, queued for 3.7

	John
