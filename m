Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2015 19:38:24 +0100 (CET)
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:43403 "EHLO
        filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009730AbbAUSiXEz5A6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Jan 2015 19:38:23 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri1.pp.htv.fi (Postfix) with ESMTP id 7C46921B882;
        Wed, 21 Jan 2015 20:38:22 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
        with ESMTP id 3iQVTHVpMD1k; Wed, 21 Jan 2015 20:38:17 +0200 (EET)
Received: from fuloong-minipc (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp5.welho.com (Postfix) with ESMTP id 843B85BC004;
        Wed, 21 Jan 2015 20:38:17 +0200 (EET)
Date:   Wed, 21 Jan 2015 20:38:17 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
Cc:     Joshua Kinard <kumba@gentoo.org>,
        David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Display CPU byteorder in /proc/cpuinfo
Message-ID: <20150121183817.GB644@fuloong-minipc.musicnaut.iki.fi>
References: <54BCC827.3020806@gentoo.org>
 <54BEDF3C.6040105@gmail.com>
 <54BF12B9.8000507@gentoo.org>
 <54BF14D2.70006@gentoo.org>
 <54BF7DE6.6050704@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54BF7DE6.6050704@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45420
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

On Wed, Jan 21, 2015 at 10:22:30AM +0000, Markos Chandras wrote:
> I believe this patch is mostly useful for cores that can boot in both LE
> and BE so being able to tell the byteorder from cpuinfo can be helpful
> at times. Having readelf and other tools in your userland may not always
> be the case, but you surely have "cat" :)
> 
> So that patch looks good to me but i think the #ifdefs can be avoided.
> Can we use
> 
> if (config_enabled(CONFIG_CPU_BIG_ENDIAN) {

Kernel has already support making whole .config available in /proc
where you can check such things.

A.
