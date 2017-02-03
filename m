Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Feb 2017 19:47:14 +0100 (CET)
Received: from smtprelay0020.hostedemail.com ([216.40.44.20]:47102 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993912AbdBCSrHK1xnx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Feb 2017 19:47:07 +0100
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 726579EA16;
        Fri,  3 Feb 2017 18:47:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: shop29_5ad673afd7632
X-Filterd-Recvd-Size: 929
Received: from XPS-9350 (unknown [47.151.132.55])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Fri,  3 Feb 2017 18:47:04 +0000 (UTC)
Message-ID: <1486147623.22276.70.camel@perches.com>
Subject: Is it time to move drivers/staging/netlogic/ out of staging?
From:   Joe Perches <joe@perches.com>
To:     Ganesan Ramalingam <ganesanr@broadcom.com>,
        Jayachandran Chandrashekaran Nair <jchandra@broadcom.com>
Cc:     Greg Kroah-Hartman <gregkh@suse.de>, devel@driverdev.osuosl.org,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Date:   Fri, 03 Feb 2017 10:47:03 -0800
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.22.3-0ubuntu0.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56628
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

64 bit stats isn't implemented, but is that really necessary?
Anything else?

It seems like the driver doesn't need to be there anymore.
