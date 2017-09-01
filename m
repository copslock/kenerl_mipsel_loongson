Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Sep 2017 10:43:10 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:53152 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992213AbdIAIm5ijACN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 1 Sep 2017 10:42:57 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v818gte5019970;
        Fri, 1 Sep 2017 10:42:55 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v818gt9o019969;
        Fri, 1 Sep 2017 10:42:55 +0200
Date:   Fri, 1 Sep 2017 10:42:55 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH v2 2/7] MIPS: numa: Remove the unused parent_node() macro
Message-ID: <20170901084255.GA19890@linux-mips.org>
References: <1504234599-29533-1-git-send-email-douly.fnst@cn.fujitsu.com>
 <1504234599-29533-3-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504234599-29533-3-git-send-email-douly.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59906
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

On Fri, Sep 01, 2017 at 10:56:34AM +0800, Dou Liyang wrote:

> Commit a7be6e5a7f8d ("mm: drop useless local parameters of
> __register_one_node()") removes the last user of parent_node().
> 
> The parent_node() macros in both IP27 and Loongson64 are unnecessary.
> 
> Remove it for cleanup.

I already applied v1.

Thanks,

  Ralf
