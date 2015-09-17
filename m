Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Sep 2015 23:45:06 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:54566 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008745AbbIQVpFIWbnG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Sep 2015 23:45:05 +0200
Received: from akpm3.mtv.corp.google.com (unknown [216.239.45.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 103AFBE8;
        Thu, 17 Sep 2015 21:44:56 +0000 (UTC)
Date:   Thu, 17 Sep 2015 14:44:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andy Gross <agross@codeaurora.org>
Cc:     Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-soc@vger.kernel.org,
        linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>,
        Paul Walmsley <paul@pwsan.com>,
        =?UTF-8?Q?Rafa=C5=82_?= =?UTF-8?Q?Mi=C5=82ecki?= 
        <zajec5@gmail.com>,
        Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: Re: [PATCH v2 0/3] Add __ioread32_copy() and use it
Message-Id: <20150917144455.8b414be4f89688bbdca39692@linux-foundation.org>
In-Reply-To: <20150917214218.GA6003@qualcomm.com>
References: <1442516531-16071-1-git-send-email-sboyd@codeaurora.org>
        <20150917125651.d7ab504539016a149ea871e6@linux-foundation.org>
        <20150917214218.GA6003@qualcomm.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49235
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
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

On Thu, 17 Sep 2015 16:42:18 -0500 Andy Gross <agross@codeaurora.org> wrote:

> > ho hum.  I think I'll go with plan B: merge just "lib: iomap_copy: Add
> > __ioread32_copy()" and send that into Linus promptly.  That way you
> > guys can sort out the driver patches in the usual fashion.
> > 
> 
> I just pulled in the original 8 patches and rebased.  My plans were to stage
> those in linux-next through my for-next.  Then add those on top just like you
> specified.  But i could go either way.

OK, please do that.
