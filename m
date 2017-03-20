Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Mar 2017 11:15:38 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:44668 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991532AbdCTKPbSflrR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 20 Mar 2017 11:15:31 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v2KAFUpm000983;
        Mon, 20 Mar 2017 11:15:30 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v2KAFUd2000982;
        Mon, 20 Mar 2017 11:15:30 +0100
Date:   Mon, 20 Mar 2017 11:15:30 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH 4.4 08/35] MIPS: Update lemote2f_defconfig for
 CPU_FREQ_STAT change
Message-ID: <20170320101530.GD14919@linux-mips.org>
References: <20170316142906.685052998@linuxfoundation.org>
 <20170316142907.261390617@linuxfoundation.org>
 <1489939579.2852.72.camel@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1489939579.2852.72.camel@decadent.org.uk>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57392
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

On Sun, Mar 19, 2017 at 04:06:19PM +0000, Ben Hutchings wrote:

> On Thu, 2017-03-16 at 23:29 +0900, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > commit b3f6046186ef45acfeebc5a59c9fb45cefc685e7 upstream.
> > 
> > Since linux-4.8, CPU_FREQ_STAT is a bool symbol, causing a warning in
> > kernelci.org:
> > 
> > arch/mips/configs/lemote2f_defconfig:42:warning: symbol value 'm' invalid for CPU_FREQ_STAT
> > 
> > This updates the defconfig to have the feature built-in.
> > 
> > Fixes: 1aefc75b2449 ("cpufreq: stats: Make the stats code non-modular")
> [...]
> 
> So not needed for 4.4?

I don't think so, I don't get warnings for "make ARCH=mips lemote2f_defconfig"

  Ralf
