Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Dec 2017 03:05:44 +0100 (CET)
Received: from smtprelay0073.hostedemail.com ([216.40.44.73]:40430 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990412AbdLKCFhD9Uvi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Dec 2017 03:05:37 +0100
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 343DE18029210;
        Mon, 11 Dec 2017 02:05:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: day19_87c653c0ac620
X-Filterd-Recvd-Size: 1838
Received: from XPS-9350 (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Mon, 11 Dec 2017 02:05:32 +0000 (UTC)
Message-ID: <1512957931.26342.31.camel@perches.com>
Subject: Re: [PATCH] TC: Delete an error message for a failed memory
 allocation in tc_bus_add_devices()
From:   Joe Perches <joe@perches.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        SF Markus Elfring <elfring@users.sourceforge.net>
Cc:     linux-mips@linux-mips.org,
        Ralf =?ISO-8859-1?Q?B=E4chle?= <ralf@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Date:   Sun, 10 Dec 2017 18:05:31 -0800
In-Reply-To: <alpine.LFD.2.21.1712102140570.4266@eddie.linux-mips.org>
References: <bfb63956-346c-aa17-5b06-fbe19ff0a5e3@users.sourceforge.net>
         <alpine.LFD.2.21.1712102140570.4266@eddie.linux-mips.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61397
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

On Sun, 2017-12-10 at 21:41 +0000, Maciej W. Rozycki wrote:
> On Sun, 10 Dec 2017, SF Markus Elfring wrote:
> 
> > Omit an extra message for a memory allocation failure in this function.
> > 
> > This issue was detected by using the Coccinelle software.
> 
>  And the problem here is?

Markus' terrible commit messages.

Generically, any OOM via a malloc like call has a dump_stack()
which shows a stack trace unless __GFP_NOWARN is used.

So this message is generally unnecessary as the dump_stack()
will show the tc_bus_add_devices function name and (now hashed)
value of the function address.

What will be different is the particular slot # of the tc_dev
will no longer be shown.

Really though, if there's an OOM on the init, there are larger
problems and the system will be unusable.
