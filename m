Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 May 2013 10:16:07 +0200 (CEST)
Received: from cantor2.suse.de ([195.135.220.15]:46879 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823002Ab3EWIQDjLJmt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 May 2013 10:16:03 +0200
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F342CA51B7;
        Thu, 23 May 2013 10:15:56 +0200 (CEST)
Message-ID: <519DD039.4030107@suse.cz>
Date:   Thu, 23 May 2013 10:15:53 +0200
From:   Michal Marek <mmarek@suse.cz>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
MIME-Version: 1.0
To:     Stephen Warren <swarren@wwwdotorg.org>,
        Grant Likely <grant.likely@linaro.org>,
        Rob Herring <rob.herring@calxeda.com>,
        linux-kbuild@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH] kbuild: Don't assume dts files live in arch/*/boot/dts
References: <1368010744-11281-1-git-send-email-matthijs@stdin.nl> <518A6649.1020501@wwwdotorg.org> <20130518184101.GS25742@login.drsnuggles.stderr.nl>
In-Reply-To: <20130518184101.GS25742@login.drsnuggles.stderr.nl>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <mmarek@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36547
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mmarek@suse.cz
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

On 18.5.2013 20:41, Matthijs Kooijman wrote:
> Hi Michal,
> 
> On Wed, May 08, 2013 at 08:50:49AM -0600, Stephen Warren wrote:
>> On 05/08/2013 04:59 AM, Matthijs Kooijman wrote:
>>> In commit b40b25ff (kbuild: always run gcc -E on *.dts, remove cmd_dtc_cpp),
>>> dts building was changed to always use the C preprocessor. This meant
>>> that the .dts file passed to dtc is not the original, but the
>>> preprocessed one.
>>>
>>> When compiling with a separate build directory (i.e., with O=), this
>>> preprocessed file will not live in the same directory as the original.
>>> When the .dts file includes .dtsi files, dtc will look for them in the
>>> build directory, not in the source directory and compilation will fail.
>>>
>>> The commit referenced above tried to fix this by passing arch/*/boot/dts
>>> as an include path to dtc. However, for mips, the .dts files are not in
>>> this directory, so dts compilation on mips breaks for some targets.
>>>
>>> Instead of hardcoding this particular include path, this commit just
>>> uses the directory of the .dts file that is being compiled, which
>>> effectively restores the previous behaviour wrt includes. For most .dts
>>> files, this path is just the same as the previous hardcoded
>>> arch/*/boot/dts path.
>>>
>>> This was tested on a mips (rt3052) and an arm (bcm2835) target.
>>
>> Reviewed-by: Stephen Warren <swarren@nvidia.com>
> 
> Did this patch look ok to you? If so, could you pick it up and send it
> over to Linus for 3.10 (or should I send it directly)?

I applied the patch to kbuild.git#rc-fixes now.

Michal
