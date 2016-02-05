Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Feb 2016 02:22:39 +0100 (CET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:50221 "EHLO
        emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010427AbcBEBWiS-fxl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Feb 2016 02:22:38 +0100
Received: from darkstar.musicnaut.iki.fi (85-76-167-245-nat.elisa-mobile.fi [85.76.167.245])
        by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 42E8569981;
        Fri,  5 Feb 2016 03:22:36 +0200 (EET)
Date:   Fri, 5 Feb 2016 03:22:36 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/7] MIPS: Add support for OCTEON cn78xx and cn73xx.
Message-ID: <20160205012235.GF1620@darkstar.musicnaut.iki.fi>
References: <1454632974-7686-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1454632974-7686-1-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51802
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

On Thu, Feb 04, 2016 at 04:42:47PM -0800, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> The OCTEON III cn78xx and cn73xx family of SoCs has some architectural
> differences from previous OCTEON processors.

Did you test this series also on older OCTEONs? A lot of common files
seems to be modified, so it would be good to describe how it was tested.

A.
