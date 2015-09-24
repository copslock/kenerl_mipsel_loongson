Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Sep 2015 09:07:52 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:55311 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27007687AbbIXHHsqNblb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 24 Sep 2015 09:07:48 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id t8O77j8L022006;
        Thu, 24 Sep 2015 09:07:45 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id t8O77ivS021997;
        Thu, 24 Sep 2015 09:07:44 +0200
Date:   Thu, 24 Sep 2015 09:07:44 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org
Subject: Re: linux-next: Tree for Sep 23
Message-ID: <20150924070744.GD21784@linux-mips.org>
References: <20150923142343.35797c0f@canb.auug.org.au>
 <20150923074207.GA27002@sudip-pc>
 <20150923214236.GA28778@NP-P-BURTON>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150923214236.GA28778@NP-P-BURTON>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49351
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

On Wed, Sep 23, 2015 at 02:42:36PM -0700, Paul Burton wrote:

> Hi Ralf,
> 
> That patch as I submitted it definitely adds arch/mips/mm/sc-debugfs.c
> but somehow that file has been lost from the commit in your
> mips-for-linux-next tree. Could you re-apply it?

Thanks for reporting.  The patch didn't apply cleanly and when applying
it manually I forgot to git-add the new file.  Of course the file was
in the local repo so my test builds did succeed.  I fixed that now.

  Ralf
