Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 13:17:04 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:44080 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6818476Ab3FJLQwqGVAi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Jun 2013 13:16:52 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5ABGl0U031388;
        Mon, 10 Jun 2013 13:16:47 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5ABGg4B031387;
        Mon, 10 Jun 2013 13:16:42 +0200
Date:   Mon, 10 Jun 2013 13:16:42 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     David Daney <david.s.daney@gmail.com>,
        Gleb Natapov <gleb@redhat.com>,
        David Daney <ddaney@caviumnetworks.com>,
        David Daney <ddaney.cavm@gmail.com>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, Sanjay Lal <sanjayl@kymasys.com>,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 00/31] KVM/MIPS: Implement hardware virtualization via
 the MIPS-VZ extensions.
Message-ID: <20130610111642.GF28380@linux-mips.org>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
 <51B26974.5000306@caviumnetworks.com>
 <20130609073115.GE4725@redhat.com>
 <51B50E87.2060501@gmail.com>
 <alpine.LFD.2.03.1306100030210.18329@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.03.1306100030210.18329@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36796
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

On Mon, Jun 10, 2013 at 12:40:42AM +0100, Maciej W. Rozycki wrote:

> > >   How different MIPS SMP systems are?
> > 
> > o Old SGI heavy metal (several different system architectures).
> > 
> > o Cavium OCTEON SMP SoCs.
> > 
> > o Broadcom (several flavors) SoCs
> > 
> > o Loongson
> 
> o Old DEC hardware (DECsystem 58x0, R3000-based).
> 
> o Malta-based MIPS Technologies CMP solutions (1004K, 1074K, interAptiv).

And more.  It's fairly accurate that MIPS SMP system tend to have little
of their system architecture in common beyond the underlying processor
architecture and everything else should be treated as a lucky coincidence.

  Ralf
