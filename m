Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Sep 2013 17:12:13 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:59109 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6827343Ab3ICPMLIlnus (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Sep 2013 17:12:11 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r83FC5S4015167;
        Tue, 3 Sep 2013 17:12:05 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r83FBw0h015166;
        Tue, 3 Sep 2013 17:11:58 +0200
Date:   Tue, 3 Sep 2013 17:11:58 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Stephen Warren <swarren@wwwdotorg.org>
Cc:     James Hogan <james.hogan@imgtec.com>,
        Stephen Warren <swarren@nvidia.com>,
        Michal Marek <mmarek@suse.cz>,
        Shawn Guo <shawn.guo@linaro.org>,
        Ian Campbell <ian.campbell@citrix.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Rob Herring <rob.herring@calxeda.com>,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] MIPS: add <dt-bindings/> symlink
Message-ID: <20130903151158.GB14258@linux-mips.org>
References: <1377095762-18926-1-git-send-email-james.hogan@imgtec.com>
 <521505E2.3050308@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <521505E2.3050308@wwwdotorg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37749
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Wed, Aug 21, 2013 at 12:24:34PM -0600, Stephen Warren wrote:

> On 08/21/2013 08:36 AM, James Hogan wrote:
> > Add symlink to include/dt-bindings from arch/mips/boot/dts/include/ to
> > match the ones in ARM and Meta architectures so that preprocessed device
> > tree files can include various useful constant definitions.
> > 
> > See commit c58299a (kbuild: create an "include chroot" for DT bindings)
> > merged in v3.10-rc1 for details.
> > 
> > MIPS structures it's dts files a little differently to other
> > architectures, having a separate dts directory for each SoC/platform,
> > but most of the definitions in the dt-bindings/ directory are common so
> > for now lets just have a single "include chroot" for all MIPS platforms.
> 
> Acked-by: Stephen Warren <swarren@nvidia.com>

Applied - but I'd be happier if there was a way of achiving the same thing
without symlinks.

  Ralf
