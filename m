Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Sep 2013 15:39:36 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:55711 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6832658Ab3ISNjacu0xN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 Sep 2013 15:39:30 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r8JDdQCu026209;
        Thu, 19 Sep 2013 15:39:26 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r8JDdKaW026208;
        Thu, 19 Sep 2013 15:39:20 +0200
Date:   Thu, 19 Sep 2013 15:39:20 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Grant Likely <grant.likely@linaro.org>,
        Rob Herring <rob.herring@calxeda.com>,
        devicetree@vger.kernel.org, git@vger.kernel.org
Cc:     steven.hill@imgtec.com, mmarek@suse.cz, swarren@nvidia.com,
        linux-mips@linux-mips.org, linux-kbuild@vger.kernel.org,
        james.hogan@imgtec.com
Subject: Re: git issue / [PATCH] MIPS: fix invalid symbolic link file
Message-ID: <20130919133920.GA22468@linux-mips.org>
References: <1379596148-32520-1-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1379596148-32520-1-git-send-email-maddy@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37881
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

On Thu, Sep 19, 2013 at 06:39:08PM +0530, Madhavan Srinivasan wrote:

(Git folks, please read on.)

>    Commit 3b29aa5ba204c created a symlink file in include/dt-bindings.
>    Even though commit diff is fine, symlink is invalid.
>    ls -lb shows a newline character at the end of the filename.
> 
> lrwxrwxrwx 1 maddy maddy 35 Sep 19 18:11 dt-bindings ->
> ../../../../../include/dt-bindings\n
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
>  arch/mips/boot/dts/include/dt-bindings |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/boot/dts/include/dt-bindings b/arch/mips/boot/dts/include/dt-bindings
> index 68ae388..08c00e4 120000
> --- a/arch/mips/boot/dts/include/dt-bindings
> +++ b/arch/mips/boot/dts/include/dt-bindings
> @@ -1 +1 @@
> -../../../../../include/dt-bindings
> +../../../../../include/dt-bindings
> \ No newline at end of file
> -- 
> 1.7.10.4

I applied your patch - but now git-show shows it as an empty commit and

  ls -lb arch/mips/boot/dts/include/dt-bindings

still shows the \n at the end of the link target.  Things are looking ok
now that I manually fixed the link and commited the result.  I hope
git-push and git-pull are going to handle this correct.

So, I wonder if this is a git bug.

The original patch that introduced the symlink with the \n is kernel
commit 3b29aa5ba204c62b3ec8f9f5b1ebd6e5d74f75d3 and is archived in
patchwork at http://patchwork.linux-mips.org/patch/5745/  The patch
file contains a \n at the end - but one would expect that from a
patch file that has been transfered via email, so I'm not sure how this
is supposed to work with emailed patches?!?

Anyway, I'm not too fond of sylinks in the tree or in patches and I'm
wondering if we could get rid of them for something more bullet proof.

  Ralf
