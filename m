Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jul 2012 16:52:43 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:47595 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903645Ab2G3Owj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Jul 2012 16:52:39 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@realitydiluted.com>)
        id 1SvrKh-0006vk-7t; Mon, 30 Jul 2012 09:52:31 -0500
Message-ID: <50169FA7.8010603@realitydiluted.com>
Date:   Mon, 30 Jul 2012 09:52:23 -0500
From:   "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
MIME-Version: 1.0
To:     JoeJ <tttechmail@gmail.com>
CC:     linux-mips@linux-mips.org
Subject: Re: SMVP Support on MIPS34KC (linux-2.6.35)
References: <34219711.post@talk.nabble.com> <5012CDA4.5000008@realitydiluted.com> <34230427.post@talk.nabble.com>
In-Reply-To: <34230427.post@talk.nabble.com>
X-Enigmail-Version: 1.4.3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 33998
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/30/2012 08:20 AM, JoeJ wrote:
> 
> Synchronize counters across 2 CPUs: done. NET: Registered protocol family
> 16 bio: create slab <bio-0> at 0 Switching to clocksource MIPS
> 
> 
> As mentioned in my previous post, even with 3.4.2 kernel, the control
> loops in stop_machine_cpu_stop function. Do you suspect anything here? btw,
> if we set "clocksource=jiffies" in the bootargs, the system boot goes fine.
> The issue is observed only during switching from default clocksource to
> MIPS clocksource. Also, the boot works fine with 'nosmp=1' option & MIPS 
> clocksource.
> 
Make user that you select both CONFIG_CSRC_R4K ad CONFIG_CSRC_GIC for your
clock sources. The GIC counter will be used from synchronization across the
CPUs. Secondly, the hang is not actually a hard hang. Wait 50 seconds and I
bet you will see the boot complete.

- -Steve
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAWn6cACgkQgyK5H2Ic36f47wCbBM7J8Bl0iEyELwxx2sYHBRxZ
SukAniQlkEwYyNdolwPhi1vOJgxNrba+
=NW6E
-----END PGP SIGNATURE-----
