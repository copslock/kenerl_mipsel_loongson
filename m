Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jun 2017 15:55:02 +0200 (CEST)
Received: from mga03.intel.com ([134.134.136.65]:51751 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993866AbdF2NyxRqoDH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 29 Jun 2017 15:54:53 +0200
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2017 06:54:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.40,281,1496127600"; 
   d="scan'208";a="280158351"
Received: from tthayer-hp-z620-workstation.an.intel.com (HELO [10.122.105.144]) ([10.122.105.144])
  by fmsmga004.fm.intel.com with ESMTP; 29 Jun 2017 06:54:44 -0700
Reply-To: thor.thayer@linux.intel.com
Subject: Re: [PATCH] EDAC: Get rid of mci->mod_ver
To:     Borislav Petkov <bp@alien8.de>,
        linux-edac <linux-edac@vger.kernel.org>
Cc:     Mark Gross <mark.gross@intel.com>,
        Robert Richter <rric@kernel.org>,
        Tim Small <tim@buttersideup.com>,
        Ranganathan Desikan <ravi@jetztechnologies.com>,
        "Arvind R." <arvino55@gmail.com>, Jason Baron <jbaron@akamai.com>,
        Tony Luck <tony.luck@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>, Loc Ho <lho@apm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org
References: <20170629100311.vmdq6fojpo5ye4ne@pd.tnic>
From:   Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <deade91d-7326-8a39-3881-50db582c3098@linux.intel.com>
Date:   Thu, 29 Jun 2017 08:57:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170629100311.vmdq6fojpo5ye4ne@pd.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <thor.thayer@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58903
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thor.thayer@linux.intel.com
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

On 06/29/2017 05:03 AM, Borislav Petkov wrote:
> Hi,
> 
> any objections?
> 
> ---
> It is a write-only variable so get rid of it.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Thor Thayer <thor.thayer@linux.intel.com>
> Cc: Mark Gross <mark.gross@intel.com>
> Cc: Robert Richter <rric@kernel.org>
> Cc: Tim Small <tim@buttersideup.com>
> Cc: Ranganathan Desikan <ravi@jetztechnologies.com>
> Cc: "Arvind R." <arvino55@gmail.com>
> Cc: Jason Baron <jbaron@akamai.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: "Sören Brinkmann" <soren.brinkmann@xilinx.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: David Daney <david.daney@cavium.com>
> Cc: Loc Ho <lho@apm.com>
> Cc: linux-edac@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mips@linux-mips.org
> ---
>   drivers/edac/altera_edac.c      | 2 --

<snip>

> 
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index db75d4b614f7..fa2e5db56d24 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -38,7 +38,6 @@
>   #include "edac_module.h"
>   
>   #define EDAC_MOD_STR		"altera_edac"
> -#define EDAC_VERSION		"1"
>   #define EDAC_DEVICE		"Altera"
>   

<snip>

Looks fine for Altera EDAC.

Acked-by: Thor Thayer <thor.thayer@linux.intel.com>
