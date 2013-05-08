Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 May 2013 17:03:10 +0200 (CEST)
Received: from drsnuggles.stderr.nl ([94.142.244.14]:35000 "EHLO
        drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827462Ab3EHPDHsQCq6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 May 2013 17:03:07 +0200
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
        by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
        (envelope-from <matthijs@stdin.nl>)
        id 1Ua5tO-0000kI-R5; Wed, 08 May 2013 17:02:55 +0200
Received: (nullmailer pid 2867 invoked by uid 1000);
        Wed, 08 May 2013 15:02:54 -0000
Date:   Wed, 8 May 2013 17:02:54 +0200
From:   Matthijs Kooijman <matthijs@stdin.nl>
To:     Stephen Warren <swarren@wwwdotorg.org>
Cc:     Michal Marek <mmarek@suse.cz>,
        Grant Likely <grant.likely@linaro.org>,
        Rob Herring <rob.herring@calxeda.com>,
        linux-kbuild@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH] kbuild: Don't assume dts files live in arch/*/boot/dts
Message-ID: <20130508150254.GW25742@login.drsnuggles.stderr.nl>
Mail-Followup-To: Stephen Warren <swarren@wwwdotorg.org>,
        Michal Marek <mmarek@suse.cz>,
        Grant Likely <grant.likely@linaro.org>,
        Rob Herring <rob.herring@calxeda.com>, linux-kbuild@vger.kernel.org,
        devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, Stephen Warren <swarren@nvidia.com>
References: <1368010744-11281-1-git-send-email-matthijs@stdin.nl>
 <518A6649.1020501@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <518A6649.1020501@wwwdotorg.org>
X-PGP-Fingerprint: 7F6A 9F44 2820 18E2 18DE  24AA CF49 D0E6 8A2F AFBC
X-PGP-Key: http://www.stderr.nl/static/files/gpg_pubkey.asc
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <matthijs@stdin.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36357
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matthijs@stdin.nl
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

Hey Stephen,

On Wed, May 08, 2013 at 08:50:49AM -0600, Stephen Warren wrote:
> On 05/08/2013 04:59 AM, Matthijs Kooijman wrote:
> > ...
> > The commit referenced above tried to fix this by passing arch/*/boot/dts
> > as an include path to dtc. However, for mips, the .dts files are not in
> > this directory, so dts compilation on mips breaks for some targets.
> > ...
>
> (although I wonder if the .dts files shouldn't be in a standard location?)

On mips, I think the dts files are stored together with the soc code in
per-manufacturer directories, which probably works for them.

Regardless of that discussion, I think my patch makes the dts handling
code more generic, so it's probably a good idea to include it anyway.
