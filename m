Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Mar 2014 09:47:47 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:36232 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6821114AbaCSIrpK6Mb1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Mar 2014 09:47:45 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s2J8lhtL007070;
        Wed, 19 Mar 2014 09:47:43 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s2J8lgCN007069;
        Wed, 19 Mar 2014 09:47:42 +0100
Date:   Wed, 19 Mar 2014 09:47:42 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [3.14 FIX][PATCH] MIPS: BCM47XX: Check all (32) GPIOs when
 looking for a pin
Message-ID: <20140319084742.GR4365@linux-mips.org>
References: <1392310092-27365-1-git-send-email-zajec5@gmail.com>
 <53237502.20305@hauke-m.de>
 <CACna6rwzB_eD+SfTo6gc20ec9O4-0+6R5ZajgEMuqx6fzHnumg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACna6rwzB_eD+SfTo6gc20ec9O4-0+6R5ZajgEMuqx6fzHnumg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39501
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

On Wed, Mar 19, 2014 at 07:43:17AM +0100, Rafał Miłecki wrote:
> Date:   Wed, 19 Mar 2014 07:43:17 +0100
> From: Rafał Miłecki <zajec5@gmail.com>
> To: Hauke Mehrtens <hauke@hauke-m.de>
> Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, Ralf Baechle
>  <ralf@linux-mips.org>
> Subject: Re: [3.14 FIX][PATCH] MIPS: BCM47XX: Check all (32) GPIOs when
>  looking for a pin
> Content-Type: text/plain; charset=UTF-8
> 
> 2014-03-14 22:30 GMT+01:00 Hauke Mehrtens <hauke@hauke-m.de>:
> > On 02/13/2014 05:48 PM, Rafał Miłecki wrote:
> >> Broadcom boards support 32 GPIOs and NVRAM may have entires for higher
> >> ones too. Example:
> >> gpio23=wombo_reset
> >>
> >> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
> >
> > Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
> 
> Ralf: could you get it for 3.15 at least, please?

Funny, I applied your patch minutes before seeing this email.

  Ralf
