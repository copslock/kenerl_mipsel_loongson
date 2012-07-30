Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jul 2012 15:21:09 +0200 (CEST)
Received: from sam.nabble.com ([216.139.236.26]:55676 "EHLO sam.nabble.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903611Ab2G3NVB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Jul 2012 15:21:01 +0200
Received: from telerig.nabble.com ([192.168.236.162])
        by sam.nabble.com with esmtp (Exim 4.72)
        (envelope-from <lists@nabble.com>)
        id 1Svpu7-0002zs-Mb
        for linux-mips@linux-mips.org; Mon, 30 Jul 2012 06:20:59 -0700
Message-ID: <34230427.post@talk.nabble.com>
Date:   Mon, 30 Jul 2012 06:20:59 -0700 (PDT)
From:   JoeJ <tttechmail@gmail.com>
To:     linux-mips@linux-mips.org
Subject: Re: SMVP Support on MIPS34KC (linux-2.6.35)
In-Reply-To: <5012CDA4.5000008@realitydiluted.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: tttechmail@gmail.com
References: <34219711.post@talk.nabble.com> <5012CDA4.5000008@realitydiluted.com>
X-archive-position: 33996
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tttechmail@gmail.com
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


Hi Steve,

 Thanks for the suggestion. We moved to 3.4.2 kernel and observed the same
issue, ie System hangs while booting. In 3.4.2 port, we are using mips
timers (count & compare - csrc-r4k.c & cevt-r4k.c) as clocksource. The last
few prints on the console are : 

Synchronize counters across 2 CPUs: done.
NET: Registered protocol family 16
bio: create slab <bio-0> at 0
Switching to clocksource MIPS


As mentioned in my previous post, even with 3.4.2 kernel, the control loops
in stop_machine_cpu_stop function. Do you suspect anything here? 
btw, if we set "clocksource=jiffies" in the bootargs, the system boot goes
fine. The issue is observed only during switching from default clocksource
to MIPS clocksource. Also, the boot works fine with 'nosmp=1' option & MIPS
clocksource. 

Please suggest on the possible debug approach for this issue. 
 
Thanks for your support. 

Regards,
Joe



sjhill-3 wrote:
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hello Joe.
> 
> The 2.6.35.9 is obsolete with regards to SMVP support. You should grab the
> latest 3.4.2 kernel that has complete and working SMVP. To access it, do
> the
> following:
> 
> git clone git://git.linux-mips.org/pub/scm/linux-mti
> git checkout -b linux-mti-3.4.2 origin/linux-mti-3.4.2
> 
> Use the 'arch/mips/configs/maltasmvp_defconfig' as your base configuration
> file. If you have any issues, please let me know.
> 
> - -Steve
> 
> P.S. You can also reach me at <sjhill AT mips DOT com>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/
> 
> iEYEARECAAYFAlASzaQACgkQgyK5H2Ic36cjbACfcgtny/+QYPBNhiDqC0I9QIfV
> 4ZQAn2TlJWe+t2Jsriji2KAAtk8fwnu3
> =0aZ6
> -----END PGP SIGNATURE-----
> 
> 
> 

-- 
View this message in context: http://old.nabble.com/SMVP-Support-on-MIPS34KC-%28linux-2.6.35%29-tp34219711p34230427.html
Sent from the linux-mips main mailing list archive at Nabble.com.
