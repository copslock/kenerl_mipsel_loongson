Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 May 2013 20:41:27 +0200 (CEST)
Received: from drsnuggles.stderr.nl ([94.142.244.14]:48532 "EHLO
        drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822830Ab3ERSlWU-1Jq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 18 May 2013 20:41:22 +0200
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
        by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
        (envelope-from <matthijs@stdin.nl>)
        id 1Udm3x-00027y-RF; Sat, 18 May 2013 20:41:02 +0200
Received: (nullmailer pid 8180 invoked by uid 1000);
        Sat, 18 May 2013 18:41:01 -0000
Date:   Sat, 18 May 2013 20:41:01 +0200
From:   Matthijs Kooijman <matthijs@stdin.nl>
To:     Stephen Warren <swarren@wwwdotorg.org>
Cc:     Michal Marek <mmarek@suse.cz>,
        Grant Likely <grant.likely@linaro.org>,
        Rob Herring <rob.herring@calxeda.com>,
        linux-kbuild@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH] kbuild: Don't assume dts files live in arch/*/boot/dts
Message-ID: <20130518184101.GS25742@login.drsnuggles.stderr.nl>
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
X-archive-position: 36453
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

Hi Michal,

On Wed, May 08, 2013 at 08:50:49AM -0600, Stephen Warren wrote:
> On 05/08/2013 04:59 AM, Matthijs Kooijman wrote:
> > In commit b40b25ff (kbuild: always run gcc -E on *.dts, remove cmd_dtc_cpp),
> > dts building was changed to always use the C preprocessor. This meant
> > that the .dts file passed to dtc is not the original, but the
> > preprocessed one.
> > 
> > When compiling with a separate build directory (i.e., with O=), this
> > preprocessed file will not live in the same directory as the original.
> > When the .dts file includes .dtsi files, dtc will look for them in the
> > build directory, not in the source directory and compilation will fail.
> > 
> > The commit referenced above tried to fix this by passing arch/*/boot/dts
> > as an include path to dtc. However, for mips, the .dts files are not in
> > this directory, so dts compilation on mips breaks for some targets.
> > 
> > Instead of hardcoding this particular include path, this commit just
> > uses the directory of the .dts file that is being compiled, which
> > effectively restores the previous behaviour wrt includes. For most .dts
> > files, this path is just the same as the previous hardcoded
> > arch/*/boot/dts path.
> > 
> > This was tested on a mips (rt3052) and an arm (bcm2835) target.
> 
> Reviewed-by: Stephen Warren <swarren@nvidia.com>

Did this patch look ok to you? If so, could you pick it up and send it
over to Linus for 3.10 (or should I send it directly)?

Gr.

Matthijs
