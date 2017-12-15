Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Dec 2017 18:12:37 +0100 (CET)
Received: from smtprelay0080.hostedemail.com ([216.40.44.80]:33075 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23994627AbdLORMajqr6R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Dec 2017 18:12:30 +0100
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 1F390837F27F;
        Fri, 15 Dec 2017 17:12:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: goat15_899453b65f742
X-Filterd-Recvd-Size: 1675
Received: from XPS-9350 (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Fri, 15 Dec 2017 17:12:25 +0000 (UTC)
Message-ID: <1513357944.4647.1.camel@perches.com>
Subject: Re: [PATCH v11 0/3] MIPS: Add virtual Ranchu board as a
 generic-based board
From:   Joe Perches <joe@perches.com>
To:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
        linux-mips@linux-mips.org
Cc:     Aleksandar Markovic <aleksandar.markovic@mips.com>,
        "David S. Miller" <davem@davemloft.net>,
        Douglas Leung <douglas.leung@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Hogan <james.hogan@mips.com>,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Paul Burton <paul.burton@mips.com>,
        Petar Jovanovic <petar.jovanovic@mips.com>,
        Raghu Gandham <raghu.gandham@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Randy Dunlap <rdunlap@infradead.org>
Date:   Fri, 15 Dec 2017 09:12:24 -0800
In-Reply-To: <1513356553-7238-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1513356553-7238-1-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61485
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

On Fri, 2017-12-15 at 17:48 +0100, Aleksandar Markovic wrote:
> Checkpatch script outputs a small number of warnings if applied to
> this series. We did not correct the code, since we think the code is
> correct for those particular cases of checkpatch warnings.

What are those warnings?  I don't see any.
