Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Oct 2014 14:54:28 +0200 (CEST)
Received: from smtprelay0138.hostedemail.com ([216.40.44.138]:51695 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27009833AbaJFMy0Qm9Yz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Oct 2014 14:54:26 +0200
Received: from filter.hostedemail.com (ff-bigip1 [10.5.19.254])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 73DD829DDE4;
        Mon,  6 Oct 2014 12:54:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: mouth23_95005b23934a
X-Filterd-Recvd-Size: 1565
Received: from [192.168.1.155] (pool-71-103-235-196.lsanca.fios.verizon.net [71.103.235.196])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Mon,  6 Oct 2014 12:54:23 +0000 (UTC)
Message-ID: <1412600062.2916.19.camel@joe-AO725>
Subject: Re: [PATCH] mips: Convert pr_warning to pr_warn
From:   Joe Perches <joe@perches.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 06 Oct 2014 05:54:22 -0700
In-Reply-To: <20141006124915.GA29036@linux-mips.org>
References: <1412441442.3247.138.camel@joe-AO725>
         <20141006124915.GA29036@linux-mips.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42963
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
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

On Mon, 2014-10-06 at 14:49 +0200, Ralf Baechle wrote:
> On Sat, Oct 04, 2014 at 09:50:42AM -0700, Joe Perches wrote:
> 
> > Use the much more common pr_warn instead of pr_warning
> > with the goal of removing pr_warning eventually.
> 
> While I agree that only one of pr_warn and pr_warning deserves to live
> picking pr_warning introduces another logic inconsistency - for each
> pr_<foo> function there is a KERN_<FOO> severity symbol.  And that in
> this case is named KERN_WARNING, there's no KERN_WARN.

Yes, I know.  It's a consistency thing that can really
only be resolved one step at a time.

Most everything else uses _warn (dev_warn, netdev_warn,
etc...) so it'd be good to get pr_warn done too.

cheers, Joe
