Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Mar 2010 18:00:42 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:57017 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492193Ab0CRRAi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 18 Mar 2010 18:00:38 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o2IH0YKx013522;
        Thu, 18 Mar 2010 18:00:34 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o2IH0VcS013520;
        Thu, 18 Mar 2010 18:00:31 +0100
Date:   Thu, 18 Mar 2010 18:00:30 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jean Delvare <khali@linux-fr.org>
Cc:     Yang Shi <yang.shi@windriver.com>, ddaney@caviumnetworks.com,
        ben-linux@fluff.org, linux-mips@linux-mips.org,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH V2] MIPS: Octeon: Register EEPROM device on the I2C bus
Message-ID: <20100318170030.GJ4554@linux-mips.org>
References: <1268026190-18300-1-git-send-email-yang.shi@windriver.com>
 <20100316180946.GC20160@linux-mips.org>
 <20100316200647.3803edf1@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100316200647.3803edf1@hyperion.delvare>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26262
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 16, 2010 at 08:06:47PM +0100, Jean Delvare wrote:

> The Linux kernel doesn't care, but user-space may. As a matter of fact,
> there is a script out there (decode-dimms, in the i2c-tools package)
> decoding the SPD data and presenting it to the user. Some people want
> to know the details about their memory modules.
> 
> > I also wonder how this will work for configurations with multiple memory
> > modules thus multiple SPD EEPROMS.
> 
> The kernel code should instantiate one spd device per memory module
> (assuming they are all reachable.) Obviously this can't be done in a
> static way.

SPD is virtually omnipresent these days so I wonder if maybe there already
is some probing functionality already available?

  Ralf
