Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 May 2013 17:00:19 +0200 (CEST)
Received: from avon.wwwdotorg.org ([70.85.31.133]:59837 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823763Ab3EHPAQzVEvm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 May 2013 17:00:16 +0200
Received: from severn.wwwdotorg.org (unknown [192.168.65.5])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPS id 56AD36358;
        Wed,  8 May 2013 09:04:45 -0600 (MDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by severn.wwwdotorg.org (Postfix) with ESMTPSA id C01FAE40FD;
        Wed,  8 May 2013 08:50:50 -0600 (MDT)
Message-ID: <518A6649.1020501@wwwdotorg.org>
Date:   Wed, 08 May 2013 08:50:49 -0600
From:   Stephen Warren <swarren@wwwdotorg.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To:     Matthijs Kooijman <matthijs@stdin.nl>
CC:     Michal Marek <mmarek@suse.cz>,
        Grant Likely <grant.likely@linaro.org>,
        Rob Herring <rob.herring@calxeda.com>,
        linux-kbuild@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH] kbuild: Don't assume dts files live in arch/*/boot/dts
References: <1368010744-11281-1-git-send-email-matthijs@stdin.nl>
In-Reply-To: <1368010744-11281-1-git-send-email-matthijs@stdin.nl>
X-Enigmail-Version: 1.4.6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.97.7 at avon.wwwdotorg.org
X-Virus-Status: Clean
Return-Path: <swarren@wwwdotorg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36356
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

On 05/08/2013 04:59 AM, Matthijs Kooijman wrote:
> In commit b40b25ff (kbuild: always run gcc -E on *.dts, remove cmd_dtc_cpp),
> dts building was changed to always use the C preprocessor. This meant
> that the .dts file passed to dtc is not the original, but the
> preprocessed one.
> 
> When compiling with a separate build directory (i.e., with O=), this
> preprocessed file will not live in the same directory as the original.
> When the .dts file includes .dtsi files, dtc will look for them in the
> build directory, not in the source directory and compilation will fail.
> 
> The commit referenced above tried to fix this by passing arch/*/boot/dts
> as an include path to dtc. However, for mips, the .dts files are not in
> this directory, so dts compilation on mips breaks for some targets.
> 
> Instead of hardcoding this particular include path, this commit just
> uses the directory of the .dts file that is being compiled, which
> effectively restores the previous behaviour wrt includes. For most .dts
> files, this path is just the same as the previous hardcoded
> arch/*/boot/dts path.
> 
> This was tested on a mips (rt3052) and an arm (bcm2835) target.

Reviewed-by: Stephen Warren <swarren@nvidia.com>

(although I wonder if the .dts files shouldn't be in a standard location?)
