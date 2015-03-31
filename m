Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2015 02:14:59 +0200 (CEST)
Received: from smtprelay0127.hostedemail.com ([216.40.44.127]:54188 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010169AbbCaAO40GYbl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Mar 2015 02:14:56 +0200
Received: from filter.hostedemail.com (unknown [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 684C923415;
        Tue, 31 Mar 2015 00:14:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: men18_81907e89b7e3c
X-Filterd-Recvd-Size: 2146
Received: from joe-X200MA.home (pool-71-119-66-80.lsanca.fios.verizon.net [71.119.66.80])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Tue, 31 Mar 2015 00:14:50 +0000 (UTC)
Message-ID: <1427760888.14276.37.camel@perches.com>
Subject: Re: [PATCH 00/25] treewide: Use bool function return values of
 true/false not 1/0
From:   Joe Perches <joe@perches.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        linux-omap@vger.kernel.org, kvm-ppc@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-ide@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
        linux-mm@kvack.org, linux-pm@vger.kernel.org,
        netdev@vger.kernel.org, alsa-devel@alsa-project.org,
        bridge@lists.linux-foundation.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, patches@opensource.wolfsonmicro.com,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-security-module@vger.kernel.org
Date:   Mon, 30 Mar 2015 17:14:48 -0700
In-Reply-To: <5519E53B.5040504@schaufler-ca.com>
References: <cover.1427759009.git.joe@perches.com>
         <5519E53B.5040504@schaufler-ca.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46633
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

On Mon, 2015-03-30 at 17:07 -0700, Casey Schaufler wrote:
> On 3/30/2015 4:45 PM, Joe Perches wrote:
> > Joe Perches (25):
> >   arm: Use bool function return values of true/false not 1/0

[etc...]

> Why, and why these in particular?

bool functions are probably better returning
bool values instead of 1 and 0.

Especially when the functions intermix returning
returning 1/0 and true/false.

(there are only a couple of those though)

These are all the remaining instances in the
kernel tree.
