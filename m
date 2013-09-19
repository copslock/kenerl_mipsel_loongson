Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Sep 2013 21:50:02 +0200 (CEST)
Received: from bsmtp.bon.at ([213.33.87.14]:20206 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827331Ab3ISTt57b9uQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 Sep 2013 21:49:57 +0200
Received: from dx.sixt.local (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTP id E9564CDF8B;
        Thu, 19 Sep 2013 21:49:50 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.sixt.local (Postfix) with ESMTP id 4F8D019F3F7;
        Thu, 19 Sep 2013 21:49:50 +0200 (CEST)
Message-ID: <523B555E.2070508@kdbg.org>
Date:   Thu, 19 Sep 2013 21:49:50 +0200
From:   Johannes Sixt <j6t@kdbg.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Grant Likely <grant.likely@linaro.org>,
        Rob Herring <rob.herring@calxeda.com>,
        devicetree@vger.kernel.org, git@vger.kernel.org,
        steven.hill@imgtec.com, mmarek@suse.cz, swarren@nvidia.com,
        linux-mips@linux-mips.org, linux-kbuild@vger.kernel.org,
        james.hogan@imgtec.com
Subject: Re: git issue / [PATCH] MIPS: fix invalid symbolic link file
References: <1379596148-32520-1-git-send-email-maddy@linux.vnet.ibm.com> <20130919133920.GA22468@linux-mips.org>
In-Reply-To: <20130919133920.GA22468@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <j6t@kdbg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37892
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: j6t@kdbg.org
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

Am 19.09.2013 15:39, schrieb Ralf Baechle:
> The original patch that introduced the symlink with the \n is kernel
> commit 3b29aa5ba204c62b3ec8f9f5b1ebd6e5d74f75d3 and is archived in
> patchwork at http://patchwork.linux-mips.org/patch/5745/  The patch
> file contains a \n at the end - but one would expect that from a
> patch file that has been transfered via email, so I'm not sure how this
> is supposed to work with emailed patches?!?

The mbox file I downloaded from this link looks like this:


arch/mips/boot/dts/include/dt-bindings | 1 +
 1 file changed, 1 insertion(+)
 create mode 120000 arch/mips/boot/dts/include/dt-bindings

\ No newline at end of file

diff --git a/.../include/dt-bindings b/.../include/dt-bindings
new file mode 120000
index 0000000..08c00e4
--- /dev/null
+++ b/arch/mips/boot/dts/include/dt-bindings
@@ -0,0 +1 @@
+../../../../../include/dt-bindings


but it should look like this:


arch/mips/boot/dts/include/dt-bindings | 1 +
 1 file changed, 1 insertion(+)
 create mode 120000 arch/mips/boot/dts/include/dt-bindings

diff --git a/.../include/dt-bindings b/.../include/dt-bindings
new file mode 120000
index 0000000..08c00e4
--- /dev/null
+++ b/arch/mips/boot/dts/include/dt-bindings
@@ -0,0 +1 @@
+../../../../../include/dt-bindings
\ No newline at end of file


Whoever or whatever moved the '\ No newline at end of file' line above
the patch text is to blame.

-- Hannes
