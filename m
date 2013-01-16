Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jan 2013 15:50:20 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:40618 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6832230Ab3APOuTnbAxh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 16 Jan 2013 15:50:19 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r0GEo7qT022841;
        Wed, 16 Jan 2013 15:50:07 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r0GEo05T022821;
        Wed, 16 Jan 2013 15:50:00 +0100
Date:   Wed, 16 Jan 2013 15:50:00 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Arend van Spriel <arend@broadcom.com>
Cc:     Sergei Shtylyov <sshtylyov@mvista.com>, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [PATCH] mips: bcm47xx: select GPIOLIB for BCMA on bcm47xx
 platform
Message-ID: <20130116145000.GD26569@linux-mips.org>
References: <1357323005-28008-1-git-send-email-arend@broadcom.com>
 <50E80F78.9030901@mvista.com>
 <50E9E914.9030900@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50E9E914.9030900@broadcom.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35468
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sun, Jan 06, 2013 at 10:13:56PM +0100, Arend van Spriel wrote:

> >    This change doesn';t seem to be documented in your changelog. Maybe
> > it's worth another patch?
> > 
> > WBR, Sergei
> > 
> 
> Very observant. ;-) Yes. After fixing the other ones I got a warning on
> that one. I could resubmit the change with a more generic description or
> split it up as you suggest.
> 
> Ralf,
> 
> Please advice.

For simplicity's sake I'm going to split this myself BUT putting changes
that are not explained in changelog comments is a good way to get your
dear maintainer grumpy :)

  Ralf
