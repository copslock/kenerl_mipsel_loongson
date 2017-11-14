Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 21:45:25 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:38950 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990901AbdKNUpSXZYil (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Nov 2017 21:45:18 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id vAEKjGBf026443;
        Tue, 14 Nov 2017 21:45:16 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id vAEKjFJk026442;
        Tue, 14 Nov 2017 21:45:15 +0100
Date:   Tue, 14 Nov 2017 21:45:15 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@mips.com>
Cc:     "Steven J. Hill" <steven.hill@cavium.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v3 04/11] MIPS: Octeon: Remove usage of cvmx_wait()
 everywhere.
Message-ID: <20171114204515.GD14758@linux-mips.org>
References: <1510633827-23548-1-git-send-email-steven.hill@cavium.com>
 <1510633827-23548-5-git-send-email-steven.hill@cavium.com>
 <20171114190828.GD16044@linux-mips.org>
 <20171114203046.GC5823@jhogan-linux.mipstec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171114203046.GC5823@jhogan-linux.mipstec.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60936
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

On Tue, Nov 14, 2017 at 08:30:47PM +0000, James Hogan wrote:

> On Tue, Nov 14, 2017 at 08:08:28PM +0100, Ralf Baechle wrote:
> > On Mon, Nov 13, 2017 at 10:30:20PM -0600, Steven J. Hill wrote:
> > > From: "Steven J. Hill" <Steven.Hill@cavium.com>
> > 
> > At this place and many others cvmx_wait() was used to wait for a number
> > of miliseconds, so I think it should better be replaced with something
> > like mdelay(10).
> 
> Note that this patch, along with the nudges one and the lastpfn one, is
> already queued for 4.15:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/mips.git
> branch: mips-next
> 
> so any fixes to it will have to be made on top.

Fair enough, leave 'em in.

  Ralf
