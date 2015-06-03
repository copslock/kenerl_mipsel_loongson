Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2015 10:26:47 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:37596 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27026922AbbFCI0pylxBP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Jun 2015 10:26:45 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t538QeqI012984;
        Wed, 3 Jun 2015 10:26:40 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t538QcT2012983;
        Wed, 3 Jun 2015 10:26:38 +0200
Date:   Wed, 3 Jun 2015 10:26:38 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Grant Likely <grant.likely@linaro.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] of: clean-up unnecessary libfdt include paths
Message-ID: <20150603082638.GJ9839@linux-mips.org>
References: <1433308225-13874-1-git-send-email-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1433308225-13874-1-git-send-email-robh@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47829
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

On Wed, Jun 03, 2015 at 12:10:25AM -0500, Rob Herring wrote:
> Date:   Wed,  3 Jun 2015 00:10:25 -0500
> From: Rob Herring <robh@kernel.org>
> To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
> Cc: Grant Likely <grant.likely@linaro.org>, Rob Herring <robh@kernel.org>,
>  Ralf Baechle <ralf@linux-mips.org>, Benjamin Herrenschmidt
>  <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
>  Ellerman <mpe@ellerman.id.au>, linux-mips@linux-mips.org,
>  linuxppc-dev@lists.ozlabs.org
> Subject: [PATCH] of: clean-up unnecessary libfdt include paths
> 
> With the latest dtc import include fixups, it is no longer necessary to
> add explicit include paths to use libfdt. Remove these across the
> kernel.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: linux-mips@linux-mips.org
> Cc: linuxppc-dev@lists.ozlabs.org

For the MIPS bits;

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
