Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jan 2016 19:19:25 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:37148 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27014696AbcAGSTXZlnPe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 7 Jan 2016 19:19:23 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u07IJMKg013833;
        Thu, 7 Jan 2016 19:19:22 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u07IJKDG013832;
        Thu, 7 Jan 2016 19:19:20 +0100
Date:   Thu, 7 Jan 2016 19:19:20 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Michal Marek <mmarek@suse.com>,
        linux-kbuild@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH] ld-version: fix it on Fedora
Message-ID: <20160107181920.GE17031@linux-mips.org>
References: <1452189189-31188-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1452189189-31188-1-git-send-email-mst@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50965
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

On Thu, Jan 07, 2016 at 07:55:24PM +0200, Michael S. Tsirkin wrote:

> On Fedora 23, ld --version outputs:
> GNU ld version 2.25-15.fc23
> 
> But ld-version.sh fails to parse this, so e.g.  mips build fails to
> enable VDSO, printing a warning that binutils >= 2.24 is required.
> 
> To fix, teach ld-version to parse this format.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> Which tree should this be merged through? Mine? MIPS?

MIPS is the sole user of ld-ifversion at this time and taking this through
the MIPS tree will avoid possible merge conflicts with James Hogan's
pending d5ece1cb074b2c7082c9a2948ac598dd0ad40657 fix ("Fix ld-version.sh to
handle large 3rd version part").  So I think I should take this through
the MIPS tree.

Thanks!

  Ralf
