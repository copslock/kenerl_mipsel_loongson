Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Dec 2015 23:36:32 +0100 (CET)
Received: from mga14.intel.com ([192.55.52.115]:36837 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27014346AbbL0WgbCCqx0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 27 Dec 2015 23:36:31 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP; 27 Dec 2015 14:36:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,487,1444719600"; 
   d="scan'208";a="849199622"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.156])
  by orsmga001.jf.intel.com with ESMTP; 27 Dec 2015 14:36:23 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 8707B302BEC; Sun, 27 Dec 2015 14:36:23 -0800 (PST)
Date:   Sun, 27 Dec 2015 14:36:23 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org,
        Michal Marek <mmarek@suse.cz>,
        Guenter Roeck <linux@roeck-us.net>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix ld-version.sh to handle large 3rd version part
Message-ID: <20151227223623.GF25832@tassilo.jf.intel.com>
References: <1451170072-22846-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1451170072-22846-1-git-send-email-james.hogan@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ak@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50758
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ak@linux.intel.com
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

On Sat, Dec 26, 2015 at 10:47:52PM +0000, James Hogan wrote:
> The ld-version.sh script doesn't handle versions with large (>= 10) 3rd
> version components, because the 2nd component is only multiplied by 10
> times that of the 3rd component.
> 
> For example the following version string:
> GNU ld (Codescape GNU Tools 2015.06-05 for MIPS MTI Linux) 2.24.90
> 
> gives a bogus version number:
>  20000000
> + 2400000
> +  900000 = 23300000
> 
> Breakage, confusion and mole-whacking ensues.

Thanks. Looks good. I'll fix the LTO tree.

Reviewed-by: Andi Kleen <ak@linux.intel.com>

-Andi
