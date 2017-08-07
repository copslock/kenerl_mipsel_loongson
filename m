Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Aug 2017 23:36:19 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:35000 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23995120AbdHGVgHNZflM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Aug 2017 23:36:07 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v77La3jL025292;
        Mon, 7 Aug 2017 23:36:04 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v77La3mZ025291;
        Mon, 7 Aug 2017 23:36:03 +0200
Date:   Mon, 7 Aug 2017 23:36:03 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Nathan Sullivan <nathan.sullivan@ni.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] MIPS: NI 169445 board support
Message-ID: <20170807213603.GE3509@linux-mips.org>
References: <1500402549-12090-1-git-send-email-nathan.sullivan@ni.com>
 <20170807152648.GA13214@linux-mips.org>
 <11583742.zienCqJRO5@np-p-burton>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11583742.zienCqJRO5@np-p-burton>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59400
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

On Mon, Aug 07, 2017 at 10:24:05AM -0700, Paul Burton wrote:

> One possibility would be for us to split the board portions of vmlinux.its.S 
> out into a file per-board, perhaps board-boston.its.S, board-ni169445.its.S 
> etc. The build process would then have to concatenate the right files to 
> generate the full image tree source.
> 
> Does that sound good to you?

Yes, that sounds good.

  Ralf
