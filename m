Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Dec 2014 23:08:01 +0100 (CET)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:41229 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008477AbaLOWIAUkusa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Dec 2014 23:08:00 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id 058185A6E9F;
        Tue, 16 Dec 2014 00:07:51 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id GIu3NRFQWSFa; Tue, 16 Dec 2014 00:07:44 +0200 (EET)
Received: from fuloong-minipc (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp5.welho.com (Postfix) with ESMTP id 1F7C75BC002;
        Tue, 16 Dec 2014 00:07:53 +0200 (EET)
Date:   Tue, 16 Dec 2014 00:07:52 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Aleksey Makarov <feumilieu@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 13/14] MIPS: OCTEON: Add register definitions for OCTEON
 III reset unit.
Message-ID: <20141215220752.GF10323@fuloong-minipc.musicnaut.iki.fi>
References: <1418666603-15159-1-git-send-email-aleksey.makarov@auriga.com>
 <1418666603-15159-14-git-send-email-aleksey.makarov@auriga.com>
 <20141215210942.GC10323@fuloong-minipc.musicnaut.iki.fi>
 <548F5330.6090508@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <548F5330.6090508@caviumnetworks.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44706
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

On Mon, Dec 15, 2014 at 01:31:28PM -0800, David Daney wrote:
> On 12/15/2014 01:09 PM, Aaro Koskinen wrote:
> >Hi,
> >
> >On Mon, Dec 15, 2014 at 09:03:19PM +0300, Aleksey Makarov wrote:
> >>From: David Daney <david.daney@cavium.com>
> >>
> >>Needed by follow-on patches.
> >
> >Looks like only one of the unions was needed (cvmx_rst_boot)...?
> 
> This follows the form of the other register definition files.
> 
> If Ralf requests it, we would consider deleting some of the currently unused
> definitions.

Most of this stuff looks like machine generated. Can you at least
just make it to minimize the amount of C code it produces?
What's the point of having union definitions like e.g. these:

	+	struct cvmx_rst_boot_s                cn70xx;
	+	struct cvmx_rst_boot_s                cn70xxp1;
	+	struct cvmx_rst_boot_s                cn73xx;
	+	struct cvmx_rst_boot_s                cn78xx;

etc?

A.
