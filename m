Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jun 2014 14:24:57 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:44885 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6854770AbaFCMYyPdzbR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Jun 2014 14:24:54 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s53COqf3032178;
        Tue, 3 Jun 2014 14:24:52 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s53COpZT032177;
        Tue, 3 Jun 2014 14:24:51 +0200
Date:   Tue, 3 Jun 2014 14:24:51 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Kconfig: microMIPS and SmartMIPS are mutually
 exclusive
Message-ID: <20140603122451.GS17197@linux-mips.org>
References: <1401785177-7904-1-git-send-email-markos.chandras@imgtec.com>
 <20140603093434.GQ17197@linux-mips.org>
 <alpine.LFD.2.11.1406031214390.18344@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.11.1406031214390.18344@eddie.linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40418
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

On Tue, Jun 03, 2014 at 12:18:43PM +0100, Maciej W. Rozycki wrote:

>  Do we need this CPU_HAS_SMARTMIPS setting at all?  Can't we just 
> save/restore this SmartMIPS ACX register on context switches where 
> available (straightforward to detect at the run time) and have the 
> relevant pieces of code excluded (#ifdef-ed out or suchlike) on 
> non-supported configurations such as microMIPS or MIPS64?

SmartMIPS has new instructions which are hardcoded in various assembler
fragments, where something like if (cpu_has_smartmips) won't work.
So until a more complex solution is implemented CPU_HAS_SMARTMIPS is
what there is.

  Ralf
