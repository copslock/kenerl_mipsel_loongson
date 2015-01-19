Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2015 20:07:06 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:39488 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011712AbbASTHExCZqm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Jan 2015 20:07:04 +0100
Date:   Mon, 19 Jan 2015 19:07:04 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH RFC v2 12/70] MIPS: asm: asmmacro: Replace add instructions
 with "addui"
In-Reply-To: <54BD3355.9010104@imgtec.com>
Message-ID: <alpine.LFD.2.11.1501191901370.28301@eddie.linux-mips.org>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-13-git-send-email-markos.chandras@imgtec.com> <alpine.LFD.2.11.1501190651440.28301@eddie.linux-mips.org> <54BD3355.9010104@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45325
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

On Mon, 19 Jan 2015, Markos Chandras wrote:

> sorry i might be missing something but why do you think this is an
> important bug fix that should go into 3.19? the way i read the code it
> seems that it can't go wrong at the moment.

 We shouldn't be using trapping instructions for address calculation.  
These macros have been wrong since the beginning, the MSA instructions 
they correspond to do not trigger an exception on an integer overflow in 
address calculation (none of the MIPS instruction does).

  Maciej
