Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jun 2012 19:23:50 +0200 (CEST)
Received: from h9.dl5rb.org.uk ([81.2.74.9]:32966 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903704Ab2FNRXq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Jun 2012 19:23:46 +0200
Received: from h5.dl5rb.org.uk (h5.dl5rb.org.uk [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.5/8.14.3) with ESMTP id q5EHNeaD019930;
        Thu, 14 Jun 2012 18:23:40 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.5/8.14.5/Submit) id q5EHNdfd019922;
        Thu, 14 Jun 2012 18:23:39 +0100
Date:   Thu, 14 Jun 2012 18:23:39 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <david.daney@cavium.com>
Cc:     Jim Faulkner <jfaulkne@ccs.neu.edu>, linux-mips@linux-mips.org
Subject: Re: booting linux-3.3 or linux 3.4 on an SGI O2?
Message-ID: <20120614172338.GH12068@linux-mips.org>
References: <20120605190047.GA6263@alumni-linux.ccs.neu.edu>
 <4FCE593B.10808@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4FCE593B.10808@cavium.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33637
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, Jun 05, 2012 at 12:08:43PM -0700, David Daney wrote:

> On 06/05/2012 12:00 PM, Jim Faulkner wrote:
> >Hi all, I haven't been able to boot any kernels after linux 3.2 on my
> >SGI O2.  I've tried linux-3.3.5 and linux-3.4.0, but neither would boot.
> >Unfortunately I don't have further information such as a kernel panic,
> >since I don't get any video output after the kernel is loaded.  I've
> >attached my linux-3.4 .config.  Anybody know what patches I might need
> >to get the latest kernels booting on this system?
> >
> 
> I have had problems as well.
> 
> Someone should configure a serial console and early printk to see if
> they can see what is happening.

Could one of you bisect the bug?

  Ralf
