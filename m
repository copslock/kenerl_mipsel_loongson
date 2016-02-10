Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Feb 2016 00:49:11 +0100 (CET)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:43347 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010896AbcBJXtKDeNl8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Feb 2016 00:49:10 +0100
Received: from darkstar.musicnaut.iki.fi (85-76-167-245-nat.elisa-mobile.fi [85.76.167.245])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 074B23FDE;
        Thu, 11 Feb 2016 01:49:07 +0200 (EET)
Date:   Thu, 11 Feb 2016 01:49:07 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Matt Redfearn <matt.redfearn@imgtec.com>,
        linux-mmc@vger.kernel.org, david.daney@cavium.com,
        ulf.hansson@linaro.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Zubair.Kakakhel@imgtec.com,
        Aleksey Makarov <aleksey.makarov@caviumnetworks.com>,
        Chandrakala Chavva <cchavva@caviumnetworks.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Leonid Rosenboim <lrosenboim@caviumnetworks.com>,
        Peter Swain <pswain@cavium.com>,
        Aaron Williams <aaron.williams@cavium.com>
Subject: Re: [PATCH v5] mmc: OCTEON: Add host driver for OCTEON MMC controller
Message-ID: <20160210234907.GC1640@darkstar.musicnaut.iki.fi>
References: <1455125775-7245-1-git-send-email-matt.redfearn@imgtec.com>
 <56BB7B2F.60307@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56BB7B2F.60307@caviumnetworks.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51982
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

On Wed, Feb 10, 2016 at 10:02:23AM -0800, David Daney wrote:
> On 02/10/2016 09:36 AM, Matt Redfearn wrote:
> >+		pr_warn(FW_WARN "%s: Legacy property '%s'. Please remove\n",
> >+			node->full_name, legacy_name);
> 
> I don't like this warning message.
> 
> The vast majority of people that see it will not be able to change their
> firmware.  So it will be forever cluttering up their boot logs.

Until they switch to use APPENDED_DTB. :-)

A.
