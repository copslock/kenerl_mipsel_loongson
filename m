Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Aug 2014 08:33:43 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:57384 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007509AbaH3GdmE9Ksi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 30 Aug 2014 08:33:42 +0200
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 339E728050F;
        Sat, 30 Aug 2014 08:33:22 +0200 (CEST)
Received: from Dicker-Alter.local (p548C939A.dip0.t-ipconnect.de [84.140.147.154])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Sat, 30 Aug 2014 08:33:22 +0200 (CEST)
Message-ID: <5401703B.4090801@openwrt.org>
Date:   Sat, 30 Aug 2014 08:33:31 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Andrew Bresticker <abrestic@chromium.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
CC:     Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] MIPS: GIC device-tree support
References: <1409350479-19108-1-git-send-email-abrestic@chromium.org>
In-Reply-To: <1409350479-19108-1-git-send-email-abrestic@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42342
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Hi Andrew,

On 30/08/2014 00:14, Andrew Bresticker wrote:
> Based on 3.17-rc2 and boot tested on Danube (+ out of tree patches) and
> Malta.

Lantiq makes a mips soc called danube. is this the same family or is
this just a name collision between 2 chip vendors ?

	John
