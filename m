Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Dec 2017 22:41:45 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23990424AbdLJVleF2g0P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 10 Dec 2017 22:41:34 +0100
Date:   Sun, 10 Dec 2017 21:41:34 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     SF Markus Elfring <elfring@users.sourceforge.net>
cc:     linux-mips@linux-mips.org,
        =?UTF-8?Q?Ralf_B=C3=A4chle?= <ralf@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] TC: Delete an error message for a failed memory allocation
 in tc_bus_add_devices()
In-Reply-To: <bfb63956-346c-aa17-5b06-fbe19ff0a5e3@users.sourceforge.net>
Message-ID: <alpine.LFD.2.21.1712102140570.4266@eddie.linux-mips.org>
References: <bfb63956-346c-aa17-5b06-fbe19ff0a5e3@users.sourceforge.net>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61396
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Sun, 10 Dec 2017, SF Markus Elfring wrote:

> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.

 And the problem here is?

  Maciej
