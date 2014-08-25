Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Aug 2014 14:07:17 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:51769 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006715AbaHYMHQIc61v (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Aug 2014 14:07:16 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s7PC7D8B028390;
        Mon, 25 Aug 2014 14:07:13 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s7PC7CCp028389;
        Mon, 25 Aug 2014 14:07:12 +0200
Date:   Mon, 25 Aug 2014 14:07:12 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     chenj <chenj@lemote.com>
Cc:     linux-mips@linux-mips.org, chenhc@lemote.com
Subject: Re: [PATCH 1/2] mips: .../swab.h: fix a compiling failure
Message-ID: <20140825120712.GF27724@linux-mips.org>
References: <1408504488-12319-1-git-send-email-chenj@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1408504488-12319-1-git-send-email-chenj@lemote.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42217
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Wed, Aug 20, 2014 at 11:14:47AM +0800, chenj wrote:

> It was introduced in commit
> "mips: use wsbh/dsbh/dshd on Loongson3A"
> (http://patchwork.linux-mips.org/patch/7542/)

Thanks, folded into the original patch.

  Ralf
