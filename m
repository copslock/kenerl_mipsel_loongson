Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jul 2015 22:41:14 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:52200 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011515AbbG0UlM4tqmG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Jul 2015 22:41:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=lLm2p2biQ9Jw8boiBIXlFrBLaw5XHwNCN2s9v5yFT4w=;
        b=k8HlwJclqbPLEtdiMgt9rY6AZoqAYWKanhwh1SUh5ns2a72aaYpFdoU/FEJ15mMSPEmq49019eohAHtr2BrlnVgSPtEGDfxu0wBtzJ3LqiRLslrkfyv4t4s590a7zNptB0dTJVJXbcsgTgNLpNd+LI7WTamH5qISEkYb5GmuJTs=;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:55192 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.85)
        (envelope-from <linux@roeck-us.net>)
        id 1ZJpCs-003sy8-Jy; Mon, 27 Jul 2015 20:41:07 +0000
Date:   Mon, 27 Jul 2015 13:41:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: Crash in -next due to 'MIPS: Move FP usage checks into
 protected_{save, restore}_fp_context'
Message-ID: <20150727204104.GA1198@roeck-us.net>
References: <20150715160918.GA27653@roeck-us.net>
 <20150727150652.GA1756@roeck-us.net>
 <20150727172142.GE7289@NP-P-BURTON>
 <20150727174622.GA10708@roeck-us.net>
 <20150727180442.GG7289@NP-P-BURTON>
 <20150727194401.GC14674@roeck-us.net>
 <20150727200214.GH7289@NP-P-BURTON>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150727200214.GH7289@NP-P-BURTON>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48475
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

Hi Paul,

On Mon, Jul 27, 2015 at 01:02:14PM -0700, Paul Burton wrote:
> 
> Hi Guenter,
> 
> I'm currently mailing out v2 of the series which should fix your
> problem. It was an issue where the kernel would check the FP context for
> whether a SIGFPE should be generated even in cases where FP had not been
> used by userland, and thus had not been initialised. My userland is
> hard float & thus makes use of the FPU early whilst I believe yours is
> soft float, which explains the difference in behaviour.
> 
> I think the endian difference probably boils down to what garbage the
> initial FP context contained.
> 
Thanks a lot for the fix!

Guenter
