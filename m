Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Oct 2015 23:35:14 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:52469 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27011797AbbJ2WfMtdd1D (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 29 Oct 2015 23:35:12 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id t9TMZBAa013466;
        Thu, 29 Oct 2015 23:35:11 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id t9TMZBHJ013465;
        Thu, 29 Oct 2015 23:35:11 +0100
Date:   Thu, 29 Oct 2015 23:35:11 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Matthew Fortune <Matthew.Fortune@imgtec.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>
Subject: Re: old OCTEON bootloaders and .MIPS.abiflags
Message-ID: <20151029223511.GM26009@linux-mips.org>
References: <20151028195436.GB1838@blackmetal.musicnaut.iki.fi>
 <6D39441BF12EF246A7ABCE6654B0235361C6AA6F@LEMAIL01.le.imgtec.org>
 <20151029213544.GL26009@linux-mips.org>
 <6D39441BF12EF246A7ABCE6654B0235361C6CD52@LEMAIL01.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6D39441BF12EF246A7ABCE6654B0235361C6CD52@LEMAIL01.le.imgtec.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49772
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

On Thu, Oct 29, 2015 at 10:15:01PM +0000, Matthew Fortune wrote:

> >From the first implementation of .MIPS.abiflags the linker does not invent this section
> other than by merging input sections called .MIPS.abiflags so if the input sections
> are DISCARD'd then you will never see a .MIPS.abiflags output section nor the associated
> program header.
> 
> I'm 99% sure of the above.

Great.

Aaro is going to resubmit this patch with some additional changes suggested
by David Daney on IRC so I'm going to drop this patch.

  Ralf
