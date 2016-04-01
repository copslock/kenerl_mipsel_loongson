Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Apr 2016 13:01:47 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45384 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27025932AbcDALBov3RqY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 1 Apr 2016 13:01:44 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u31B1X56024351;
        Fri, 1 Apr 2016 13:01:33 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u31B1Ui8024350;
        Fri, 1 Apr 2016 13:01:30 +0200
Date:   Fri, 1 Apr 2016 13:01:30 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Daney <david.daney@cavium.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Jiri Olsa <jolsa@redhat.com>, Wang Nan <wangnan0@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] perf tools: Hook up MIPS unwind and dwarf-regs in
 the Makefile
Message-ID: <20160401110130.GA18967@linux-mips.org>
References: <cover.1459501014.git.ralf@linux-mips.org>
 <a3a7e99203ceaf662dc61895418c76e837eaf6ab.1459501014.git.ralf@linux-mips.org>
 <56FE545A.7090003@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56FE545A.7090003@cogentembedded.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52830
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

On Fri, Apr 01, 2016 at 01:58:34PM +0300, Sergei Shtylyov wrote:

> On 4/1/2016 11:56 AM, Ralf Baechle wrote:
> 
> >From: David Daney <david.daney@cavium.com>
> >
> >Define a new symbol (ARCH_SUPPORTS_LIBUNWIND) in config/Makefile.
> 
>    Eh? Where is it?
> 
> >Use this from x86 and MIPS to gate testing of libunwind.
> 
>    x86? Where?

ARCH_SUPPORTS_LIBUNWIND was unused in the original version of the patch
and I removed it but didn't update the comment.

  Ralf
