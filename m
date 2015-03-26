Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Mar 2015 14:52:25 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:57853 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006155AbbCZNwYAaVRU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Mar 2015 14:52:24 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t2QDqLa6013881;
        Thu, 26 Mar 2015 14:52:21 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t2QDqLHK013880;
        Thu, 26 Mar 2015 14:52:21 +0100
Date:   Thu, 26 Mar 2015 14:52:21 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Valentin Rothberg <valentinrothberg@gmail.com>,
        Jaedon Shin <jaedon.shin@gmail.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Bolle <pebolle@tiscali.nl>,
        Andreas Ruprecht <rupran@einserver.de>,
        hengelein Stefan <stefan.hengelein@fau.de>
Subject: Re: MIPS: BMIPS: broken select on RAW_IRQ_ACCESSORS
Message-ID: <20150326135220.GE9705@linux-mips.org>
References: <CAD3Xx4LMq1F8cDSR=17c3ViOML2ZYaL4d1ApkEog6bftSwKAPQ@mail.gmail.com>
 <CAJiQ=7DxwwWFts_ckcsusxRgTW+FYd2S32pgj48Pb2xYqKJ8LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJiQ=7DxwwWFts_ckcsusxRgTW+FYd2S32pgj48Pb2xYqKJ8LA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46544
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

On Thu, Mar 26, 2015 at 06:41:36AM -0700, Kevin Cernekee wrote:

> http://patchwork.linux-mips.org/patch/8254/
> 
> We wound up configuring this through DT rather than Kconfig.
> 
> Ralf, would you prefer an incremental patch or a whole new submission?

Whatever you prefer.

  Ralf
