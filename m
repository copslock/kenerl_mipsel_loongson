Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Nov 2012 16:00:50 +0100 (CET)
Received: from avon.wwwdotorg.org ([70.85.31.133]:46207 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823038Ab2KBPApZ3NTj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Nov 2012 16:00:45 +0100
Received: from severn.wwwdotorg.org (unknown [192.168.65.5])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPS id BFED06231;
        Fri,  2 Nov 2012 09:01:17 -0600 (MDT)
Received: from [IPv6:::1] (localhost [127.0.0.1])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by severn.wwwdotorg.org (Postfix) with ESMTPSA id 2B685E40EF;
        Fri,  2 Nov 2012 09:00:39 -0600 (MDT)
Message-ID: <5093E015.1070504@wwwdotorg.org>
Date:   Fri, 02 Nov 2012 09:00:37 -0600
From:   Stephen Warren <swarren@wwwdotorg.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120912 Thunderbird/15.0.1
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Michal Marek <mmarek@suse.cz>,
        David Gibson <david@gibson.dropbear.id.au>,
        Jon Loeliger <jdl@jdl.com>,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        Scott Wood <scottwood@freescale.com>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        devicetree-discuss@lists.ozlabs.org, linux-arch@vger.kernel.org,
        Stephen Warren <swarren@nvidia.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH V5 1/2] kbuild: centralize .dts->.dtb rule
References: <1351721431-26220-1-git-send-email-swarren@wwwdotorg.org> <20121102095801.GC17860@linux-mips.org> <20121102102335.GF2905@linux-mips.org>
In-Reply-To: <20121102102335.GF2905@linux-mips.org>
X-Enigmail-Version: 1.4.4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.96.5 at avon.wwwdotorg.org
X-Virus-Status: Clean
X-archive-position: 34856
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: swarren@wwwdotorg.org
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

On 11/02/2012 04:23 AM, Ralf Baechle wrote:
> On Fri, Nov 02, 2012 at 10:58:01AM +0100, Ralf Baechle wrote:
> 
>> Can you fold these MIPS bits into your patch?
> 
> I missed Lantiq.

Thanks, I've squashed that in, and with a quick grep noticed that
arch/{arm64,microblaze} also need updating.
