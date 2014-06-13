Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jun 2014 15:46:42 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:48152 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6843059AbaFMNqkcw4Lh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 Jun 2014 15:46:40 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s5DDkYL7002727;
        Fri, 13 Jun 2014 15:46:34 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s5DDkUHL002719;
        Fri, 13 Jun 2014 15:46:30 +0200
Date:   Fri, 13 Jun 2014 15:46:30 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     David Daney <david.daney@cavium.com>,
        James Hogan <james.hogan@imgtec.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        kvm@vger.kernel.org
Subject: Re: mips: Accidental removal of paravirt_cpus_done?
Message-ID: <20140613134630.GG31294@linux-mips.org>
References: <CAMuHMdWSXBw554dy4mTGu9dGbhtKCfVE1=13QP1ykV=BkkBrnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWSXBw554dy4mTGu9dGbhtKCfVE1=13QP1ykV=BkkBrnw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40513
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

On Fri, Jun 13, 2014 at 12:02:30PM +0200, Geert Uytterhoeven wrote:

> It seems you accidentally assimilated an (unwanted?) kvm change in my
> patch:

I accidentally must have done a git commit --amend with the wrong
patch on top, sorry about that.  The change itself was intensional.

  Ralf
