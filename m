Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2016 19:35:08 +0100 (CET)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:57588 "EHLO
        emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013893AbcBXSfGSHVaA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Feb 2016 19:35:06 +0100
Received: from darkstar.musicnaut.iki.fi (85-76-167-245-nat.elisa-mobile.fi [85.76.167.245])
        by emh04.mail.saunalahti.fi (Postfix) with ESMTP id B11681A266D;
        Wed, 24 Feb 2016 20:35:05 +0200 (EET)
Date:   Wed, 24 Feb 2016 20:35:05 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH v2 2/3] MIPS: OCTEON: device_tree_init: don't fill mac if
 already set
Message-ID: <20160224183505.GX1640@darkstar.musicnaut.iki.fi>
References: <1456267927-2492-1-git-send-email-aaro.koskinen@iki.fi>
 <1456267927-2492-3-git-send-email-aaro.koskinen@iki.fi>
 <56CD852F.4000204@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56CD852F.4000204@cogentembedded.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52204
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

On Wed, Feb 24, 2016 at 01:25:51PM +0300, Sergei Shtylyov wrote:
> On 2/24/2016 1:52 AM, Aaro Koskinen wrote:
> >+	old_mac = fdt_getprop(initial_boot_params, n, "local-mac-address",
> >+			      &old_len);
> >+	if (!old_mac || old_len != 6 || is_valid_ether_addr(old_mac))
> >+		return;
> 
>    So if there's no such prop or the length is not 6, you just return?

Yes, in that case the network drivers will silently switch to use a
random address. This is the same behaviour as with "normal" DT boot.

A.
