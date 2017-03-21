Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Mar 2017 20:27:22 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:36960 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993889AbdCUT1JXnMGa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 21 Mar 2017 20:27:09 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v2LJR7uB008911;
        Tue, 21 Mar 2017 20:27:08 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v2LJR7V4008910;
        Tue, 21 Mar 2017 20:27:07 +0100
Date:   Tue, 21 Mar 2017 20:27:07 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mips@linux-mips.org, james.hogan@imgtec.com
Subject: Re: [PATCH] MIPS: Disable Werror when W= is set
Message-ID: <20170321192707.GA8897@linux-mips.org>
References: <20170317010612.11990-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170317010612.11990-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57404
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

On Thu, Mar 16, 2017 at 06:06:12PM -0700, Florian Fainelli wrote:

> Using any value for W= will lead to a ton of warnings which are turned
> into fatal errors because MIPS adds -Werror to arch/mips/*.

Imho a fairly reasonable way of dealing with the complicatios of by -Werror.

Applied,

  Ralf
