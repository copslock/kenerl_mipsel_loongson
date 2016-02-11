Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Feb 2016 16:53:12 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:56090 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011283AbcBKPxKsrbhN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 11 Feb 2016 16:53:10 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6678DAB9D;
        Thu, 11 Feb 2016 15:53:10 +0000 (UTC)
Subject: Re: [PATCH] ld-version: Drop the 4th and 5th version components
To:     "Maciej W. Rozycki" <macro@imgtec.com>
References: <alpine.DEB.2.00.1602111359390.15885@tp.orcam.me.uk>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-kbuild@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
From:   Michal Marek <mmarek@suse.com>
Message-ID: <56BCAE65.5060103@suse.com>
Date:   Thu, 11 Feb 2016 16:53:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.00.1602111359390.15885@tp.orcam.me.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <mmarek@suse.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52010
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mmarek@suse.com
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

On 2016-02-11 15:25, Maciej W. Rozycki wrote:
> ... making upstream development binutils snapshots work as expected,
> e.g.:
> 
> $ mips64el-linux-ld --version
> GNU ld (GNU Binutils) 2.20.1.20100303
> [...]
> $ 
> 
> Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>

fwiw, Acked-by: Michal Marek <mmarek@suse.cz>


>  NB comments in scripts/Kbuild.include around `ld-version' have not been 
> accordingly updated in the course of changes made to `ld-version.sh' and 
> they still need such an update, unless we right-shift the version code 
> calculated back by 4 decimal digits, which I hesitated doing here for 
> simplicity.  What was the original reason to add the 4th and 5th 
> components?

No idea, but I don't think we will ever need this level of detail. So
yes, the script and its only in-tree user could be updated to divide the
numbers by 10000.

Michal
