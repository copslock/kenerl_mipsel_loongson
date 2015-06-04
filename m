Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2015 20:40:30 +0200 (CEST)
Received: from shards.monkeyblade.net ([149.20.54.216]:43773 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008230AbbFDSk3AwTtx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2015 20:40:29 +0200
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 08BE5588D80;
        Thu,  4 Jun 2015 11:40:24 -0700 (PDT)
Date:   Thu, 04 Jun 2015 11:40:21 -0700 (PDT)
Message-Id: <20150604.114021.2198304591433879318.davem@davemloft.net>
To:     markos.chandras@imgtec.com
Cc:     linux-mips@linux-mips.org, netdev@vger.kernel.org,
        ast@plumgrid.com, dborkman@redhat.com, hannes@stressinduktion.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] MIPS/BPF fixes for 4.3
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1433415376-20952-1-git-send-email-markos.chandras@imgtec.com>
References: <1433415376-20952-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: Mew version 6.6 on Emacs 24.5 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 04 Jun 2015 11:40:24 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47864
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
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


I think your Subject meant to say "fixes for 4.2" right?

Because we're currently finishing up 4.1.x and the next merge
window will be for 4.2.x
