Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Apr 2015 17:08:51 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:38536 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27014946AbbDAPIs67dkm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Apr 2015 17:08:48 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t31F8nri027244;
        Wed, 1 Apr 2015 17:08:49 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t31F8mat027243;
        Wed, 1 Apr 2015 17:08:48 +0200
Date:   Wed, 1 Apr 2015 17:08:48 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     Florian Fainelli <florian@openwrt.org>,
        Joe Perches <joe@perches.com>,
        Daniel Walter <dwalter@google.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] ar7: replace mac address parsing
Message-ID: <20150401150848.GA27199@linux-mips.org>
References: <20140624153959.GA19564@google.com>
 <1403624918.29061.16.camel@joe-AO725>
 <CAGVrzcbgds+zHbTJWnUi48Nn1xPiEjGV7PGRmUX46da2CD+G=g@mail.gmail.com>
 <CAOiHx==91cquJ0OAf-n40HB39HbtLw-5RrxhxtsJXbTyNgit8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOiHx==91cquJ0OAf-n40HB39HbtLw-5RrxhxtsJXbTyNgit8w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46689
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

On Wed, Apr 01, 2015 at 02:17:16PM +0200, Jonas Gorski wrote:

>        for (i = 0; i < 6; i++)
>                dev_addr[i] = (char2hex(mac[i * 3]) << 4) +
>                        char2hex(mac[i * 3 + 1]);
> 
> 
> So I'm tempted to say it should not cause any issues. But my sample
> size is rather small.

4.1 is still long enough out to test ...

  Ralf
