Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 11:46:05 +0100 (CET)
Received: from s3.sipsolutions.net ([5.9.151.49]:44146 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010707AbcA0KqECk4pM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Jan 2016 11:46:04 +0100
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86)
        (envelope-from <johannes@sipsolutions.net>)
        id 1aONbn-0004Xp-Q4; Wed, 27 Jan 2016 11:45:55 +0100
Message-ID: <1453891554.2351.1.camel@sipsolutions.net>
Subject: Re: [PATCH RFC 2/2] MIPS: dt: Explicitly specify native endian
 behaviour for syscon
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jonas Gorski <jogo@openwrt.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Simon Arlott <simon@fire.lp0.eu>, Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 27 Jan 2016 11:45:54 +0100
In-Reply-To: <CAOiHx=kk06ythGn=a3UGs-BBUUYxdm7zLsNtBFiCiwxF5m6VxA@mail.gmail.com>
References: <1453848410-24949-1-git-send-email-broonie@kernel.org>
         <1453848410-24949-2-git-send-email-broonie@kernel.org>
         <56A7FE3F.5090909@gmail.com>
         <CAOiHx=kk06ythGn=a3UGs-BBUUYxdm7zLsNtBFiCiwxF5m6VxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <johannes@sipsolutions.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51470
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: johannes@sipsolutions.net
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

On Wed, 2016-01-27 at 11:33 +0100, Jonas Gorski wrote:
> 
> > +++ b/arch/mips/boot/dts/brcm/bcm6368.dtsi
> > @@ -54,7 +54,7 @@
> >                 periph_cntl: syscon@10000000 {
> >                         compatible = "syscon";
> >                         reg = <0x10000000 0x14>;
> > -                       little-endian;
> > +                       native-endian;
> 
> But native-endian == big-endian usually for bcm63xx, so is this
> actually a bugfix?
> 

It's complicated :)

These were originally specified as little-endian because it _worked_,
but that was only because of an issue with the code - it was getting
byteswapped twice.

This was "fixed" in commit 29bb45f25ff3051354ed330c0d0f10418a2b8c7c,
and I assume this DT file was created/copied before that commit and
didn't get that update due to merge delays. So after that commit, this
file couldn't have worked, but that's how it got to this point.

johannes
