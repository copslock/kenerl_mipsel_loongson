Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 May 2017 21:44:08 +0200 (CEST)
Received: from smtprelay0180.hostedemail.com ([216.40.44.180]:40904 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23994781AbdEXToBTNouJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 May 2017 21:44:01 +0200
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 7EDA812BD05;
        Wed, 24 May 2017 19:43:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: need98_55e76f99fc3c
X-Filterd-Recvd-Size: 1422
Received: from XPS-9350 (unknown [47.151.132.55])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Wed, 24 May 2017 19:43:56 +0000 (UTC)
Message-ID: <1495655035.2093.86.camel@perches.com>
Subject: Re: [PATCH] MIPS: Octeon: Delete an error message for a failed
 memory allocation in octeon_irq_init_gpio()
From:   Joe Perches <joe@perches.com>
To:     SF Markus Elfring <elfring@users.sourceforge.net>
Cc:     linux-mips@linux-mips.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        David Daney <david.daney@cavium.com>,
        Ralf =?ISO-8859-1?Q?B=E4chle?= <ralf@linux-mips.org>,
        "Steven J. Hill" <steven.hill@cavium.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Date:   Wed, 24 May 2017 12:43:55 -0700
In-Reply-To: <71a2ce6a-968c-b13c-95b0-610f0c1bab03@users.sourceforge.net>
References: <7995eb17-f2ec-54ad-f4d4-7b3dd8337d33@users.sourceforge.net>
         <1495565752.2093.69.camel@perches.com>
         <71a2ce6a-968c-b13c-95b0-610f0c1bab03@users.sourceforge.net>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.22.6-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57995
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

On Wed, 2017-05-24 at 18:01 +0200, SF Markus Elfring wrote:
> I am curious if I will stumble on a similar change possibility once more
> for remaining update candidates in other software areas.

Only if you keep your eyes open to the possibilities.
