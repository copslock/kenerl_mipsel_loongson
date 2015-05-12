Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 May 2015 23:14:45 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:48151 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27026688AbbELVOnHcyat (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 12 May 2015 23:14:43 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t4CLEh2X021900;
        Tue, 12 May 2015 23:14:43 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t4CLEhBR021899;
        Tue, 12 May 2015 23:14:43 +0200
Date:   Tue, 12 May 2015 23:14:43 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Paul Martin <paul.martin@codethink.co.uk>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: Fix a preemption issue with thread's FPU
 defaults
Message-ID: <20150512211443.GA21142@linux-mips.org>
References: <alpine.LFD.2.11.1505121432540.1538@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.11.1505121432540.1538@eddie.linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47354
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

On Tue, May 12, 2015 at 03:20:57PM +0100, Maciej W. Rozycki wrote:

On systems with multiple types of FPUs this would also result in a
more consistent behaviour when a process is scheduled between different
CPUs.

  Ralf
