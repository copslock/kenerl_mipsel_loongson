Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2016 14:52:54 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:42788 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27029582AbcEQMwp004al (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 May 2016 14:52:45 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u4HCqeWo005747;
        Tue, 17 May 2016 14:52:40 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u4HCqcNU005743;
        Tue, 17 May 2016 14:52:38 +0200
Date:   Tue, 17 May 2016 14:52:38 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: perf: Fix I6400 event numbers
Message-ID: <20160517125238.GE14481@linux-mips.org>
References: <1463423555-5184-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1463423555-5184-1-git-send-email-james.hogan@imgtec.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53482
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

On Mon, May 16, 2016 at 07:32:35PM +0100, James Hogan wrote:

> Fix perf hardware performance counter event numbers for I6400. This core
> does not follow the performance event numbering scheme of previous MIPS
> cores. All performance counters (both odd and even) are capable of
> counting any of the available events.
> 
> Fixes: 4e88a8621301 ("MIPS: Add cases for CPU_I6400")

Thanks, applied.

  Ralf
