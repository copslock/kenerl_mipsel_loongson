Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Mar 2017 17:43:57 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:57666 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993873AbdCTQntuU-M9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 20 Mar 2017 17:43:49 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v2KGhm2B014259;
        Mon, 20 Mar 2017 17:43:48 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v2KGhmYU014258;
        Mon, 20 Mar 2017 17:43:48 +0100
Date:   Mon, 20 Mar 2017 17:43:48 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ben Hutchings <ben@decadent.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 4.4 04/35] MIPS: Update defconfigs for
 NF_CT_PROTO_DCCP/UDPLITE change
Message-ID: <20170320164347.GG14919@linux-mips.org>
References: <20170316142906.685052998@linuxfoundation.org>
 <20170316142906.994447562@linuxfoundation.org>
 <1489939516.2852.71.camel@decadent.org.uk>
 <20170320103052.GB3047@kroah.com>
 <CAK8P3a2Ud6iVEumhSzBpWwKN5SiuYOGSBT1ZAD=UiC8RNTv=SA@mail.gmail.com>
 <20170320162930.GA23463@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170320162930.GA23463@kroah.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57399
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

On Mon, Mar 20, 2017 at 05:29:30PM +0100, Greg Kroah-Hartman wrote:

> You reported it there, but then on your other emails for other stable
> trees, said that your previously mentioned patches fixed problems in
> these trees as well.  A bit confusing, sorry I got it wrong.
> 
> Anyway, not a big deal, is this worth me reverting?  Does this cause an
> issue with these arches on older kernels?

Can't imagine this is going to cause an issue and in case of doubt a "y"
should be safer than a "m" anyway ...

  Ralf
