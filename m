Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Apr 2015 20:05:57 +0200 (CEST)
Received: from smtprelay0025.hostedemail.com ([216.40.44.25]:50513 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27009654AbbDASF4IcTsc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Apr 2015 20:05:56 +0200
Received: from filter.hostedemail.com (unknown [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 69B6212BCFE;
        Wed,  1 Apr 2015 18:05:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: dogs38_50825c1206c2f
X-Filterd-Recvd-Size: 3340
Received: from joe-X200MA.home (pool-71-119-66-80.lsanca.fios.verizon.net [71.119.66.80])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Wed,  1 Apr 2015 18:05:53 +0000 (UTC)
Message-ID: <1427911550.31790.56.camel@perches.com>
Subject: Re: [PATCH 1/1] ar7: replace mac address parsing
From:   Joe Perches <joe@perches.com>
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     Florian Fainelli <florian@openwrt.org>,
        Daniel Walter <dwalter@google.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 01 Apr 2015 11:05:50 -0700
In-Reply-To: <CAOiHx==91cquJ0OAf-n40HB39HbtLw-5RrxhxtsJXbTyNgit8w@mail.gmail.com>
References: <20140624153959.GA19564@google.com>
         <1403624918.29061.16.camel@joe-AO725>
         <CAGVrzcbgds+zHbTJWnUi48Nn1xPiEjGV7PGRmUX46da2CD+G=g@mail.gmail.com>
         <CAOiHx==91cquJ0OAf-n40HB39HbtLw-5RrxhxtsJXbTyNgit8w@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46692
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
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

On Wed, 2015-04-01 at 14:17 +0200, Jonas Gorski wrote:
> On Tue, Jun 24, 2014 at 9:26 PM, Florian Fainelli <florian@openwrt.org> wrote:
> > 2014-06-24 8:48 GMT-07:00 Joe Perches <joe@perches.com>:
> >> On Tue, 2014-06-24 at 16:39 +0100, Daniel Walter wrote:
> >>> Replace sscanf() with mac_pton().
> >> []
> >>> diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
> >> []
> >>> @@ -307,10 +307,7 @@ static void __init cpmac_get_mac(int instance, unsigned char *dev_addr)
> >>>       }
> >>>
> >>>       if (mac) {
> >>> -             if (sscanf(mac, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx",
> >>> -                                     &dev_addr[0], &dev_addr[1],
> >>> -                                     &dev_addr[2], &dev_addr[3],
> >>> -                                     &dev_addr[4], &dev_addr[5]) != 6) {
> >>> +             if (!mac_pton(mac, dev_addr)) {
> >>
> >> There is a slight functional change with this conversion.
> >>
> >> mac_pton is strict about leading 0's and requires a 17 char strlen.
> >
> > I do not have my devices handy, but I am fairly positive the use of
> > sscanf() was exactly for that, we may or may not have leading zeroes.
> > I am feeling a little uncomfortable with random code changes like that
> > without being actually able to test on real hardware that has a
> > variety of bootloaders and environment variables.
> 
> One of my two devices has a mac address with one of the numbers being
> < 16, and it uses a fixed length mac:
> 
> (psbl) printenv
> ...
> HWA_0           00:16:B6:2A:A4:3B
> 
> Also looking at the history[1] of this code, it looks like this was
> just an optimization of an earlier code which did expect 17 char len:
> 
>        for (i = 0; i < 6; i++)
>                dev_addr[i] = (char2hex(mac[i * 3]) << 4) +
>                        char2hex(mac[i * 3 + 1]);
> 
> 
> So I'm tempted to say it should not cause any issues. But my sample
> size is rather small.
> [1] d16f7093b6eb4f3859856f6ee4ab504cbeeea0b9

Wow Jonas, a 9 month thread gestation...

Given the old code and the commit comment, I'd
say it was almost certainly safe and my issue with
the patch resolved.
