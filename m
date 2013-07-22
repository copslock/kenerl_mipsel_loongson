Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Jul 2013 07:05:02 +0200 (CEST)
Received: from mo10.iij4u.or.jp ([210.138.174.78]:35613 "EHLO mo.iij4u.or.jp"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6815757Ab3GVFE4GKxOe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 22 Jul 2013 07:04:56 +0200
Received: by mo.iij4u.or.jp (mo10) id r6M54bUe016120; Mon, 22 Jul 2013 14:04:37 +0900
Received: from delta (sannin29190.nirai.ne.jp [203.160.29.190])
        by mbox.iij4u.or.jp (mbox10) id r6M54YGb008000
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 22 Jul 2013 14:04:36 +0900
Date:   Mon, 22 Jul 2013 14:04:33 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Markos Chandras <hwoarang@gentoo.org>
Cc:     yuasa@linux-mips.org, ralf@linux-mips.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: ar7: fix redefined UNCAC_BASE and IO_BASE
Message-Id: <20130722140433.b905a6248b414c9f43e64b0c@linux-mips.org>
In-Reply-To: <CAG2jQ8hCwqtrw=Av6ZG2h19Z_HRuDmPn+LqpSJyQGhUSM=8=Pg@mail.gmail.com>
References: <20130719182611.41aeb79b5711b3c9f849d594@linux-mips.org>
        <CAG2jQ8hCwqtrw=Av6ZG2h19Z_HRuDmPn+LqpSJyQGhUSM=8=Pg@mail.gmail.com>
X-Mailer: Sylpheed 3.2.0beta5 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37339
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
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

Hi,

On Fri, 19 Jul 2013 12:35:36 +0100
Markos Chandras <hwoarang@gentoo.org> wrote:

> 
> Hi,
> 
> Isn't this similar to http://patchwork.linux-mips.org/patch/5583/ ?

Sure, thank you for pointing out.

I think that it is better to also include CAC_BASE.

Yoichi
